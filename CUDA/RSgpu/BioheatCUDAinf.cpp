
#include "BioheatCUDAinf.h"


void Pennes_2ndOrder_GPU64(
	double * temp4d, int nt1, int nx1, int ny1, int nz1,
	double * tdot3d, int nx2, int ny2, int nz2,
	double *   kt3d, int nx3, int ny3, int nz3,
	double *rhoCp3d, int nx4, int ny4, int nz4,
	double *  Dtxyz, int nn,
	double Tb, double perfRate,
	int nt, int nx, int ny, int nz, int bcMode
	)
{
	if ((bcMode != FD_FIXEDVAL_BOUNDARYCOND) && (bcMode != FD_FREEFLOW_BOUNDARYCOND))
	{
		bcMode = FD_FREEFLOW_BOUNDARYCOND;
	}
	Pennes_2ndOrder_GPU(temp4d, tdot3d, kt3d, rhoCp3d, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode);
};

void Pennes_2ndOrder_GPU32(
	float * temp4d, int nt1, int nx1, int ny1, int nz1,
	float * tdot3d, int nx2, int ny2, int nz2,
	float *   kt3d, int nx3, int ny3, int nz3,
	float *rhoCp3d, int nx4, int ny4, int nz4,
	float *  Dtxyz, int nn,
	float Tb, float perfRate,
	int nt, int nx, int ny, int nz, int bcMode
	)
{
	if ((bcMode != FD_FIXEDVAL_BOUNDARYCOND) && (bcMode != FD_FREEFLOW_BOUNDARYCOND))
	{
		bcMode = FD_FREEFLOW_BOUNDARYCOND;
	}
	Pennes_2ndOrder_GPU_f(temp4d, tdot3d, kt3d, rhoCp3d, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode);
};