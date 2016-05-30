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

//Copied from PBHEswig.i
%include "MeshFunction.h"
%include "MeshFunction3D.h"
%include "MeshFunction4D.h"
%include "BioHeatModel1.h"

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

//in case we might want single precision
%template(mesh1d_f) MeshFunction<float>;
%template(mesh3d_f) MeshFunction3D<float>;
%template(mesh4d_f) MeshFunction4D<float>;
%template(mesh34d_f) MeshFunctionPseudo4D<float>;

%template(mesh1d) MeshFunction<double>;
%template(mesh3d) MeshFunction3D<double>;
%template(mesh4d) MeshFunction4D<double>;
%template(mesh34d) MeshFunctionPseudo4D<double>;


%feature("autodoc", "Get the blockDims.x, and blockDims.y that will be used in the Pennes_2ndOrder codes for the nx,ny,nz volume") Pennes_GPU_SliceDims;

%feature("autodoc", "Double-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float64") Pennes_2ndOrder_GPU64;
%feature("autodoc", "Double-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float64") Pennes_2ndOrder_GPU64_mesh;

%feature("autodoc", "Single-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float32") Pennes_2ndOrder_GPU32;
%feature("autodoc", "Single-precision CUDA-enabled solution to bioheat equation. Input arrays are numpy.float32") Pennes_2ndOrder_GPU32_mesh;

%feature("autodoc", "Set-up memory reuse between for the PBHE calculation. numpy.float64") Create_Global_GPU_Session64;
%feature("autodoc", "Set-up memory reuse between for the PBHE calculation. numpy.float32") Create_Global_GPU_Session32;
%feature("autodoc", "Reset all GPU memory.") ResetGPU();

%include "BioheatCUDAinf.h"

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
