/* File : PBHEswig_cuda.i */
%module PBHEswig_cuda


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

// utility for numpy float64 arrays.  Note these lines require 'gpureal' to be 'double' type.  
// If gpureal (defined in RSgpu.h) is 'float' type, replace the 'double *' on the left below to 'float *'
%apply (double* IN_ARRAY1, int DIM1) {(gpureal * xp, int Nx), (gpureal * yp, int Ny), (gpureal * zp, int Nz), (gpureal * u_real, int Nu1),(gpureal * u_imag, int Nu2), (gpureal * coeffs, int Nc)}
%apply (double* IN_ARRAY1, int DIM1) {(gpureal * ux, int Nux), (gpureal * uy, int Nuy), (gpureal * zp, int Nz), (gpureal * uz, int Nuz)}
%apply (double* IN_ARRAY1, int DIM1) {(gpureal * uvx, int Nuvx), (gpureal * uvy, int Nuvy), (gpureal * uvz, int Nuvz)}
%apply (double* INPLACE_ARRAY3, int DIM1, int DIM2, int DIM3) {(gpureal * pre, int nx1, int ny1, int nz1), (gpureal * pim, int nx2, int ny2, int nz2)} 

// utility for numpy float arrays
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * xp, int Nx), (float * yp, int Ny), (float * zp, int Nz), (float * u_real, int Nu1),(float * u_imag, int Nu2), (float * coeffs, int Nc)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * ux, int Nux), (float * uy, int Nuy), (float * zp, int Nz), (float * uz, int Nuz)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * uvx, int Nuvx), (float * uvy, int Nuvy), (float * uvz, int Nuvz)}
%apply (float* INPLACE_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * pre, int nx1, int ny1, int nz1), (float * pim, int nx2, int ny2, int nz2)} 
%apply (float* INPLACE_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * pim, int nx2, int ny2, int nz2)} 

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



//%feature("autodoc", "TestKern test") TestKern;

//%feature("autodoc", "Calculate the ndgrid style {xp X yp X zp} pressure field") RSgpuCalcField;


%include "BioheatCUDAinf.h"