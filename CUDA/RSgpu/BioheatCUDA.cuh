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
#define MAX_NUMELLS_SHARED_ARRAY 600

#ifndef ROWMAJ2d
#define ROWMAJ2d(i,j,Ni,Nj) ( (i)*Nj + (j) )
#define COLMAJ2d(i,j,Ni,Nj) ( (j)*Ni + (i) )
//#define COLMAJ2d(j,i,Nj,Ni) ( (j)*Ni + (i) )

#define ROWMAJ3d(i,j,k,Ni,Nj,Nk) ( (i)*Nj*Nk + (j)*Nk + (k) )
#define COLMAJ3d(i,j,k,Ni,Nj,Nk) ( (k)*Ni*Nj + (j)*Ni + (i) )
#endif

__global__ void testEmptyKernel() {
	return;
};

// invocation should have block dims = (8,4,0)*( fx,fy,0 ) where fx+fy = (#threadsPerBlock/32) (and fx,fy are ints >=1)
// and grid dims = ( 1 + ny /  blockDim.x, 1 + nz /  blockDim.y , nx) and 
template <typename pbhe_t>
__global__ void Pennes_2ndOrder_cuda_kernel(
	pbhe_t * temp3D_tf, pbhe_t * temp3D_ti, pbhe_t * tdot3D, pbhe_t * kt3D, pbhe_t * rhoCp3D,
	pbhe_t * Dtxyz, pbhe_t Tb, pbhe_t perfusionRate,
	int nx, int ny, int nz, int boundaryConditionMode = FD_FREEFLOW_BOUNDARYCOND)
{
	/*
	__constant__ int boundaryConditionMode;
	__constant__ pbhe_t rhoCpBlood;
	__constant__ pbhe_t perfusionRate, Tb;
	__constant__ pbhe_t pbheDt, pbheDx, pbheDy, pbheDz, dxdx, dydy, dzdz;
	*/

	const pbhe_t rhoCpBlood = 1060 * 4100;
	pbhe_t dxdx = Dtxyz[1] * Dtxyz[1];
	pbhe_t dydy = Dtxyz[2] * Dtxyz[2];
	pbhe_t dzdz = Dtxyz[3] * Dtxyz[3];

	bool inBounds=true;
	int boundaryConditionHit;

	//# voxels we'll compute per block is sni*snj*snk and the
	//# stencil voxels per block that we'll need is:
	// nVox = 2*radius*(Ni*Nk + Ni*Nj + Nj*Nk) + Ni*Nj*Nk
	// Ni x Nj x Nk is the dimension of the output block that's being written. radius=1 below

	//Size of shared memory.  Output voxels will be written 1 per kernel launch, but shared mem needs to be bigger for the halo

	const int sni = 1; // this is because we're only computing j-k slices per thread block
	const int snj = blockDim.x + 2; //add the radius=1 halo
	const int snk = blockDim.y + 2;
	const int numSharedVox = snj*snk;

	if (numSharedVox > MAX_NUMELLS_SHARED_ARRAY){
		assert(0);
	}

	//Shared memory for this set of threads (i.e. one block)
	__shared__  pbhe_t Tvals_shared[MAX_NUMELLS_SHARED_ARRAY];
	//__shared__  pbhe_t rhoCp_shared[numSharedVox];
	__shared__  pbhe_t kHeat_shared[MAX_NUMELLS_SHARED_ARRAY];

	pbhe_t rhoCp;


	//indices of data voxel (have to subtract 2 b/c of the halo on each side)
	//thread & block x will be mapped to voxel direction j 
	//thread & block y will be mapped to voxel direction k 
	unsigned int vj = blockIdx.x * blockDim.x + threadIdx.x ;
	unsigned int vk = blockIdx.y * blockDim.y + threadIdx.y ;
	
	//block z is mapped to voxel i
	unsigned int vi = blockIdx.z;

	int voxel, outvoxel;
	int tx = threadIdx.x ;
	int ty = threadIdx.y ;
	int s, sj, sk;

	//Determine if we are on a global boundary
	boundaryConditionHit = 0;
	if (vi == 0)
		boundaryConditionHit = 1;
	else if (vi == nx - 1)
		boundaryConditionHit = 2;

	if (vj == 0)
		boundaryConditionHit += 4;
	else if (vj == ny - 1)
		boundaryConditionHit += 8;

	if (vk == 0)
		boundaryConditionHit += 16;
	else if (vk == nz - 1)
		boundaryConditionHit += 32;
	
	if ((vi >= nx || vj >= ny || vk >= nz))
	{
		inBounds = false;
	}
	else {
		inBounds = true;
		outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);

		if (tx == 0)
		{
			//Fill in halo to the left
			s = COLMAJ2d(tx, ty + 1, snj, snk);
			Tvals_shared[s] = temp3D_ti[outvoxel];
			kHeat_shared[s] = kt3D[outvoxel];
		}
		else if ((boundaryConditionHit & 8) || tx == (blockDim.x - 1))
		{
			//Fill in halo to the right
			s = COLMAJ2d(tx + 2, ty + 1, snj, snk);
			Tvals_shared[s] = temp3D_ti[outvoxel];
			kHeat_shared[s] = kt3D[outvoxel];
		}

		if (ty == 0)
		{
			//Fill in the halo below
			s = COLMAJ2d(tx + 1, ty, snj, snk);
			Tvals_shared[s] = temp3D_ti[outvoxel];
			kHeat_shared[s] = kt3D[outvoxel];
		}
		else if ((boundaryConditionHit & 32) || ty == (blockDim.y - 1))
		{
			//Fill in halo to above
			s = COLMAJ2d(tx + 1, ty + 2, snj, snk);
			Tvals_shared[s] = temp3D_ti[outvoxel];
			kHeat_shared[s] = kt3D[outvoxel];
		}

	}

	

	if (inBounds)
	{
		//Now set the shared memory offset index s for this thread
		sj = tx + 1;
		sk = ty + 1;
		s = COLMAJ2d(sj, sk, snj, snk);

		//Now compute 
		outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);

		if (outvoxel >= nx*ny*nz)
			assert(0);

		Tvals_shared[s] = temp3D_ti[outvoxel];
		kHeat_shared[s] = kt3D[outvoxel];
	}
	

	//... now sync before doing anything with the tile. 
	//  This ensures it will have been fully defined across every thread in this block prior to accessing it's values.
	__syncthreads();

	if (!inBounds)
		return;

	sj = tx + 1;
	sk = ty + 1;
	s = COLMAJ2d(sj, sk, snj, snk);
	outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);

	//numaccess[outvoxel] = boundaryConditionHit;

	int s1;
	pbhe_t Dxyz;

	//First handle a global boundary condition hit (i.e., the output voxel is on the edge of the simulation grid)
	if (boundaryConditionHit && boundaryConditionMode == FD_FIXEDVAL_BOUNDARYCOND)
	{
		//If b.c.'s are fixed, can read straight away from the shared memory for this voxel.
		temp3D_tf[outvoxel] = Tvals_shared[s];
	}
	else if (boundaryConditionHit==0) {

		//If not on the interior of the global grid, compute function values.
		//This has to be done and threads syncronized before handling f'=0 boudary conditions

		rhoCp = rhoCp3D[outvoxel];
		Dxyz = kHeat_shared[s] / rhoCp;

		//additive constant
		temp3D_tf[outvoxel] = Dtxyz[0] * tdot3D[outvoxel] + Tb*perfusionRate*Dtxyz[0] * rhoCpBlood / rhoCp;

		//Txyz coefficient
		temp3D_tf[outvoxel] += Tvals_shared[s] * (1 - 2 * Dtxyz[0] * Dxyz*(1.0 / dxdx + 1.0 / dydy + 1.0 / dzdz) - perfusionRate*Dtxyz[0] * rhoCpBlood / rhoCp);

		//{data x-> voxel i, data y-> voxel j-> data z-> voxel k}
		//{ thread x-> voxel j, thread y-> voxel k }

		//return;
		//y+1 term from shared memory.  
		s1 = (sk + 1)*snj + sj;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dydy)*(Dxyz + Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//y-1
		s1 = (sk - 1)*snj + sj;
		//voxel = vi*ny*nz + (vj - 1)*nz + vk;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dydy)*(Dxyz - Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//z+1
		s1 = sk*snj + sj + 1;
		//voxel = vi*ny*nz + vj*nz + vk + 1;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dzdz)*(Dxyz + Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//z-1
		s1 = sk*snj + sj - 1;
		//voxel = vi*ny*nz + vj*nz + vk - 1;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dzdz)*(Dxyz - Dtxyz[0] * kHeat_shared[s1] / rhoCp);


		//x+1 (not stored in shared mem)
		voxel = (vi + 1)*ny*nz + vj*nz + vk;
		temp3D_tf[outvoxel] += temp3D_ti[voxel] * (Dtxyz[0] / dxdx)*(Dxyz + Dtxyz[0] * kt3D[voxel] / rhoCp);
		//x-1
		voxel = (vi - 1)*ny*nz + vj*nz + vk;
		temp3D_tf[outvoxel] += temp3D_ti[voxel] * (Dtxyz[0] / dxdx)*(Dxyz - Dtxyz[0] * kt3D[voxel] / rhoCp);
	}

	//Can't make this conditional, even though only need to sync if this tile is touching or contains a global boundary
	// (ie, boundaryConditionHit >0). 
	__syncthreads();

	//If we're in a thread on the global boundary and using f'=0 b.c.'s, update the boudary voxels
	//This implies the full INTERIOR is defined for t+1.  
	if (boundaryConditionHit && boundaryConditionMode == FD_FREEFLOW_BOUNDARYCOND)
	{
		
		if (boundaryConditionHit & 1) //copyy x+1
		{
			//There's a problem here. T(t+1, x+1) must be defined, but for the very first run,
			// only T(0,x+1) is defined.
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi + 1, vj, vk, nx, ny, nz)];

		}
			
		else if (boundaryConditionHit & 2) //copy x-1
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi - 1, vj, vk, nx, ny, nz)];

		if (boundaryConditionHit & 4) //copy y+1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj, sk + 1, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj + 1, vk, nx, ny, nz)];
		}
		else if (boundaryConditionHit & 8) //copy y-1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj, sk - 1, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj - 1, vk, nx, ny, nz)];
		}

		if (boundaryConditionHit & 16) //copy z+1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj + 1, sk, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj, vk + 1, nx, ny, nz)];
		}
		else if (boundaryConditionHit & 32) //copy z-1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj - 1, sk, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj, vk - 1, nx, ny, nz)];
		}
		
	}
	
	//This snippet was for boundary debugging
	//if (boundaryConditionHit)
	//	temp3D_tf[outvoxel] = boundaryConditionHit;
	//else 
	//	temp3D_tf[outvoxel] = -1;


	return;
};



