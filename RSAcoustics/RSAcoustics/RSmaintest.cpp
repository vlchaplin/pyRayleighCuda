
#include "RSIntegral.h"



int main() 
{

    long Nx=100,Ny=100,Nz=100;

    MeshFunction3D<double> pre(Nx,Ny,Nz);
    MeshFunction3D<double> pim(Nx,Ny,Nz);

    double rn[3] = {0,0,0};
    double rho = 1000;
    double c = 1500;
    double k = 4.9e03;

    pre.setToScalar(0.0);
    pim.setToScalar(1.0);

    RSComputeHomogeneous(rho,c,k, rn, &pre, &pim);



    return 0;

}