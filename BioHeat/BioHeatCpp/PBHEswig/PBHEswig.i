/* File : PBHEswig.i */
%module PBHEswig

%{

#define SWIG_FILE_WITH_INIT

#include "MeshFunction.h"
#include "MeshFunction3D.h"
#include "MeshFunction4D.h"
#include "BioHeatModel1.h"

#include "PBHEswig.h"

%}

%include "numpy.i"
%init %{
	import_array();
%}

%include "MeshFunction.h"
%include "MeshFunction3D.h"
%include "MeshFunction4D.h"
%include "BioHeatModel1.h"
%include "PBHEswig.h"

// utility for numpy float arrays
%apply (float* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4) {(float * temp4d, int nt1, int nx1, int ny1, int nz1)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * tdot3d, int nx2, int ny2, int nz2)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float *   kt3d, int nx3, int ny3, int nz3)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float *rhoCp3d, int nx4, int ny4, int nz4)}
%apply (float* IN_ARRAY1, int DIM1) {(float *  Dtxyz, int nn)}


// utility for numpy float64 arrays
%apply (double* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4) {(double * temp4d, int nt1, int nx1, int ny1, int nz1)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double * tdot3d, int nx2, int ny2, int nz2)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double *   kt3d, int nx3, int ny3, int nz3)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double *rhoCp3d, int nx4, int ny4, int nz4)}
%apply (double* IN_ARRAY1, int DIM1) {(double *  Dtxyz, int nn)}

%template(mesh1d_f) MeshFunction<float>;
%template(mesh3d_f) MeshFunction3D<float>;
%template(mesh4d_f) MeshFunction4D<float>;
%template(mesh34d_f) MeshFunctionPseudo4D<float>;

%template(mesh1d) MeshFunction<double>;
%template(mesh3d) MeshFunction3D<double>;
%template(mesh4d) MeshFunction4D<double>;
%template(mesh34d) MeshFunctionPseudo4D<double>;



%feature("autodoc", "pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T") pbheSolve;
%feature("autodoc", "pbheSolve_f(freeFlow, dt,dx,dy,dz, mesh4d_f T, mesh4d_f Tdot, mesh3d_f k, mesh3d_f rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T") pbheSolve_f;

%apply (double* IN_ARRAY1, int DIM1) {( double * res, int ressz)}
%template(ShareMemoryMesh3) ShareMemoryMesh3<double>;
%template(ShareMemoryMesh34) ShareMemoryMesh34<double>;
%template(ShareMemoryMesh4) ShareMemoryMesh4<double>;

%apply (float* IN_ARRAY1, int DIM1) {( float * res, int ressz)}
%template(ShareMemoryMesh3_f) ShareMemoryMesh3<float>;
%template(ShareMemoryMesh34_f) ShareMemoryMesh34<float>;
%template(ShareMemoryMesh4_f) ShareMemoryMesh4<float>;

%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh3;
%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh34;
%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh4;
%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh3_f;
%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh34_f;
%feature("autodoc", "Set-up data sharing between numpy array and mesh object") ShareMemoryMesh4_f;
