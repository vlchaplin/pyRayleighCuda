#include <cuda.h>
#include <cufft.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
#include <helper_cuda.h>
#include <helper_functions.h>

#include "BioheatCUDA.h"

#include <assert.h>

#ifndef BIOHEAT_CUH
#define BIOHEAT_CUH

#define FDRadius 1
#define FD_FIXEDVAL_BOUNDARYCOND 0
#define FD_FREEFLOW_BOUNDARYCOND 1

#ifndef ROWMAJ2d
#define ROWMAJ2d(i,j,Ni,Nj) ( (i)*Nj + (j) )
#define COLMAJ2d(i,j,Ni,Nj) ( (j)*Ni + (i) )

#define ROWMAJ3d(i,j,k,Ni,Nj,Nk) ( (i)*Nj*Nk + (j)*Nk + (k) )
#define ROWMAJ3d(i,j,k,Ni,Nj,Nk) ( (k)*Ni*Nj + (j)*Ni + (i) )
#endif

__global__ void testEmptyKernel() {
	return;
};

template <typename pbhe_t>
__global__ void Pennes_2ndOrder_cuda_kernel(
	pbhe_t * temp3D_tf, pbhe_t * temp3D_ti, pbhe_t * tdot3D, pbhe_t * kt3D, pbhe_t * rhoCp3D,
	int nx, int ny, int nz)
{
	__constant__ int boundaryConditionMode;
	__constant__ pbhe_t rhoCpBlood;
	__constant__ pbhe_t perfusionRate, Tb;
	__constant__ pbhe_t pbheDt, pbheDx, pbheDy, pbheDz, dxdx, dydy, dzdz;

	bool inBounds=true;
	int boundaryConditionHit;

	//# voxels we'll compute per block is sni*snj*snk and the
	//# stencil voxels per block that we'll to do it need is:
	// nVox = 2*radius*(Ni*Nk + Ni*Nj + Nj*Nk) + Ni*Nj*Nk
	// Ni x Nj x Nk is the dimension of the output block that's being written. radius=1 below

	//Size of shared memory.  Output voxels will be written 1 per kernel launch, but shared mem needs to be bigger for the halo

	const int sni = 1; // this is because we're only computing j-k slices per thread block
	int snj = blockDim.x + 2; //add the radius=1 halo
	int snk = blockDim.y + 2;

	int numSharedVox = snj*snk;
	//Shared memory for this set of threads (i.e. one block)
	__shared__  pbhe_t Tvals_shared[numSharedVox];
	//__shared__  pbhe_t rhoCp_shared[numSharedVox];
	__shared__  pbhe_t kHeat_shared[numSharedVox];

	pbhe_t rhoCp;


	//indices of data voxel (have to subtract 2 b/c of the halo on each side)
	//thread & block x will be mapped to voxel direction j 
	//thread & block y will be mapped to voxel direction k 
	unsigned int vj = blockIdx.x * blockDim.x + threadIdx.x ;
	unsigned int vk = blockIdx.y * blockDim.y + threadIdx.y ;
	
	//block z is mapped to voxel i
	unsigned int vi = blockIdx.z;

	int voxel;
	int tx = threadIdx.x ;
	int ty = threadIdx.y ;
	int s, sj, sk;

	//From the (0,0) thread, Load the boundary data into shared memory for this block
	if (tx == 0 && ty == 0) {

		for (sk = 0; sk < snk; sk++)
		{
			//sj = 0
			//voxel = vi*ny*nz + (0 + vj - 1)*nz + sk + vk - 1;
			//s = sk*snj + 0;

			voxel = ROWMAJ3d(vi, vj - 1, sk + vk - 1, nx, ny, nz);
			s = COLMAJ2d(0, sk, snj, snk);

			
			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];

			//sj = snj-1
			//voxel = vi*ny*nz + (snj - 1 + vj - 1)*nz + sk + vk - 1;
			//s = sk*snj + snj-1;
			voxel = ROWMAJ3d(vi, (snj - 1 + vj - 1), (sk + vk - 1), nx, ny, nz);
			s = COLMAJ2d(snj-1, sk, snj, snk);
			
			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];
		}
			
		for (sj = 0; sj < snj; sj++)
		{
			//sk = 0
			//voxel = vi*ny*nz + (sj + vj - 1)*nz + 0 + vk - 1;
			//s = 0*snj + sj;

			voxel = ROWMAJ3d(vi, (sj + vj - 1), vk-1, nx, ny, nz);
			s = COLMAJ2d(sj, 0, snj, snk);

			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];

			//sk = snk-1
			//voxel = vi*ny*nz + (snj + vj - 1)*nz + snk-1 + vk - 1;
			//s = (snk-1)*snj + sj;

			voxel = ROWMAJ3d(vi, (sj + vj - 1), (snk - 1 + vk - 1), nx, ny, nz);
			s = COLMAJ2d(sj, snk - 1, snj, snk);

			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];
		}
	} 
	

	sj = tx + 1;
	sk = ty + 1;
	s = COLMAJ2d(sj, sk, snj, snk);

	// invocation should have block dims = (8,4,0)*( fx,fy,0 ) where fx+fy = (#threadsPerBlock/32) (and fx,fy are ints >=1)
	// and grid dims = ( 1 + ny /  blockDim.x, 1 + nz /  blockDim.y , nx) and 
	if (vi < nx && vj < ny && vk < nz)
	{
		
		voxel = vi*ny*nz + vj*nz + vk;
		Tvals_shared[s] = temp3D_ti[voxel];
		kHeat_shared[s] = kt3D[voxel];

		//rhoCp_shared[s] = rhoCp3D[voxel];
		rhoCp = rhoCp3D[voxel];

		if (vi == 0)
			boundaryConditionHit = 1;
		if (vi == nx - 1)
			boundaryConditionHit = 2;
		if (vj == 0)
			boundaryConditionHit = 3;
		if (vj == ny - 1)
			boundaryConditionHit = 4;
		if (vk == 0)
			boundaryConditionHit = 5;
		if (vk == nz - 1)
			boundaryConditionHit = 6;
		else
			boundaryConditionHit = 0;
	}
	else {
		// do nothing and wait for __syncthreads(), then exit thread
		inBounds = false;
	}

	//... now sync before doing anything with the tile. 
	//  This ensures it will have been fully defined across every thread in this block prior to accessing it's values.
	__sycthreads();

	if (!inBounds)
		return;

	//Now compute 
	int outvoxel = vi*ny*nz + vj*nz + vk;


	//First handle a global boundary condition case (i.e., the output voxel is on the edge of the simulation grid)
	if (boundaryConditionHit && boundaryConditionMode == FD_FIXEDVAL_BOUNDARYCOND)
	{
		temp3D_tf[outvoxel] = Tvals_shared[s];
		return;
	}
	else if (boundaryConditionHit && boundaryConditionMode == FD_FREEFLOW_BOUNDARYCOND)
	{
		if (boundaryConditionHit == 1) //copy x+1
			temp3D_tf[outvoxel] = temp3D_ti[(vi + 1)*ny*nz + vj*nz + vk];
		else if (boundaryConditionHit == 2) //copy x-1
			temp3D_tf[outvoxel] = temp3D_ti[(vi - 1)*ny*nz + vj*nz + vk];
		else if (boundaryConditionHit == 3) //copy y+1
			temp3D_tf[outvoxel] = Tvals_shared[(sk + 1)*snj + sj];
		else if (boundaryConditionHit == 4) //copy y-1
			temp3D_tf[outvoxel] = Tvals_shared[(sk - 1)*snj + sj];
		else if (boundaryConditionHit == 5) //copy z+1
			temp3D_tf[outvoxel] = Tvals_shared[sk*snj + sj + 1];
		else if (boundaryConditionHit == 6) //copy z-1
			temp3D_tf[outvoxel] = Tvals_shared[sk*snj + sj - 1];

		return;
	}

	//Now check if we are on a block boundary

	//Need to check that we are on the interior of the stencil.
	if (sk < FDRadius || sj < FDRadius || sj >= (snj - FDRadius) || sk >= (snk - FDRadius))
	{
		//Need to add global boundary condition case
		return;
	}


	int s1;
	pbhe_t Dxyz = kHeat_shared[s] / rhoCp;

	//additive constant
	temp3D_tf[outvoxel] = pbheDt*tdot3D[outvoxel] + Tb*perfusionRate*pbheDt*rhoCpBlood / rhoCp;

	//Txyz coefficient
	temp3D_tf[outvoxel] += Tvals_shared[s] * (1 - 2 * pbheDt*Dxyz*(1.0 / dxdx + 1.0 / dydy + 1.0 / dzdz) - perfusionRate*pbheDt*rhoCpBlood / rhoCp);

	//{data x-> voxel i, data y-> voxel j-> data z-> voxel k}
	//{ thread x-> voxel j, thread y-> voxel k }

	//y+1 term from shared memory.  
	s1 = (sk + 1)*snj + sj;
	temp3D_tf[outvoxel] += Tvals_shared[s1] * (pbheDt / dydy)*(Dxyz + pbheDt*kHeat_shared[s1] / rhoCp);

	//y-1
	s1 = (sk - 1)*snj + sj;
	//voxel = vi*ny*nz + (vj - 1)*nz + vk;
	temp3D_tf[outvoxel] += Tvals_shared[s1] * (pbheDt / dydy)*(Dxyz - pbheDt*kHeat_shared[s1] / rhoCp);

	//z+1
	s1 = sk*snj + sj + 1;
	//voxel = vi*ny*nz + vj*nz + vk + 1;
	temp3D_tf[outvoxel] += Tvals_shared[s1] * (pbheDt / dzdz)*(Dxyz + pbheDt*kHeat_shared[s1] / rhoCp);

	//z-1
	s1 = sk*snj + sj - 1;
	//voxel = vi*ny*nz + vj*nz + vk - 1;
	temp3D_tf[outvoxel] += Tvals_shared[s1] * (pbheDt / dzdz)*(Dxyz - pbheDt*kHeat_shared[s1] / rhoCp);


	//x+1 (not stored in shared mem)
	voxel = (vi + 1)*ny*nz + vj*nz + vk;
	temp3D_tf[outvoxel] += temp3D_ti[voxel]*(pbheDt / dxdx)*(Dxyz + pbheDt*kt3D[voxel] / rhoCp);
	//x-1
	voxel = (vi - 1)*ny*nz + vj*nz + vk;
	temp3D_tf[outvoxel] += temp3D_ti[voxel]*(pbheDt / dxdx)*(Dxyz - pbheDt*kt3D[voxel] / rhoCp);


}

#endif