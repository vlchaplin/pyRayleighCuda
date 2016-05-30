#ifndef BIOHEATCUDA_H
#define BIOHEATCUDA_H

#include "BioheatCUDA.h"
#include "MeshFunction4D.h"

//#include "numpy\npy_common.h"
//npy_float32

static pbhe_gpu_algorithm_session<float> * session32 = NULL;
static pbhe_gpu_algorithm_session<double> * session64 = NULL;

void Create_Global_GPU_Session64(int nt, int nx, int ny, int nz);

void Create_Global_GPU_Session32(int nt, int nx, int ny, int nz);

void ResetGPU();

void Pennes_GPU_SliceDims(int nx, int ny, int nz, int * INPLACE_ARRAY1, int DIM1);

void Pennes_2ndOrder_GPU32(
	float * temp4d, int nt1, int nx1, int ny1, int nz1,
	float * tdot3d, int nx2, int ny2, int nz2,
	float *   kt3d, int nx3, int ny3, int nz3,
	float *rhoCp3d, int nx4, int ny4, int nz4,
	float *  Dtxyz, int nn,
	float Tb, float perfRate,
	int nt, int nx, int ny, int nz, int bcMode
	);

void Pennes_2ndOrder_GPU32_mesh(
	int useFreeflow, float dt, float dx, float dy, float dz,
	MeshFunction4D<float> * T, MeshFunction4D<float> * Tdot_source,
	MeshFunction3D<float> * kt0, MeshFunction3D<float> * rho_Cp,
	float Tblood, float perfusionrate, long ta_i = 0, long tb_i = -1
	);


void Pennes_2ndOrder_GPU64(
	double * temp4d, int nt1, int nx1, int ny1, int nz1,
	double * tdot3d, int nx2, int ny2, int nz2,
	double *   kt3d, int nx3, int ny3, int nz3,
	double *rhoCp3d, int nx4, int ny4, int nz4,
	double *  Dtxyz, int nn,
	double Tb, double perfRate,
	int nt, int nx, int ny, int nz, int bcMode
	);

void Pennes_2ndOrder_GPU64_mesh(
	int useFreeflow, double dt, double dx, double dy, double dz,
	MeshFunction4D<double> * T, MeshFunction4D<double> * Tdot_source,
	MeshFunction3D<double> * kt0, MeshFunction3D<double> * rho_Cp,
	double Tblood, double perfusionrate, long ta_i = 0, long tb_i = -1
	);
	

template <typename MESH_T>
void ShareMemoryMesh3(MESH_T * IN_ARRAY3, int DIM1, int DIM2, int DIM3, MESH_T * res, int ressz, MeshFunction3D<MESH_T> * infunc)
{
	long dims[3] = { DIM1, DIM2, DIM3 };
	infunc->useSharedData(dims, IN_ARRAY3, res);
};
template <typename MESH_T>
void ShareMemoryMesh34(MESH_T * IN_ARRAY3, int DIM1, int DIM2, int DIM3, MESH_T * res, int ressz, MeshFunctionPseudo4D<MESH_T> * infunc)
{
	long dims[4] = { 0, DIM1, DIM2, DIM3 };
	infunc->useSharedData(dims, IN_ARRAY3, res);
};
template <typename MESH_T>
void ShareMemoryMesh4(MESH_T * IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4, MESH_T * res, int ressz, MeshFunction4D<MESH_T> * infunc)
{
	long dims[4] = { DIM1, DIM2, DIM3, DIM4 };
	infunc->useSharedData(dims, IN_ARRAY4, res);
};
#endif