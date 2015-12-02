
#include "BioheatCUDA.h"
#include "MeshFunction4D.h"

#include <iomanip>

using namespace std;

typedef double pbhe_t;

int main()
{
	int nt = 10;
	int nx = 40;
	int ny = 40;
	int nz = 40;
	int bcMode = 1;
	
	MeshFunction4D<int> NumWrites4d(nt, nx, ny, nz);
	MeshFunction4D<pbhe_t> Temp4d(nt, nx, ny, nz);
	MeshFunction3D<pbhe_t> tdot3d(nx, ny, nz);
	MeshFunction3D<pbhe_t> rhoCp3d(nx, ny, nz);
	MeshFunction3D<pbhe_t> ktherm3d(nx, ny, nz);
	pbhe_t dt = 0.1;
	pbhe_t dx = 0.000253;
	pbhe_t dy = dx;
	pbhe_t dz = 0.000886;

	pbhe_t Dtxyz[] = { dt, dx, dy, dz };

	pbhe_t T0 = 37;
	pbhe_t Tb = 37;
	pbhe_t perfRate = 0.0;
	int i, j, k;

	Temp4d.setres(Dtxyz);
	tdot3d.setres(Dtxyz + 1);

	NumWrites4d.setToScalar(0);
	Temp4d.setToScalar(T0);
	rhoCp3d.setToScalar(1000.0 * 3700);
	ktherm3d.setToScalar(0.5);
	tdot3d.setToScalar(0.5);

	for (i = nx / 2 - 1; i < nx / 2 + 1; i++)
		for (j = ny / 2 - 1; j < ny / 2 + 1; j++)
			for (k = nz / 2 - 1; k < nz / 2 + 1; k++)
				tdot3d(i,j,k)=0.5;

	/*
	for (i = 0; i < nx; i++)
	{
		for (j = 0; j < ny; j++)
		{
			Temp4d(0, i, j, 0) = T0;
			Temp4d(0, i, j, nz - 1) = T0;
		}
		for (k = 0; k < nz; k++)
		{
			Temp4d(0, i, 0, k) = T0;
			Temp4d(0, i, ny - 1, k) = 10 + i;
		}
	}
	for (j = 0; j < ny; j++)
	{
		for (k = 0; k < nz; k++)
		{
			Temp4d(0, 0, j, k) = T0;
			Temp4d(0, nx - 1, j, k) = T0;
		}
	}
	*/

	bcMode = FD_FREEFLOW_BOUNDARYCOND;
	bcMode = FD_FIXEDVAL_BOUNDARYCOND;
	Pennes_2ndOrder_GPU(Temp4d.data, tdot3d.data, ktherm3d.data, rhoCp3d.data, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode);
	
	//Pennes_2ndOrder_GPU_f(Temp4d.data, tdot3d.data, ktherm3d.data, rhoCp3d.data, Dtxyz, Tb, perfRate, nt, nx, ny, nz, bcMode);
	
	k = nz / 2;

	int lowi = 0; int upi = nx - 1;
	int lowj = 0; int upj = ny - 1;
	int dispw = 10;
	if (nx > dispw)
	{
		lowi = nx / 2 - dispw / 2;
		upi = nx / 2 + dispw / 2;
	}
	if (ny > dispw)
	{
		lowj = ny / 2 - dispw / 2;
		upj = ny / 2 + dispw / 2;
	}


	for (int ti = 0; ti < nt; ti++)
	{
		for (i = lowi; i <= upi; i++)
		{
				//for (j = lowj; j <= upj; j++)
				//{
				//	cout << setw(2) << fixed << NumWrites4d(ti, i, j, k) << " ";
				//}
				//cout << "  ";
			for (j = lowj; j <= upj; j++)
			{
				cout << fixed << setprecision(2) << Temp4d(ti, i, j, k) << " ";
			}

			cout << endl;			
		}
		cout << endl;
	}
	return(0);

}