#include "RSgpu.h"
#include "RSgpu.cuh"

#include <helper_functions.h>
#include <helper_cuda.h>

void CudaTestInf(int blocks, int threads)
{
	int targetDevice = 0;
	struct cudaDeviceProp deviceProp;

	checkCudaErrors(cudaGetDeviceProperties(&deviceProp, targetDevice));


	testEmptyKernel << <blocks, threads >> >();

	checkCudaErrors(cudaGetLastError());
	checkCudaErrors(cudaDeviceSynchronize());
	checkCudaErrors(cudaDeviceReset());

	return;
}

bool RSgpu_CalcPressureField(
	gpureal * p_Re, gpureal * p_Im, gpureal kr, gpureal alpha_nepers,
	gpureal * xpoints, int dimx, gpureal * ypoints, int dimy, gpureal * zpoints, int dimz,
	gpureal * u_real, gpureal * u_imag, gpureal * coefficients,
	gpureal * ux, gpureal * uy, gpureal * uz,
	gpureal * unormalX, gpureal * unormalY, gpureal * unormalZ,
	int Nells, size_t numBlocks)

{

	size_t threadsPerBlock;

	int targetDevice = 0;
	struct cudaDeviceProp deviceProp;

	checkCudaErrors(cudaGetDeviceProperties(&deviceProp, targetDevice));

	size_t globalMem = (size_t)deviceProp.totalGlobalMem;

	int globalMaxThreads = deviceProp.multiProcessorCount * deviceProp.maxThreadsPerMultiProcessor;
	int numVoxelsToCompute = dimx*dimy*dimz;

	unsigned long threadToVoxWrap = 0;
	unsigned long numVoxPerKernel = 0;


	// Due to hidden memory constraints within each thread ( trig functions, FLOPs, etc.),
	// number blocks and threads manually set to a value that works.

	threadsPerBlock = THREADS_PER_BLOCK;
	//numBlocks = globalMaxThreads / threadsPerBlock;

	if (numBlocks == 0)
	{
		numBlocks = numVoxelsToCompute / threadsPerBlock + 1;

		if (Nells > 256) {
			numBlocks = 512;
		}
		if (Nells >= 1024) {
			numBlocks = 256;
		}
		if (Nells >= 2048) {
			numBlocks = 64;
		}
	}

	numVoxPerKernel = 1+ numVoxelsToCompute / (numBlocks*threadsPerBlock);
	
	if (numVoxPerKernel == 1)
		threadToVoxWrap = 0;
	else
		threadToVoxWrap = numBlocks*threadsPerBlock;

	
	std::cout << "#blocks = " << numBlocks << ", #threads per block = " << threadsPerBlock << std::endl;
	std::cout << "voxels to compute per kernel: " << numVoxPerKernel << std::endl;
	std::cout << "thread-to-voxel wrapping: " << threadToVoxWrap << std::endl;
	

	//Compute the amount memory needed for full computation
	size_t typeSize = sizeof(gpureal);
	size_t computeGridSize = dimx*dimy*dimz*typeSize;
	size_t transducerPosSize = 3 * Nells*typeSize;
	size_t transducerVecSize = 3 * Nells*typeSize;
	size_t transducerEncSize = 2 * Nells*typeSize;
	size_t coeffiecientSize = Nells*typeSize;
	size_t transducerDefSize = transducerPosSize + transducerVecSize + transducerEncSize + coeffiecientSize;

	//size_t availableMem = (globalMem - transducerDefSize);
	//std::cout << "Compute grid size = " << computeGridSize / 1024 << " kb " << std::endl;
	//std::cout << "Available mem size = " << availableMem / 1024 << " kb " << std::endl;

	//std::cout << "Allocating GPU memory..." << std::endl;
	gpureal *d_xp, *d_yp, *d_zp, *d_coeff, *d_uRe, *d_uIm, *d_pRe, *d_pIm, *d_uX, *d_uY, *d_uZ, *d_uvX, *d_uvY, *d_uvZ;

	//Allocate
	checkCudaErrors(cudaMalloc((void **)&d_xp, dimx * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_yp, dimy * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_zp, dimz * typeSize));

	checkCudaErrors(cudaMalloc((void **)&d_coeff, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uRe, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uIm, Nells * typeSize));
	
	checkCudaErrors(cudaMalloc((void **)&d_pRe, computeGridSize ));
	checkCudaErrors(cudaMalloc((void **)&d_pIm, computeGridSize ));

	checkCudaErrors(cudaMalloc((void **)&d_uX, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uY, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uZ, Nells * typeSize));

	checkCudaErrors(cudaMalloc((void **)&d_uvX, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uvY, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uvZ, Nells * typeSize));

	//Copy 
	checkCudaErrors(cudaMemcpy(d_xp, xpoints, dimx * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_yp, ypoints, dimy * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_zp, zpoints, dimz * typeSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_coeff, coefficients, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uRe, u_real, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uIm, u_imag, Nells * typeSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_pRe, p_Re, computeGridSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_pIm, p_Im, computeGridSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_uX, ux, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uY, uy, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uZ, uz, Nells * typeSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_uvX, unormalX, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uvY, unormalY, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uvZ, unormalZ, Nells * typeSize, cudaMemcpyHostToDevice));



	//std::cout << "Launching kernel..." << std::endl;
	
	unsigned long w = 0;
	unsigned long offset = 0;


	for (w = 0; w < numVoxPerKernel; w++)
	{
		std::cout << "RS Voxel chunk " << w + 1 << " / " << numVoxPerKernel << std::endl;
		CalculatePressureExpandMeshKernel << < numBlocks, threadsPerBlock >> > (
			d_pRe, d_pIm, kr, alpha_nepers,
			d_xp, dimx, d_yp, dimy, d_zp, dimz,
			d_uRe, d_uIm, d_coeff,
			d_uX, d_uY, d_uZ,
			d_uvX, d_uvY, d_uvZ, Nells, offset
			);

		checkCudaErrors(cudaGetLastError());
		// Wait for the kernels to complete
		checkCudaErrors(cudaDeviceSynchronize());

		offset += threadToVoxWrap;
	}
	

	//checkCudaErrors(cudaDeviceSynchronize());
	//Copy result
	
	//std::cout << "Copying output to host memory..." << std::endl;
	checkCudaErrors(cudaMemcpy(p_Re, d_pRe, computeGridSize, cudaMemcpyDeviceToHost));
	checkCudaErrors(cudaMemcpy(p_Im, d_pIm, computeGridSize, cudaMemcpyDeviceToHost));

	//std::cout << "Complete" << std::endl;

	//d_xp, d_yp, d_zp, d_coeff, d_uRe, d_uIm, d_pRe, d_pIm, d_uX, d_uY, d_uZ, d_uvX, d_uvY, d_uvZ
	checkCudaErrors(cudaFree(d_xp));
	checkCudaErrors(cudaFree(d_yp));
	checkCudaErrors(cudaFree(d_zp));
	checkCudaErrors(cudaFree(d_coeff));
	checkCudaErrors(cudaFree(d_uRe));
	checkCudaErrors(cudaFree(d_uIm));
	checkCudaErrors(cudaFree(d_pRe));
	checkCudaErrors(cudaFree(d_pIm));
	checkCudaErrors(cudaFree(d_uX));
	checkCudaErrors(cudaFree(d_uY));
	checkCudaErrors(cudaFree(d_uZ));
	checkCudaErrors(cudaFree(d_uvX));
	checkCudaErrors(cudaFree(d_uvY));
	checkCudaErrors(cudaFree(d_uvZ));
	
	//checkCudaErrors(cudaDeviceReset());

	return true;
}



