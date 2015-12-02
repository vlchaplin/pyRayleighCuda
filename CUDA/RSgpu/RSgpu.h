#ifndef _RSGPU_H_
#define _RSGPU_H_

#include <cstddef>
#if defined(WIN32) || defined(_WIN32) || defined(WIN64) || defined(_WIN64) && defined(_MSC_VER)
typedef unsigned __int64 memsize_t;
#else
#include <stdint.h>
typedef uint64_t memsize_t;
#endif

typedef double gpureal;

#define THREADS_PER_BLOCK 128

#include <iostream>

//bool getTargetDeviceGlobalMemSize(memsize_t *result, const int argc, const char **argv);
//bool fdtdGPU(float *output, const float *input, const float *coeff, const int dimx, const int dimy, const int dimz, const int radius, const int timesteps, const int argc, const char **argv);

memsize_t getDeviceGlobalMemSize(int targetDevice = 0);

void CudaTestInf(int blocks, int threads);

bool RSgpu_CalcPressureField(
	gpureal * p_Re, gpureal * p_Im, gpureal kr,
	gpureal * xpoints, int dimx, gpureal * ypoints, int dimy, gpureal * zpoints, int dimz,
	gpureal * u_real, gpureal * u_imag, gpureal * coefficients,
	gpureal * ux, gpureal * uy, gpureal * uz,
	gpureal * unormalX, gpureal * unormalY, gpureal * unormalZ,
	int Nells);



#endif