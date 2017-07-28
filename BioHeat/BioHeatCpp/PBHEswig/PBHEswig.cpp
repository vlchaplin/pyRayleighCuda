
#include "PBHEswig.h"


void pbheSolve_f(int useFreeflow, float dt, float dx, float dy, float dz,
	MeshFunction4D<float> * T, MeshFunction4D<float> * Tdot_source,
	MeshFunction3D<float> * kt0, MeshFunction3D<float> * rho_Cp,
	float Tblood, float perfusionrate, long ta_i, long tb_i)
{
	Pennes_Perfused_SolveCube_interface<float>(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i, tb_i);
}

void pbheSolve(int useFreeflow, double dt, double dx, double dy, double dz,
	MeshFunction4D<double> * T, MeshFunction4D<double> * Tdot_source,
	MeshFunction3D<double> * kt0, MeshFunction3D<double> * rho_Cp,
	double Tblood, double perfusionrate, long ta_i , long tb_i)
{
	Pennes_Perfused_SolveCube_interface<double>(useFreeflow, dt, dx, dy, dz, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate, ta_i, tb_i);
}


//void ShareMemoryMesh3( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunction3D<double> * infunc)
//{
//    long dims[3] = {DIM1,DIM2,DIM3};
//    infunc->useSharedData( dims, IN_ARRAY3, res );
//}
//
//void ShareMemoryMesh34( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunctionPseudo4D<double> * infunc)
//{
//    long dims[4]  = {0,DIM1,DIM2,DIM3};
//    infunc->useSharedData( dims, IN_ARRAY3, res );
//}
//
//void ShareMemoryMesh4( double * IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4, double * res, int ressz,  MeshFunction4D<double> * infunc)
//{
//    long dims[4]  = {DIM1,DIM2,DIM3,DIM4};
//    infunc->useSharedData( dims, IN_ARRAY4, res );
//}
