#ifndef TESTSOURCE_H
#define TESTSOURCE_H

#include "BioHeatModel1.h"
#include "MeshFunction4D.h"

#include <iostream>
using namespace std;

 //long* IN_ARRAY1, int DIM1
//void ShareMemoryMesh3( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunction3D<double> * infunc);
//void ShareMemoryMesh34( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunctionPseudo4D<double> * infunc);
//void ShareMemoryMesh4( double * IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4, double * res, int ressz,  MeshFunction4D<double> * infunc);


void pbheSolve_f(int useFreeflow, float dt, float dx, float dy, float dz,
	 MeshFunction4D<float> * T, MeshFunction4D<float> * Tdot_source,
	 MeshFunction3D<float> * kt0, MeshFunction3D<float> * rho_Cp,
	 float Tblood, float perfusionrate, long ta_i =0, long tb_i = -1);


void pbheSolve(int useFreeflow, double dt, double dx, double dy, double dz,
	MeshFunction4D<double> * T, MeshFunction4D<double> * Tdot_source,
	MeshFunction3D<double> * kt0, MeshFunction3D<double> * rho_Cp,
	double Tblood, double perfusionrate, long ta_i = 0, long tb_i = -1);


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