bool RSgpu_CalcPressurePoints(
	gpureal * p_Re, gpureal * p_Im, gpureal kr, gpureal alpha_nepers,
	gpureal * loc_x, gpureal * loc_y, gpureal * loc_z, int nlocs,
	gpureal * u_real, gpureal * u_imag, gpureal * coefficients,
	gpureal * ux, gpureal * uy, gpureal * uz,
	gpureal * unormalX, gpureal * unormalY, gpureal * unormalZ,
	int Nells, size_t numBlocks)
{

	size_t threadsPerBlock;

	int targetDevice = 0;
	struct cudaDeviceProp deviceProp;

	checkCudaErrors(cudaGetDeviceProperties(&deviceProp, targetDevice));

	size_t globalMem = (size_t)deviceProp.totalGlobalMem;

	int globalMaxThreads = deviceProp.multiProcessorCount * deviceProp.maxThreadsPerMultiProcessor;
	int numVoxelsToCompute = nlocs;

	unsigned long threadToVoxWrap = 0;
	unsigned long numVoxPerKernel = 0;


	// Due to hidden memory constraints within each thread ( trig functions, FLOPs, etc.),
	// number blocks and threads manually set to a value that works.

	threadsPerBlock = THREADS_PER_BLOCK;
	//numBlocks = globalMaxThreads / threadsPerBlock;

	if (numBlocks == 0)
	{
		numBlocks = numVoxelsToCompute / threadsPerBlock + 1;

		if (Nells > 256) {
			numBlocks = 512;
		}
		if (Nells >= 1024) {
			numBlocks = 256;
		}
		if (Nells >= 2048) {
			numBlocks = 64;
		}
	}

	numVoxPerKernel = 1 + numVoxelsToCompute / (numBlocks*threadsPerBlock);

	if (numVoxPerKernel == 1)
		threadToVoxWrap = 0;
	else
		threadToVoxWrap = numBlocks*threadsPerBlock;


	std::cout << "#blocks = " << numBlocks << ", #threads per block = " << threadsPerBlock << std::endl;
	std::cout << "voxels to compute per kernel: " << numVoxPerKernel << std::endl;
	std::cout << "thread-to-voxel wrapping: " << threadToVoxWrap << std::endl;


	//Compute the amount memory needed for full computation
	size_t typeSize = sizeof(gpureal);
	size_t computeGridSize = nlocs*typeSize;
	size_t transducerPosSize = 3 * Nells*typeSize;
	size_t transducerVecSize = 3 * Nells*typeSize;
	size_t transducerEncSize = 2 * Nells*typeSize;
	size_t coeffiecientSize = Nells*typeSize;
	size_t transducerDefSize = transducerPosSize + transducerVecSize + transducerEncSize + coeffiecientSize;

	//size_t availableMem = (globalMem - transducerDefSize);
	//std::cout << "Compute grid size = " << computeGridSize / 1024 << " kb " << std::endl;
	//std::cout << "Available mem size = " << availableMem / 1024 << " kb " << std::endl;

	//std::cout << "Allocating GPU memory..." << std::endl;
	gpureal *d_xp, *d_yp, *d_zp, *d_coeff, *d_uRe, *d_uIm, *d_pRe, *d_pIm, *d_uX, *d_uY, *d_uZ, *d_uvX, *d_uvY, *d_uvZ;

	//Allocate
	checkCudaErrors(cudaMalloc((void **)&d_xp, computeGridSize));
	checkCudaErrors(cudaMalloc((void **)&d_yp, computeGridSize));
	checkCudaErrors(cudaMalloc((void **)&d_zp, computeGridSize));

	checkCudaErrors(cudaMalloc((void **)&d_coeff, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uRe, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uIm, Nells * typeSize));

	checkCudaErrors(cudaMalloc((void **)&d_pRe, computeGridSize));
	checkCudaErrors(cudaMalloc((void **)&d_pIm, computeGridSize));

	checkCudaErrors(cudaMalloc((void **)&d_uX, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uY, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uZ, Nells * typeSize));

	checkCudaErrors(cudaMalloc((void **)&d_uvX, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uvY, Nells * typeSize));
	checkCudaErrors(cudaMalloc((void **)&d_uvZ, Nells * typeSize));

	//Copy 
	checkCudaErrors(cudaMemcpy(d_xp, loc_x, computeGridSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_yp, loc_y, computeGridSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_zp, loc_z, computeGridSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_coeff, coefficients, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uRe, u_real, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uIm, u_imag, Nells * typeSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_pRe, p_Re, computeGridSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_pIm, p_Im, computeGridSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_uX, ux, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uY, uy, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uZ, uz, Nells * typeSize, cudaMemcpyHostToDevice));

	checkCudaErrors(cudaMemcpy(d_uvX, unormalX, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uvY, unormalY, Nells * typeSize, cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy(d_uvZ, unormalZ, Nells * typeSize, cudaMemcpyHostToDevice));



	//std::cout << "Launching kernel..." << std::endl;

	unsigned long w = 0;
	unsigned long offset = 0;


	for (w = 0; w < numVoxPerKernel; w++)
	{
		std::cout << "RS Voxel chunk " << w + 1 << " / " << numVoxPerKernel << std::endl;
		CalculatePressureKernel << < numBlocks, threadsPerBlock >> > (
			d_pRe, d_pIm, kr, alpha_nepers,
			d_xp, d_yp, d_zp, nlocs,
			d_uRe, d_uIm, d_coeff,
			d_uX, d_uY, d_uZ,
			d_uvX, d_uvY, d_uvZ, Nells, offset
			);

		checkCudaErrors(cudaGetLastError());
		// Wait for the kernels to complete
		checkCudaErrors(cudaDeviceSynchronize());

		offset += threadToVoxWrap;
	}


	//checkCudaErrors(cudaDeviceSynchronize());
	//Copy result

	//std::cout << "Copying output to host memory..." << std::endl;
	checkCudaErrors(cudaMemcpy(p_Re, d_pRe, computeGridSize, cudaMemcpyDeviceToHost));
	checkCudaErrors(cudaMemcpy(p_Im, d_pIm, computeGridSize, cudaMemcpyDeviceToHost));

	//std::cout << "Complete" << std::endl;

	//d_xp, d_yp, d_zp, d_coeff, d_uRe, d_uIm, d_pRe, d_pIm, d_uX, d_uY, d_uZ, d_uvX, d_uvY, d_uvZ
	checkCudaErrors(cudaFree(d_xp));
	checkCudaErrors(cudaFree(d_yp));
	checkCudaErrors(cudaFree(d_zp));
	checkCudaErrors(cudaFree(d_coeff));
	checkCudaErrors(cudaFree(d_uRe));
	checkCudaErrors(cudaFree(d_uIm));
	checkCudaErrors(cudaFree(d_pRe));
	checkCudaErrors(cudaFree(d_pIm));
	checkCudaErrors(cudaFree(d_uX));
	checkCudaErrors(cudaFree(d_uY));
	checkCudaErrors(cudaFree(d_uZ));
	checkCudaErrors(cudaFree(d_uvX));
	checkCudaErrors(cudaFree(d_uvY));
	checkCudaErrors(cudaFree(d_uvZ));

	//checkCudaErrors(cudaDeviceReset());

	return true;
}












memsize_t getDeviceGlobalMemSize(int targetDevice )
{
	size_t            memsize = 0;

	// Query target device for maximum memory allocation
	printf(" cudaGetDeviceProperties\n");
	struct cudaDeviceProp deviceProp;
	checkCudaErrors(cudaGetDeviceProperties(&deviceProp, targetDevice));

	return deviceProp.totalGlobalMem;

}