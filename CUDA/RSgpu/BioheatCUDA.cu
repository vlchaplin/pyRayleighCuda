

#include "BioheatCUDA.h"
#include "BioheatCUDA.cuh"

template<typename pbhe_t>
int Pennes_2ndOrder_template(pbhe_t * temp4D, pbhe_t * tdot3D, pbhe_t * kt3D, pbhe_t * rhoCp3D,
	pbhe_t * Dtxyz, pbhe_t Tblood, pbhe_t perfRate, 
	int nt,
	int nx, int ny, int nz, int bcMode=FD_FREEFLOW_BOUNDARYCOND)
{
	
	const size_t wx = 8; // # size in block x 
	const size_t wy = 4;
	const size_t warpsize = wx*wy; //should be wx*wy = 32
	// invocation should have block dims = (scale*wx,scale*wy,0) where scale^2*wx*wy = (#threadsPerBlock) and scale is an int >= 1
	// dimY = (#threadsPerBlock)/(dimX)
	// and grid dims = ( 1 + ny /  blockDim.x, 1 + nz /  blockDim.y , nx) and 
	size_t blockSize = THREADS_PER_BLOCK;
	size_t scale = 4;
	size_t blockX = wx * scale;
	size_t blockY = wy * scale;
	size_t sharedMemArrDims = (blockX + 2)*(blockY + 2);

	std::cout << "scale = " << scale << std::endl;
	std::cout << "sharedMemArrSize = " << sharedMemArrDims << std::endl;
	while ((blockX*blockY >blockSize || MAX_NUMELLS_SHARED_ARRAY < sharedMemArrDims) && scale>1) {
		
		scale--;
		std::cout << "Adjusting scale to " << scale << std::endl;
		blockX = wx * scale;
		blockY = wy * scale;
		sharedMemArrDims = (blockX + 2)*(blockY + 2);
		std::cout << "sharedMemArrSize = " << sharedMemArrDims << std::endl;
		std::cout << "block X,Y = " << blockX << ", " << blockY << std::endl;
	}

	if (MAX_NUMELLS_SHARED_ARRAY < sharedMemArrDims) {
		std::cout << "Error, not enough space for shared arrays. Adjust either 'MAX_NUMELLS_SHARED_ARRAY' or 'THREADS_PER_BLOCK' and re-compile" << std::endl;
		return -1;
	}
	
	dim3 griddims3(1 + ny / blockX, 1 + nz / blockY, nx);
	dim3 blockdims(blockX, blockY, 1);
	
	pbhe_t * temp3D_tf_dev, *temp3D_ti_dev, *tdot3D_dev, *kt3D_dev, *rhoCp3D_dev, *tmp, * Dtxyz_d;

	std::cout << "Block dimensions: (" << blockdims.x << ", " << blockdims.y << ", " << blockdims.z << ")"<< std::endl;
	std::cout << " Grid dimensions: (" << griddims3.x << ", " << griddims3.y << ", " << griddims3.z << ")" << std::endl;
	int targetDevice = 0;
	struct cudaDeviceProp deviceProp; 
	
	checkCudaErrors(cudaGetDeviceProperties(&deviceProp, targetDevice));

	// Allocate
	size_t typeSize = sizeof(pbhe_t);

	checkCudaErrors(cudaMalloc((void **)&temp3D_tf_dev, nx *ny*nz* typeSize));
	checkCudaErrors(cudaMalloc((void **)&temp3D_ti_dev, nx *ny*nz * typeSize));
	checkCudaErrors(cudaMalloc((void **)&tdot3D_dev, nx *ny*nz * typeSize));
	checkCudaErrors(cudaMalloc((void **)&kt3D_dev, nx *ny*nz * typeSize));
	checkCudaErrors(cudaMalloc((void **)&rhoCp3D_dev, nx *ny*nz * typeSize));
	checkCudaErrors(cudaMalloc((void **)&Dtxyz_d, 4 * typeSize));

	checkCudaErrors(cudaMemcpy(temp3D_ti_dev, temp4D, nx *ny*nz*  typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(tdot3D_dev, tdot3D, nx *ny*nz*  typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(kt3D_dev, kt3D, nx *ny*nz*  typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(rhoCp3D_dev, rhoCp3D, nx *ny*nz* typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(Dtxyz_d, Dtxyz, 4* typeSize, cudaMemcpyHostToDevice));

	//int * numwrites_d;
	//size_t intsize = sizeof(int);
	//checkCudaErrors(cudaMalloc((void **)&numwrites_d, nx *ny*nz * intsize));
	//checkCudaErrors(cudaMemcpy(numwrites_d, numwrites, nx *ny*nz*  intsize, cudaMemcpyHostToDevice));

	pbhe_t * T_in, *T_out;
	T_in = temp3D_ti_dev;
	T_out = temp3D_tf_dev;
	int ti;
	for (ti = 0; ti < nt - 1; ti++)
	{
		std::cout << "ti = " << ti << std::endl;
		Pennes_2ndOrder_cuda_kernel<pbhe_t> << < griddims3, blockdims >> > (T_out, T_in, tdot3D_dev, kt3D_dev, rhoCp3D_dev, Dtxyz_d, Tblood, perfRate, nx, ny, nz, bcMode);
		checkCudaErrors(cudaDeviceSynchronize());
		checkCudaErrors(cudaMemcpy( (temp4D + (ti+1)*nx*ny*nz ) , T_out, nx *ny*nz* typeSize, cudaMemcpyDeviceToHost));
		//checkCudaErrors(cudaMemcpy((numwrites + (ti+1)*nx*ny*nz), numwrites_d, nx *ny*nz*intsize, cudaMemcpyDeviceToHost));
		tmp = T_in;
		T_in = T_out;
		T_out = tmp ;

	}

	checkCudaErrors(cudaGetLastError());
	// Wait for the kernels to complete
	checkCudaErrors(cudaDeviceSynchronize());

	//checkCudaErrors(cudaFree(numwrites_d));

	checkCudaErrors(cudaFree(temp3D_tf_dev));
	checkCudaErrors(cudaFree(temp3D_ti_dev));
	checkCudaErrors(cudaFree(tdot3D_dev));
	checkCudaErrors(cudaFree(kt3D_dev));
	checkCudaErrors(cudaFree(rhoCp3D_dev));
	checkCudaErrors(cudaFree(Dtxyz_d));

	checkCudaErrors(cudaDeviceReset());




	return 0;
};

int Pennes_2ndOrder_GPU(double * temp4D, double * tdot3D, double * kt3D, double * rhoCp3D,
	double * Dtxyz, double Tblood, double perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode)
{
	return Pennes_2ndOrder_template<double>(temp4D, tdot3D, kt3D, rhoCp3D, Dtxyz, Tblood, perfRate, nt, nx, ny, nz, bcMode);
}


int Pennes_2ndOrder_GPU_f(float * temp4D, float * tdot3D, float * kt3D, float * rhoCp3D,
	float * Dtxyz, float Tblood, float perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode)
{
	return Pennes_2ndOrder_template<float>(temp4D, tdot3D, kt3D, rhoCp3D, Dtxyz, Tblood, perfRate, nt, nx, ny, nz, bcMode);
}