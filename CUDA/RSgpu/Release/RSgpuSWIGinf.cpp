
#include "RSgpuSWIGinf.h"


void TestKern(int blocks, int threads)
{
	
	CudaTestInf(blocks, threads);
	return;
}

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
	int numGPUBlocks
	)
{
	
	RSgpu_CalcPressureField(
		pre, pim, kr, alpha_nepers,
		xp, Nx, yp, Ny, zp, Nz,
		u_real, u_imag, coeffs,
		ux, uy, uz,
		uvx, uvy, uvz,
		Nu1, (size_t)numGPUBlocks);

	return;
}

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
	int numGPUBlocks
	)
{
	//Nx,Ny,Nz should be the same

	RSgpu_CalcPressurePoints(
		pre, pim, kr, alpha_nepers,
		locx, locy, locz, Nx,
		u_real, u_imag, coeffs,
		ux, uy, uz,
		uvx, uvy, uvz,
		Nu1, (size_t)numGPUBlocks);


}

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
	int numGPUBlocks
	)
{

	RSgpu_CalcPressurePoints(
		pre1d, pim1d, kr, alpha_nepers,
		locx, locy, locz, Nx,
		u_real, u_imag, coeffs,
		ux, uy, uz,
		uvx, uvy, uvz,
		Nu1, (size_t)numGPUBlocks);

}