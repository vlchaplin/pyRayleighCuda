/* File : PBHEswig.i */
%module PBHEswig

%{

#include "MeshFunction.h"
#include "MeshFunction3D.h"
#include "MeshFunction4D.h"
#include "BioHeatModel1.h"

#define SWIG_FILE_WITH_INIT

#include "testSource.h"

%}

%include "numpy.i"
%init %{
	import_array();
%}

/* Let's just grab the original header file here */

%include "MeshFunction.h"
%include "MeshFunction3D.h"
%include "MeshFunction4D.h"
%include "BioHeatModel1.h"

%template(mesh1d_f) MeshFunction<float>;
%template(mesh3d_f) MeshFunction3D<float>;
%template(mesh4d_f) MeshFunction4D<float>;
%template(mesh34d_f) MeshFunctionPseudo4D<float>;

%template(mesh1d) MeshFunction<double>;
%template(mesh3d) MeshFunction3D<double>;
%template(mesh4d) MeshFunction4D<double>;
%template(mesh34d) MeshFunctionPseudo4D<double>;


%apply (double* INPLACE_ARRAY1, int DIM1) {(double* invec, int n)}
%apply (int* INPLACE_ARRAY1, int DIM1) {(int* invec, int n)}

%apply (double* INPLACE_ARRAY1, int DIM1) {( double * res, int ressz)}

%apply (float* INPLACE_ARRAY1, int DIM1) {(float* invec, int n)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * res, int ressz)}


%feature("autodoc", "pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T") pbheSolve;

%feature("autodoc", "pbheSolve_f(freeFlow, dt,dx,dy,dz, mesh4d_f T, mesh4d_f Tdot, mesh3d_f k, mesh3d_f rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T") pbheSolve_f;

%include "testSource.h"

%apply (double* IN_ARRAY1, int DIM1) {( double * res, int ressz)}
%template(ShareMemoryMesh3) ShareMemoryMesh3<double>;
%template(ShareMemoryMesh34) ShareMemoryMesh34<double>;
%template(ShareMemoryMesh4) ShareMemoryMesh4<double>;

%apply (float* IN_ARRAY1, int DIM1) {( float * res, int ressz)}
%template(ShareMemoryMesh3_f) ShareMemoryMesh3<float>;
%template(ShareMemoryMesh34_f) ShareMemoryMesh34<float>;
%template(ShareMemoryMesh4_f) ShareMemoryMesh4<float>;