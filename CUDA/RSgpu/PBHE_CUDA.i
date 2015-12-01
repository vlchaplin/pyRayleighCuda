/* File : PBHEswig_cuda.i */
%module PBHE_CUDA


%{

// Copied from the original PBHEswig.i file
#include "MeshFunction.h"
#include "MeshFunction3D.h"
#include "MeshFunction4D.h"
#include "BioHeatModel1.h"

#define SWIG_FILE_WITH_INIT

//New for the CUDA project
#include "BioheatCUDAinf.h"

%}

%include "numpy.i"
%init %{
	import_array();
%}

// utility for numpy float64 arrays
%apply (double* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4) {(double * temp4d, int nt1, int nx1, int ny1, int nz1)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double * tdot3d, int nx2, int ny2, int nz2)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double *   kt3d, int nx3, int ny3, int nz3)}
%apply (double* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(double *rhoCp3d, int nx4, int ny4, int nz4)}
%apply (double* IN_ARRAY1, int DIM1) {(double *  Dtxyz, int nn)}
// utility for numpy float arrays
%apply (float* INPLACE_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4) {(float * temp4d, int nt1, int nx1, int ny1, int nz1)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * tdot3d, int nx2, int ny2, int nz2)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float *   kt3d, int nx3, int ny3, int nz3)}
%apply (float* IN_ARRAY3, int DIM1, int DIM2, int DIM3) {(float *rhoCp3d, int nx4, int ny4, int nz4)}
%apply (float* IN_ARRAY1, int DIM1) {(float *  Dtxyz, int nn)}



//Copied from PBHEswig.i
%include "MeshFunction.h"
%include "MeshFunction3D.h"
%include "MeshFunction4D.h"
%include "BioHeatModel1.h"

%template(mesh1d) MeshFunction<double>;
%template(mesh3d) MeshFunction3D<double>;
%template(mesh4d) MeshFunction4D<double>;
%template(mesh34d) MeshFunctionPseudo4D<double>;
//----//

//in case we might want single precision
%template(mesh1d_f) MeshFunction<float>;
%template(mesh3d_f) MeshFunction3D<float>;
%template(mesh4d_f) MeshFunction4D<float>;
%template(mesh34d_f) MeshFunctionPseudo4D<float>;



%feature("autodoc", "Double-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float64") Pennes_2ndOrder_GPU64;

%feature("autodoc", "Single-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float") Pennes_2ndOrder_GPU32;

%include "BioheatCUDAinf.h"