template <typename pbhe_t>
__global__ void Pennes_2ndOrder_cuda_kernel_singleslice(
	unsigned int vi,
	pbhe_t * temp3D_tf, pbhe_t * temp3D_ti, pbhe_t * tdot3D, pbhe_t * kt3D, pbhe_t * rhoCp3D,
	pbhe_t * Dtxyz, pbhe_t Tb, pbhe_t perfusionRate,
	int nx, int ny, int nz, int boundaryConditionMode = FD_FREEFLOW_BOUNDARYCOND)
{
	/*
	__constant__ int boundaryConditionMode;
	__constant__ pbhe_t rhoCpBlood;
	__constant__ pbhe_t perfusionRate, Tb;
	__constant__ pbhe_t pbheDt, pbheDx, pbheDy, pbheDz, dxdx, dydy, dzdz;
	*/

	const pbhe_t rhoCpBlood = 1060 * 4100;
	pbhe_t dxdx = Dtxyz[1] * Dtxyz[1];
	pbhe_t dydy = Dtxyz[2] * Dtxyz[2];
	pbhe_t dzdz = Dtxyz[3] * Dtxyz[3];

	bool inBounds = true;
	int boundaryConditionHit;

	//# voxels we'll compute per block is sni*snj*snk and the
	//# stencil voxels per block that we'll need is:
	// nVox = 2*radius*(Ni*Nk + Ni*Nj + Nj*Nk) + Ni*Nj*Nk
	// Ni x Nj x Nk is the dimension of the output block that's being written. radius=1 below

	//Size of shared memory.  Output voxels will be written 1 per kernel launch, but shared mem needs to be bigger for the halo

	const int snj = blockDim.x + 2; //add the radius=1 halo
	const int snk = blockDim.y + 2;
	const int numSharedVox = snj*snk;

	if (numSharedVox > MAX_NUMELLS_SHARED_ARRAY){
		assert(0);
	}

	//Shared memory for this set of threads (i.e. one block)
	__shared__  pbhe_t Tvals_shared[MAX_NUMELLS_SHARED_ARRAY];
	//__shared__  pbhe_t rhoCp_shared[numSharedVox];
	__shared__  pbhe_t kHeat_shared[MAX_NUMELLS_SHARED_ARRAY];

	pbhe_t rhoCp;


	//indices of data voxel (have to subtract 2 b/c of the halo on each side)
	//thread & block x will be mapped to voxel direction j 
	//thread & block y will be mapped to voxel direction k 
	unsigned int vj = blockIdx.x * blockDim.x + threadIdx.x;
	unsigned int vk = blockIdx.y * blockDim.y + threadIdx.y;

	//block z is mapped to voxel i
	//unsigned int vi = blockIdx.z;

	int voxel, outvoxel;
	int tx = threadIdx.x;
	int ty = threadIdx.y;
	int s, sj, sk;

	//Determine if we are on a global boundary
	boundaryConditionHit = 0;
	if (vi == 0)
		boundaryConditionHit = 1;
	else if (vi == nx - 1)
		boundaryConditionHit = 2;

	if (vj == 0)
		boundaryConditionHit += 4;
	else if (vj == ny - 1)
		boundaryConditionHit += 8;

	if (vk == 0)
		boundaryConditionHit += 16;
	else if (vk == nz - 1)
		boundaryConditionHit += 32;

	if ((vi >= nx || vj >= ny || vk >= nz))
	{
		inBounds = false;
	}
	else {
		inBounds = true;
		outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);


		//Need to make the distinction between tile boundaries and tile boundaries corresponding to global boundaries
		//For tile boundaries that ARE GLOBAL, simply duplicate the input value into the halo
		//For tile boundaries that are NOT GLOBAL BOUNDARIES, copy the adjacent voxel into it's corresponding position in the halo
		if (tx == 0)
		{
			//Fill in halo to the left
			s = COLMAJ2d(tx, ty + 1, snj, snk);

			//If this a global boundary, copy the input voxel temperature value into the adjacent halo voxel
			//Otherwise if it's just a tile boundary, copy the adjacent input voxel into adjacent halo voxel
			if (boundaryConditionHit & (4+8))
				voxel = outvoxel;
			else
				voxel = ROWMAJ3d(vi, vj-1, vk, nx, ny, nz);

			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];
		}
		else if ((boundaryConditionHit & 8) || tx == (blockDim.x - 1))
		{
			//Fill in halo to the right
			s = COLMAJ2d(tx + 2, ty + 1, snj, snk);

			if (boundaryConditionHit & 8)
				voxel = outvoxel;
			else
				voxel = ROWMAJ3d(vi, vj + 1, vk, nx, ny, nz);

			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];
		}

		if (ty == 0)
		{
			//Fill in the halo below
			s = COLMAJ2d(tx + 1, ty, snj, snk);
			if (boundaryConditionHit & (16 + 32))
				voxel = outvoxel;
			else
				voxel = ROWMAJ3d(vi, vj, vk-1, nx, ny, nz);


			Tvals_shared[s] = temp3D_ti[voxel];
			kHeat_shared[s] = kt3D[voxel];
		}
		else if ((boundaryConditionHit & 32) || ty == (blockDim.y - 1))
		{
			//Fill in halo to above
			s = COLMAJ2d(tx + 1, ty + 2, snj, snk);
			if (boundaryConditionHit & (32))
				voxel = outvoxel;
			else
				voxel = ROWMAJ3d(vi, vj, vk + 1, nx, ny, nz);

			Tvals_shared[s] = temp3D_ti[outvoxel];
			kHeat_shared[s] = kt3D[outvoxel];
		}

	}



	if (inBounds)
	{
		//Now set the shared memory offset index s for this thread
		sj = tx + 1;
		sk = ty + 1;
		s = COLMAJ2d(sj, sk, snj, snk);

		//Now compute 
		outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);

		if (outvoxel >= nx*ny*nz)
			assert(0);

		Tvals_shared[s] = temp3D_ti[outvoxel];
		kHeat_shared[s] = kt3D[outvoxel];
	}


	//... now sync before doing anything with the tile. 
	//  This ensures it will have been fully defined across every thread in this block prior to accessing it's values.
	__syncthreads();

	if (!inBounds)
		return;

	sj = tx + 1;
	sk = ty + 1;
	s = COLMAJ2d(sj, sk, snj, snk);
	outvoxel = ROWMAJ3d(vi, vj, vk, nx, ny, nz);

	//numaccess[outvoxel] = boundaryConditionHit;

	int s1;
	pbhe_t Dxyz;

	//First handle a global boundary condition hit (i.e., the output voxel is on the edge of the simulation grid)
	if (boundaryConditionHit && boundaryConditionMode == FD_FIXEDVAL_BOUNDARYCOND)
	{
		//If b.c.'s are fixed, can read straight away from the shared memory for this voxel.
		temp3D_tf[outvoxel] = Tvals_shared[s];
	}
	else if (boundaryConditionHit == 0) {

		//If not on the interior of the global grid, compute function values.
		//This has to be done and threads syncronized before handling f'=0 boudary conditions

		rhoCp = rhoCp3D[outvoxel];
		Dxyz = kHeat_shared[s] / rhoCp;

		//additive constant
		temp3D_tf[outvoxel] = Dtxyz[0] * tdot3D[outvoxel] + Tb*perfusionRate*Dtxyz[0] * rhoCpBlood / rhoCp;

		//Txyz coefficient
		temp3D_tf[outvoxel] += Tvals_shared[s] * (1 - 2 * Dtxyz[0] * Dxyz*(1.0 / dxdx + 1.0 / dydy + 1.0 / dzdz) - perfusionRate*Dtxyz[0] * rhoCpBlood / rhoCp);

		//{data x-> voxel i, data y-> voxel j-> data z-> voxel k}
		//{ thread x-> voxel j, thread y-> voxel k }

		//return;
		//y+1 term from shared memory.  
		s1 = (sk + 1)*snj + sj;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dydy)*(Dxyz + Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//y-1
		s1 = (sk - 1)*snj + sj;
		//voxel = vi*ny*nz + (vj - 1)*nz + vk;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dydy)*(Dxyz - Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//z+1
		s1 = sk*snj + sj + 1;
		//voxel = vi*ny*nz + vj*nz + vk + 1;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dzdz)*(Dxyz + Dtxyz[0] * kHeat_shared[s1] / rhoCp);

		//z-1
		s1 = sk*snj + sj - 1;
		//voxel = vi*ny*nz + vj*nz + vk - 1;
		temp3D_tf[outvoxel] += Tvals_shared[s1] * (Dtxyz[0] / dzdz)*(Dxyz - Dtxyz[0] * kHeat_shared[s1] / rhoCp);


		//x+1 (not stored in shared mem)
		voxel = (vi + 1)*ny*nz + vj*nz + vk;
		temp3D_tf[outvoxel] += temp3D_ti[voxel] * (Dtxyz[0] / dxdx)*(Dxyz + Dtxyz[0] * kt3D[voxel] / rhoCp);
		//x-1
		voxel = (vi - 1)*ny*nz + vj*nz + vk;
		temp3D_tf[outvoxel] += temp3D_ti[voxel] * (Dtxyz[0] / dxdx)*(Dxyz - Dtxyz[0] * kt3D[voxel] / rhoCp);
	}

	//Can't make this conditional, even though only need to sync if this tile is touching or contains a global boundary
	// (ie, boundaryConditionHit >0). 
	__syncthreads();

	//If we're in a thread on the global boundary and using f'=0 b.c.'s, update the boudary voxels
	//This implies the full INTERIOR is defined for t+1.  
	if (boundaryConditionHit && boundaryConditionMode == FD_FREEFLOW_BOUNDARYCOND)
	{

		if (boundaryConditionHit & 1) //copyy x+1
		{
			//There's a problem here. T(t+1, x+1) must be defined, but for the very first run,
			// only T(0,x+1) is defined.
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi + 1, vj, vk, nx, ny, nz)];

		}

		else if (boundaryConditionHit & 2) //copy x-1
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi - 1, vj, vk, nx, ny, nz)];

		if (boundaryConditionHit & 4) //copy y+1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj, sk + 1, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj + 1, vk, nx, ny, nz)];
		}
		else if (boundaryConditionHit & 8) //copy y-1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj, sk - 1, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj - 1, vk, nx, ny, nz)];
		}

		if (boundaryConditionHit & 16) //copy z+1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj + 1, sk, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj, vk + 1, nx, ny, nz)];
		}
		else if (boundaryConditionHit & 32) //copy z-1
		{
			//temp3D_tf[outvoxel] = Tvals_shared[COLMAJ2d(sj - 1, sk, snj, snk)];
			temp3D_tf[outvoxel] = temp3D_tf[ROWMAJ3d(vi, vj, vk - 1, nx, ny, nz)];
		}

	}

	//This snippet was for boundary debugging
	//if (boundaryConditionHit)
	//	temp3D_tf[outvoxel] = boundaryConditionHit;
	//else 
	//	temp3D_tf[outvoxel] = -1;


	return;
};



#endif