
#ifndef BIOHEADGPUDEFS_H
#define BIOHEADGPUDEFS_H

#define FD_FIXEDVAL_BOUNDARYCOND 0
#define FD_FREEFLOW_BOUNDARYCOND 1


#define THREADS_PER_BLOCK 512


#include <iostream>


int computeBlockDims(int nx, int ny, int nz, int * dimX, int * dimY);

int Pennes_2ndOrder_GPU(double * temp4D, double * tdot3D, double * kt3D, double * rhoCp3D,
	double * Dtxyz, double Tblood, double perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode = FD_FREEFLOW_BOUNDARYCOND);

int Pennes_2ndOrder_GPU_f(float * temp4D, float * tdot3D, float * kt3D, float * rhoCp3D,
	float * Dtxyz, float Tblood, float perfRate,
	int nt,
	int nx, int ny, int nz, int bcMode = FD_FREEFLOW_BOUNDARYCOND);


#endif