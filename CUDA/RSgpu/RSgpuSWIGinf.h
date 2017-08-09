
#ifndef RSGPUSWIG_H
#define RSGPUSWIG_H

#include "RSgpu.h"

void TestKern(int blocks, int threads);

void RSgpuCalcField(
	double kr, double alpha_nepers,
	gpureal * pre, int nx1, int ny1, int nz1,
	gpureal * pim, int nx2, int ny2, int nz2,
	gpureal * xp, int Nx,
	gpureal * yp, int Ny,
	gpureal * zp, int Nz,
	gpureal * u_real, int Nu1,
	gpureal * u_imag, int Nu2,
	gpureal * coeffs, int Nc,
	gpureal * ux, int Nux,
	gpureal * uy, int Nuy,
	gpureal * uz, int Nuz,
	gpureal * uvx, int Nuvx,
	gpureal * uvy, int Nuvy,
	gpureal * uvz, int Nuvz,
	int numGPUBlocks=0
	);


void RSgpuCalcOnPoints(
	double kr, double alpha_nepers,
	gpureal * pre, int nx1, int ny1, int nz1,
	gpureal * pim, int nx2, int ny2, int nz2,
	gpureal * locx, int Nx,
	gpureal * locy, int Ny,
	gpureal * locz, int Nz,
	gpureal * u_real, int Nu1,
	gpureal * u_imag, int Nu2,
	gpureal * coeffs, int Nc,
	gpureal * ux, int Nux,
	gpureal * uy, int Nuy,
	gpureal * uz, int Nuz,
	gpureal * uvx, int Nuvx,
	gpureal * uvy, int Nuvy,
	gpureal * uvz, int Nuvz,
	int numGPUBlocks = 0
	);

void RSgpuCalcOnPoints1D(
	double kr, double alpha_nepers,
	gpureal * pre1d, int npre1,
	gpureal * pim1d, int npim1,
	gpureal * locx, int Nx,
	gpureal * locy, int Ny,
	gpureal * locz, int Nz,
	gpureal * u_real, int Nu1,
	gpureal * u_imag, int Nu2,
	gpureal * coeffs, int Nc,
	gpureal * ux, int Nux,
	gpureal * uy, int Nuy,
	gpureal * uz, int Nuz,
	gpureal * uvx, int Nuvx,
	gpureal * uvy, int Nuvy,
	gpureal * uvz, int Nuvz,
	int numGPUBlocks = 0
	);

#endif