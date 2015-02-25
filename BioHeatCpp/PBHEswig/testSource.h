#ifndef TESTSOURCE_H
#define TESTSOURCE_H


#include "MeshFunction4D.h"

#include <iostream>
using namespace std;

 void test1int(double * invec, int n);
 void testintarr(int * invec, int n);

 //long* IN_ARRAY1, int DIM1
void ShareMemoryMesh3( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunction3D<double> * infunc);
void ShareMemoryMesh34( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunctionPseudo4D<double> * infunc);
void ShareMemoryMesh4( double * IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4, double * res, int ressz,  MeshFunction4D<double> * infunc);

#endif