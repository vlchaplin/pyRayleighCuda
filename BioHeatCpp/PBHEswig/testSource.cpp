
#include "testSource.h"

void test1int(double * invec, int n)
 {
	int i;
	for (i=0; i<n; i++)
	{
		invec[i] *=2 ;
	}
 };

void testintarr(int * invec, int n)
{
	int i;
	for(i=0;i<n;i++)
		invec[i] += 1;
}

void ShareMemoryMesh3( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunction3D<double> * infunc)
{
    cout << "test" <<endl;
    long dims[3] = {DIM1,DIM2,DIM3};
    infunc->useSharedData( dims, IN_ARRAY3, res );
}

void ShareMemoryMesh34( double * IN_ARRAY3, int DIM1, int DIM2, int DIM3, double * res, int ressz, MeshFunctionPseudo4D<double> * infunc)
{
    long dims[4]  = {0,DIM1,DIM2,DIM3};
    infunc->useSharedData( dims, IN_ARRAY3, res );
}

void ShareMemoryMesh4( double * IN_ARRAY4, int DIM1, int DIM2, int DIM3, int DIM4, double * res, int ressz,  MeshFunction4D<double> * infunc)
{
    long dims[4]  = {DIM1,DIM2,DIM3,DIM4};
    infunc->useSharedData( dims, IN_ARRAY4, res );
}