#include <iostream>
#include <iomanip>
#include <math.h>

#include "RSgpu.h"
#include "MultiDimArrays.h"

int main()
{
	size_t globalMem = (size_t)getDeviceGlobalMemSize(0);

	std::cout << "Global memory " << globalMem << std::endl;
	

	int N = 256;

	const gpureal pi = 4.0f*atan(1.0);
	gpureal kr = 1.2e6 * 2 * pi / 1540.0;

	gpureal * coeffs = new gpureal[N];
	gpureal * u_real = new gpureal[N];
	gpureal * u_imag = new gpureal[N];
	gpureal ** u_xyz = Create2D<gpureal>(3, N);
	gpureal ** unormals_xyz = Create2D<gpureal>(3, N);

	int Nx = 80;
	int Ny = 80;
	int Nz = 80;

	gpureal * xp = new gpureal[Nx];
	gpureal * yp = new gpureal[Ny];
	gpureal * zp = new gpureal[Nz];

	//gpureal *pre = new gpureal[Nx*Ny*Nz];
	//gpureal *pim = new gpureal[Nx*Ny*Nz];

	//gpureal *pre = (gpureal*)malloc(size_t(Nx*Ny*Nz)*sizeof(gpureal));
	//gpureal *pim = (gpureal*)malloc(size_t(Nx*Ny*Nz)*sizeof(gpureal));
	
	gpureal *** p_Re = Create3D<gpureal>(Nx, Ny, Nz);
	gpureal *** p_Im = Create3D<gpureal>(Nx, Ny, Nz);

	for (int i = 0; i < Nx; i++)
		for (int j = 0; j < Ny; j++)
			for (int k = 0; k < Nz; k++)
			{
				p_Re[i][j][k] = i*Ny*Nz + j*Nz + k;
				p_Im[i][j][k] = i*Ny*Nz + j*Nz + k;
			}

	//return 0;

	gpureal *pre = p_Re[0][0];
	gpureal *pim = p_Im[0][0];

	RSgpu_CalcPressureField(
		pre, pim, kr,
		xp, Nx, yp, Ny, zp, Nz,
		u_real, u_imag, coeffs,
		u_xyz[0], u_xyz[1], u_xyz[2],
		unormals_xyz[0], unormals_xyz[1], unormals_xyz[2],
		N);


	delete[] xp;
	delete[] yp;
	delete[] zp;
	delete[] u_real;
	delete[] u_imag;
	
	//delete[] pre;
	//delete[] pim;

	Delete2D(u_xyz);
	Delete2D(unormals_xyz);
	Delete3D(p_Re);
	Delete3D(p_Im);

	return 0;
}