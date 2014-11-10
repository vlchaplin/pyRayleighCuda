
#ifndef RSINTEGRAL_H
#define RSINTEGRAL_H

#include <stdlib.h>
#include <iostream>
#include <math.h>
#include <complex>

#include "MeshFunction4D.h"
#include "PhysicsVectors.h"

const std::complex<double> I(0,1);

void RSComputeHomogeneous( complex<double>& amp, double& rho, double& c, double& kr, double *refPosition,  MeshFunction3D<double> * reField, MeshFunction3D<double> * imField ) 
{
    long dims[3];
    double dX[3];
    long i,j,k;

    complex<double> value;
    double pixLoc[3];
    double dist;

    complex<double> scalar = amp*I*(rho*c*kr)/(2.0*physvec::PI);

    reField->getdims( dims );
    reField->getres( dX );

    double pixelDiag = sqrt(dX[0]*dX[0] + dX[1]*dX[1] + dX[2]*dX[2]);

    for (k=0; k<dims[2]; k++)
    {
        pixLoc[2] = dX[2]*(k+0.5);
        for (j=0; j<dims[1]; j++)
        {
            pixLoc[1] = dX[1]*(j+0.5);
            for (i=0; i<dims[0]; i++)
            {
                pixLoc[0] = dX[0]*(i+0.5);
                

                dist = physvec::distance( refPosition, pixLoc );

                if ( dist>pixelDiag ) {
                    value = scalar*exp(kr*I*dist) / dist;
                    (*reField)(i,j,k) += value.real();
                    (*imField)(i,j,k) += value.imag();
                }
            }
        }
    }

};







#endif