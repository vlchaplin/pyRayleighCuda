/* File : RSgpuPySwig.i */
%module RSgpuPySwig


%{

#define SWIG_FILE_WITH_INIT

#include "RSgpuSWIGinf.h"

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

%apply (double* IN_ARRAY1, int DIM1) {(gpureal * locx, int Nx), (gpureal * locy, int Ny), (gpureal * locz, int Nz), (gpureal * u_real, int Nu1),(gpureal * u_imag, int Nu2), (gpureal * coeffs, int Nc)}
%apply (double* INPLACE_ARRAY1, int DIM1) {(gpureal * pre1d, int npre1), (gpureal * pim1d, int npim1)}

%apply (float* INPLACE_ARRAY1, int DIM1) {(float * xp, int Nx), (float * yp, int Ny), (float * zp, int Nz), (float * u_real, int Nu1),(float * u_imag, int Nu2), (float * coeffs, int Nc)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * ux, int Nux), (float * uy, int Nuy), (float * zp, int Nz), (float * uz, int Nuz)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * uvx, int Nuvx), (float * uvy, int Nuvy), (float * uvz, int Nuvz)}
%apply (float* INPLACE_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * pre, int nx1, int ny1, int nz1), (float * pim, int nx2, int ny2, int nz2)} 
%apply (float* INPLACE_ARRAY3, int DIM1, int DIM2, int DIM3) {(float * pim, int nx2, int ny2, int nz2)} 

%apply (float* INPLACE_ARRAY1, int DIM1) {(float * locx, int Nx), (float * locy, int Ny), (float * locz, int Nz), (float * u_real, int Nu1),(float * u_imag, int Nu2), (float * coeffs, int Nc)}
%apply (float* INPLACE_ARRAY1, int DIM1) {(float * pre1d, int npre1), (float * pim1d, int npim1)}

%feature("autodoc", "TestKern test") TestKern;

%feature("autodoc", "Calculate the ndgrid style {xp X yp X zp} pressure field") RSgpuCalcField;
%feature("autodoc", "Calculate the pressure field at points with vertices {locx,locy,locz}--arrays should be the same length. Input pressure arrays should be 1-D.") RSgpuCalcOnPoints1D;
%feature("autodoc", "Calculate the pressure field at points with vertices {locx,locy,locz}. locs are interpreted to be a flattened meshgrid. Input pressure arrays should be 3-D.") RSgpuCalcOnPoints;

%include "RSgpuSWIGinf.h"