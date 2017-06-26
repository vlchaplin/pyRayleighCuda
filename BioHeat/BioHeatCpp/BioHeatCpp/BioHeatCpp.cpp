// BioHeatCpp.cpp : Defines the entry point for the console application.
//
#include "MeshFunction4D.h"
#include "BioHeatModel1.h"
#include <iostream>

using namespace std;

int main(int argc, char* const argv[])
{
	long nt=10;
    long nx=100;
    long ny=100;
    long nz=50;
    
    double ds[] = { 0.1, 0.005, 0.005, 0.005 };


    //3700 reasonable average for Cp in J/kg*K of human tissues
    //use rho = 1000 kg/m^3
    //k = 0.5 W / m*K
    MeshFunction4D<double> temp(nt, nx, ny, nz); //deg C
    MeshFunction4D<double> temp2(nt, nx, ny, nz);
    MeshFunction3D<double> rho_Cp(nx, ny, nz); //rho in kg/m^3  Cp in J/(kg*K)
    MeshFunction3D<double> kt(nx, ny, nz);

    MeshFunction4D<double> * nulls = NULL;

    MeshFunctionPseudo4D<double> test(nx,ny,nz);

    
    temp.setres(ds);
    temp.setres(ds);
    rho_Cp.setres(ds+1);
    kt.setres(ds+1);

    kt.isRowMaj=false;
    test.isRowMaj=false;
    

    long t,i,j,k;

    i=1; j=4; k = 5;
    
    cout << kt.index(i,j,k) << endl;
    cout << test.index(t,i,j,k) << endl;
    //cin.get();
    //return 0;
    for (i=0;i<nx;i++)
        for (j=0;j<ny;j++)
            for (k=0;k<nz;k++)
            {
                temp(0,i,j,k)=37.0;
                temp2(0,i,j,k)=37.0;
                rho_Cp(i,j,k) = 3700*1000;
                kt(i,j,k) = 0.5;
            }

    //for (i=nx/2-10;i<nx/2+10;i++)
    //    for (j=ny/2-10;j<ny/2+10;j++)
    //        for (k=nz/2-10;k<nz/2+10;k++)
    //        {
    //            temp(0,i,j,k)=45.0;
    //        }

    temp(0,nx/2,ny/2,nz/2)=45.0;
    temp2(0,nx/2,ny/2,nz/2)=45.0;
	cout << temp.val(0,nx/2,ny/2,nz/2) << endl;

    long txyz[4];

    double perfusionRate = 0.0;

    Pennes_Perfused_SolveCube( (bool)0, (double*)ds, &temp, nulls, &kt, &rho_Cp, 37.0, perfusionRate );

    //return 0;
    for (t=0;t<nt-1;t++){
     
        cout << "ti = " << t << endl;
        txyz[0]=t;
        for (i=1;i<nx-1;i++)
        {
            txyz[1]=i;
            for (j=1;j<ny-1;j++)
            {
                txyz[2]=j;
                for (k=1;k<nz-1;k++)
                {
                    txyz[3]=k;
                    //Pennes_2ndOrder(t,i,j,k,ds, &temp, nulls,&kt,&rho_Cp);
                    Pennes_Perfused(txyz,ds, &temp2, nulls,&kt,&rho_Cp, 37.0, perfusionRate);
                }
            }
        }
        cout << temp.val(t+1,nx/2,ny/2,nz/2) << "   ";
        cout << temp.val(t+1,nx/2,ny/2,nz/2) - temp2.val(t+1,nx/2,ny/2,nz/2) << endl;
    }

	cout << "Press return to quit" << endl;
	cin.get();

	return 0;
}
