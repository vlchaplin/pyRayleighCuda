
#include "BioheatCUDAinf.h"


void Create_Global_GPU_Session64(int nt, int nx, int ny, int nz)
{
	session64 = pbhe_gpu_algorithm_session<double>::GetInstance();
	New_PBHE_GPUmem(nt, nx, ny, nz, &session64);
}

void Create_Global_GPU_Session32(int nt, int nx, int ny, int nz)
{
	session32 = pbhe_gpu_algorithm_session<float>::GetInstance();
	New_PBHE_GPUmem(nt, nx, ny, nz, &session32);
}

void ResetGPU()
{
	ResetGPUDevice();
	if (session32 != NULL) session32->DestroyInstance();
	if (session64 != NULL) session64->DestroyInstance();
	session32 = NULL;
	session64 = NULL;
}


void Pennes_GPU_SliceDims(int nx, int ny, int nz, int * INPLACE_ARRAY1, int DIM1)
{
	if (DIM1 < 2)
		return;

	for (int i = 0; i < 2; i++)
	{
		INPLACE_ARRAY1[i] = 0;
	}
	
	int *blockX = INPLACE_ARRAY1;
	int *blockY = INPLACE_ARRAY1 + 1;
	computeBlockDims(nx, ny, nz, blockX, blockY);
}

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
	Pennes_2ndOrder_GPU_f(temp4d, tdot3d, kt3d, rhoCp3d, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode, session32);
}

void Pennes_2ndOrder_GPU32_mesh(
	int useFreeflow, float dt, float dx, float dy, float dz,
	MeshFunction4D<float> * T, MeshFunction4D<float> * Tdot_source,
	MeshFunction3D<float> * kt0, MeshFunction3D<float> * rho_Cp,
	float Tblood, float perfusionrate, long ta_i, long tb_i
	)
{

	int bcMode;

	if (useFreeflow)
		bcMode = FD_FREEFLOW_BOUNDARYCOND;
	else
		bcMode = FD_FIXEDVAL_BOUNDARYCOND;

	long dims[4];
	float Dtxyz[] = { dt, dx, dy, dz };

	T->getdims(dims);

	int nt = dims[0]; int nx = dims[1]; int ny = dims[2]; int nz = dims[3];
	if (tb_i < 0)
	{
		tb_i = nt - 1;
	}
	else {
		if (tb_i >(nt - 1))
			tb_i = nt - 1;
		nt = tb_i - ta_i + 1;
	}

	long zero = 0;
	long L = T->index(ta_i, zero, zero, zero);

	Pennes_2ndOrder_GPU_f(&(T->data[L]), Tdot_source->data, kt0->data, rho_Cp->data, Dtxyz, Tblood, perfusionrate, nt, nx, ny, nz, bcMode, session32);
}


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
	Pennes_2ndOrder_GPU(temp4d, tdot3d, kt3d, rhoCp3d, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode, session64);
}

void Pennes_2ndOrder_GPU64_mesh(
	int useFreeflow, double dt, double dx, double dy, double dz,
	MeshFunction4D<double> * T, MeshFunction4D<double> * Tdot_source,
	MeshFunction3D<double> * kt0, MeshFunction3D<double> * rho_Cp,
	double Tblood, double perfusionrate, long ta_i, long tb_i
	)
{

	int bcMode;

	if (useFreeflow)
		bcMode = FD_FREEFLOW_BOUNDARYCOND;
	else
		bcMode = FD_FIXEDVAL_BOUNDARYCOND;

	long dims[4];
	double Dtxyz[] = { dt, dx, dy, dz };

	T->getdims(dims);

	int nt = dims[0]; int nx = dims[1]; int ny = dims[2]; int nz = dims[3];
	if (tb_i < 0)
	{
		tb_i = nt - 1;
	}
	else {
		if (tb_i >(nt - 1))
			tb_i = nt - 1;
		nt = tb_i - ta_i + 1;
	}
	long zero = 0;
	long L = T->index(ta_i,zero,zero,zero);

	Pennes_2ndOrder_GPU(&(T->data[L]), Tdot_source->data, kt0->data, rho_Cp->data, Dtxyz, Tblood, perfusionrate, nt, nx, ny, nz, bcMode, session64);
}



