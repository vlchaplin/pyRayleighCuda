//PBHE_FreeOutflow_FDsolve_mex( T ,  rhoCp,  kt, resolution )

#include <math.h>
#include <iostream>
#include <string.h>



#include "mex.h"

#include "BioHeatModel1.h"

using namespace std;

extern void _main();

void mexFunction(
		 int          nlhs,
		 mxArray      *plhs[],
		 int          nrhs,
		 const mxArray *prhs[]
		 )
{

  /* Check for proper number of arguments */

  if (nrhs != 5) {
    mexErrMsgIdAndTxt("MATLAB:PBHE_FreeOutflow_FDsolve_mex:nargin", 
            "5 arguments required: (T, Tdot_source, rhoCp, kt, resolution)");
  } 

  long t,t1,i,j,k;
  long meshDims[4];
  long mesh3Dsize;
  long ndims = (long)mxGetNumberOfDimensions( prhs[0] );
  const mwSize* dims = mxGetDimensions( prhs[0] );

  if (ndims != 4) {
    mexErrMsgIdAndTxt("MATLAB:PBHE_FreeOutflow_FDsolve_mex:ndims", 
            "T, rhoCp, kt must be 4-dim arrays (Nt x Nx x Ny x Nz)");
  } 

  cout << "ndims(arg1)="<<ndims << endl;
  cout << "Nt x Nx x Ny x Nz = " ;
  for (i=0;i<ndims;i++) {
      meshDims[i]=dims[i];
      cout << meshDims[i] << " ";
  }
  cout << endl;

  long nt = meshDims[0];
  long nx = meshDims[1];
  long ny = meshDims[2];
  long nz = meshDims[3];
  
  mesh3Dsize = nx*ny*nz;

  double * Tdata = mxGetPr( prhs[0] );
  double * TsDotdata;
  double * rCpdata = mxGetPr( prhs[2] );
  double * Ktdata = mxGetPr( prhs[3] );
  double * meshResolution = mxGetPr( prhs[4] );

  long tsDotDimension=(long)mxGetNumberOfDimensions( prhs[1] );
  long tsDotSize=1;
  const mwSize* tsDotDims = mxGetDimensions( prhs[1] );
  cout << "TsDotDim="<<tsDotDimension<<endl;
  for (i=0;i<tsDotDimension;i++) {
      cout << tsDotDims[i] << " ";
      tsDotSize*=tsDotDims[i];
  }
  cout<<endl;

  MeshFunction4D<double> * tsdotptr=NULL;

  if ( tsDotSize == mesh3Dsize )
  { //have a time-independent heat source...use Pseudo4D mesh.
      cout << "Time-independent 3D heat source"<<endl;
      TsDotdata = mxGetPr( prhs[1] );
      
      tsdotptr = new MeshFunctionPseudo4D<double>();
      tsdotptr->isRowMaj=false;
      tsdotptr->useSharedData( meshDims, TsDotdata, meshResolution );

  } else if ( tsDotSize == mesh3Dsize*nt )
  { //time dependent heat source, use 4D mesh
      cout << "Time-dependent 4D heat source"<<endl;
      TsDotdata = mxGetPr( prhs[1] );
      
      tsdotptr = new MeshFunction4D<double>;
      tsdotptr->isRowMaj=false;
      tsdotptr->useSharedData( meshDims, TsDotdata, meshResolution );

  } else {
    //no heat source
      tsdotptr=NULL;
  }

  cout << "Resolution = ";
  for (i=0;i<ndims;i++) {
      cout << meshResolution[i] << " ";
  }
  cout << endl;
  
  MeshFunction4D<double> T;
  MeshFunction3D<double> rCp;
  MeshFunction3D<double> Kt;

  T.isRowMaj=false;
  rCp.isRowMaj=false;
  Kt.isRowMaj=false;

  T.useSharedData( meshDims, Tdata, meshResolution );
  rCp.useSharedData( meshDims+1, rCpdata, meshResolution+1 );
  Kt.useSharedData( meshDims+1, Ktdata, meshResolution+1 );

  long numPrintouts = 20;
  long interval=nt / numPrintouts;

  /*
  i=2;j=4;k=5;t=1;
  cout << Kt.index(i,j,k) << endl;
  cout << T.index(t,i,j,k) << endl;
  cout << tsdotptr->index(t,i,j,k) << " <-- " << endl;
  */
  if (interval==0) interval=1;

  for (t=0;t<nt-1;t++){
        if (t % interval == 0)
            cout << "ti = " << t << endl;

        for (i=1;i<nx-1;i++)
        {
            for (j=1;j<ny-1;j++)
            {
                for (k=1;k<nz-1;k++)
                {
                    Pennes_2ndOrder(t,i,j,k, meshResolution, &T, tsdotptr, &Kt, &rCp);
                }
            }
        }

        //  These are free-flow boundary conditions.  The directional gradient
        //  of temperature orthogonal to each boundary surface is set to zero.  This means
        //  "temperature can freely flow" out of the volume. This essentially models the case when
        //  there is no change in thermal medium beyond the simulation boundaries, no external heat sources,
        //  and heat would dissipate to zero at infinity. 

        t1 = t+1;

        for (i=0;i<nx;i++)
        {
            //X-Z boundaries
            for (k=0;k<nz;k++)
            {
                T(t1,i,0,k) = T(t1,i,1,k);
                T(t1,i,ny-1,k) = T(t1,i,ny-2,k);
            }
            //X-Y boundaries
            for (j=0;j<ny;j++)
            {
                T(t1,i,j,0) = T(t1,i,j,1);
                T(t1,i,j,nz-1) = T(t1,i,j,nz-2);
            }
        }
        
        //Y-Z boundaries
        for (j=0;j<ny;j++)
        {

            for (k=0;k<nz;k++)
            {
                T(t1,0,j,k) = T(t1,1,j,k);
                T(t1,nx-1,j,k) = T(t1,nx-2,j,k);
            }
        }
        


    }

  if ( tsdotptr!=NULL ) delete tsdotptr;

  return;
}
