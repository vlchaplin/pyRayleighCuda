
#include <cuda.h>
#include <cufft.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
#include <helper_cuda.h>
#include <helper_functions.h>

#include "RSgpu.h"

#include <assert.h>

#ifndef RSGPH_CUH
#define RSGPH_CUH

__global__ void testEmptyKernel() {
	return;
};

__global__ void CalculatePressureMeshKernel(
	gpureal *output_real, gpureal * output_imag,
	gpureal kr,
	const gpureal * xp, const int nx, const gpureal * yp, const int ny, const gpureal * zp, const int nz, 
	const gpureal * u_real, const gpureal * u_imag, const gpureal * coefficients,
	const gpureal * uX, const gpureal * uY, const gpureal * uZ, 
	const gpureal * unormalX, const gpureal * unormalY, const gpureal * unormalZ, const int N, unsigned long wrapSize)

{
	//Uses scalar (1d) thread and block sizes. i.e. << B, T >>
	unsigned long gtidx = blockIdx.x * blockDim.x + threadIdx.x;
	unsigned long numVox = nx;
	numVox *= ny;
	numVox *= nz;

	unsigned long voxidx;
	int gi, gj, gk;
	gpureal sepX, sepY, sepZ, dist, dirCosine, arg, sinarg, cosarg;
	int n;


	//if (gtidx > (numVox - 1))
	//	return;

	//if (wrapSize == 0)
	//	wrapSize = numVox;

	
	voxidx = gtidx + wrapSize;
	if (voxidx > (numVox - 1))
		return;

	//while (voxidx < numVox - 1)
	//{
		gi = (voxidx / (ny*nz));
		gj = (voxidx / nz) % ny;
		gk = voxidx % nz;

		if (gi >= nx)
			assert(0);
		if (gj >= ny)
			assert(0);
		if (gk >= nz)
			assert(0);

		for (n = 0; n < N; n++)
		{
			sepX = (xp[gi] - uX[n]);
			sepY = (yp[gj] - uY[n]);
			sepZ = (zp[gk] - uZ[n]);

			dist = sqrt(sepX*sepX + sepY*sepY + sepZ*sepZ);

			dirCosine = (sepX*unormalX[n] + sepY*unormalY[n] + sepZ*unormalZ[n]) / dist;

			arg = kr*dist;
			//sin() and cos() cause problems for some reason
			sincos(arg, &sinarg, &cosarg);
			//sinarg = sin(arg);
			//cosarg = cos(arg);

			output_real[voxidx] += dirCosine*coefficients[n] * (u_real[n] * (-sinarg) - u_imag[n] * cosarg);
			output_imag[voxidx] += dirCosine*coefficients[n] * (u_real[n] * cosarg + u_imag[n] * (-sinarg));
		}
		

		//voxidx += wrapSize;
	//}
	
	return;
};




__global__ void CalculatePressureMeshKernel_singleElement(
	gpureal *output_real, gpureal * output_imag,
	gpureal kr,
	const gpureal * xp, const int nx, const gpureal * yp, const int ny, const gpureal * zp, const int nz,
	const gpureal * u_real, const gpureal * u_imag, const gpureal * coefficients,
	const gpureal * uX, const gpureal * uY, const gpureal * uZ,
	const gpureal * unormalX, const gpureal * unormalY, const gpureal * unormalZ, const int n, unsigned long wrapSize=0)

{
	//Uses scalar (1d) thread and block sizes. i.e. << B, T >>
	unsigned long gtidx = blockIdx.x * blockDim.x + threadIdx.x;
	unsigned long numVox = nx;
	numVox *= ny;
	numVox *= nz;

	unsigned long voxidx;
	int gi, gj, gk;
	gpureal sepX, sepY, sepZ, dist, dirCosine, arg, sinarg, cosarg;

	voxidx = gtidx + wrapSize;
	if (voxidx > (numVox - 1))
		return;

	gi = (voxidx / (ny*nz));
	gj = (voxidx / nz) % ny;
	gk = voxidx % nz;

	if (gi >= nx)
		assert(0);
	if (gj >= ny)
		assert(0);
	if (gk >= nz)
		assert(0);

	sepX = (xp[gi] - uX[n]);
	sepY = (yp[gj] - uY[n]);
	sepZ = (zp[gk] - uZ[n]);

	dist = sqrt(sepX*sepX + sepY*sepY + sepZ*sepZ);

	dirCosine = (sepX*unormalX[n] + sepY*unormalY[n] + sepZ*unormalZ[n]) / dist;

	arg = kr*dist;
	sincos(arg, &sinarg, &cosarg);

	output_real[voxidx] = dirCosine*coefficients[n] * (u_real[n] * (-sinarg) - u_imag[n] * cosarg);
	output_imag[voxidx] += dirCosine*coefficients[n] * (u_real[n] * cosarg + u_imag[n] * (-sinarg));

	return;
};


#endif