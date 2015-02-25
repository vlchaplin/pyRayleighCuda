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

%template(mesh1d) MeshFunction<double>;
%template(mesh3d) MeshFunction3D<double>;
%template(mesh4d) MeshFunction4D<double>;
%template(mesh34d) MeshFunctionPseudo4D<double>;


%apply (double* INPLACE_ARRAY1, int DIM1) {(double* invec, int n)}
%apply (int* INPLACE_ARRAY1, int DIM1) {(int* invec, int n)}

%apply (double* INPLACE_ARRAY1, int DIM1) {( double * res, int ressz)}
%include "testSource.h"



%feature("autodoc", "pbheSolve(freeFlow, dt,dx,dy,dz, mesh4d T, mesh4d Tdot, mesh3d k, mesh3d rho_Cp, Tblood, perfusionRate, [ti1, ti2]  ) -> updates T") Pennes_Perfused_SolveCube_interface<double>;
%template(pbheSolve)  Pennes_Perfused_SolveCube_interface<double>;