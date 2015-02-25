/* File : TestSwigPython.i */
%module TestSwigPython

%{
//#include "TestSwigPython.h"
#include "MeshFunction.h"
//#include "TClass.h"
%}

/* Let's just grab the original header file here */
//%include "TestSwigPython.h"
%include "MeshFunction.h"
//%include "TClass.h"

%template(meshfunc) MeshFunction<double>;
//%template(tc) TClass<double>;