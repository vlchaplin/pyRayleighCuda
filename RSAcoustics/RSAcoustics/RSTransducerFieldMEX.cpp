//RSTransducerFieldMEX( rho, c, k, u_pos, u_ampcomplex, p_complex, pixdims )

#include <math.h>
#include <iostream>
#include <string.h>



#include "mex.h"
#include "RSIntegral.h"
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

  if (nrhs != 7) {
    mexErrMsgIdAndTxt("MATLAB:RSTransducerFieldMEX:nargin", 
            "7 arguments required: (rho, c, k, u_pos, u_amp, pressure, dx )");
  } 

  double rho = mxGetScalar(prhs[0]);
  double c = mxGetScalar(prhs[1]);
  double kr = mxGetScalar(prhs[2]);
  
  const mxArray * deltaX = prhs[6];
  const mxArray * pressure = prhs[5];
  const mxArray * u_ampvec = prhs[4];
  const mxArray * u_xyzvec = prhs[3];

  long meshDims[3];
  long nPressureDims = (long)mxGetNumberOfDimensions( pressure );
  const mwSize* pDims = mxGetDimensions( pressure );

  if (! mxIsComplex(u_ampvec)  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RSTransducerFieldMEX:inputsNotComplex",
              "Input 5 (u vector) must be complex.\n");
  }
  if (! mxIsComplex(pressure)  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RSTransducerFieldMEX:inputsNotComplex",
              "Input 6 (pressure field array) must be complex.\n");
  }

  if (nPressureDims != 3) {
    mexErrMsgIdAndTxt("MATLAB:RSTransducerFieldMEX:ndims", 
            "pressure argument must be 3-D array of complex values (Nx x Ny x Nz)");
  } 

  if ( mxGetM(u_xyzvec) != 3 ) {
      mexErrMsgIdAndTxt("MATLAB:RSTransducerFieldMEX:dims", 
            "u_pos must be a 3xN array of positions");
  }

  long nTransducers = mxGetN( u_xyzvec );

  if (nTransducers != mxGetN( u_ampvec) )
  {
      mexErrMsgIdAndTxt("MATLAB:RSTransducerFieldMEX:dims", 
            "u_pos and u_amp must have the same length");
  }

  long i;
  for (i=0;i<3;i++) {
      meshDims[i] = pDims[i];
  }

  double * pre = mxGetPr( pressure ) ;
  double * pim = mxGetPi( pressure );
  double * ure = mxGetPr( u_ampvec );
  double * uim = mxGetPi( u_ampvec );
  double * uxyz = (double*)mxGetData( u_xyzvec ); 
  double * meshRes = (double*)mxGetData(deltaX);


  MeshFunction3D<double> pFieldRe;
  MeshFunction3D<double> pFieldIm;
  pFieldRe.isRowMaj=false;
  pFieldIm.isRowMaj=false;
  pFieldRe.useSharedData(meshDims,pre,meshRes);
  pFieldIm.useSharedData(meshDims,pim,meshRes);

  complex<double> un_amp;
  double position[3];
  long k;
  for (i=0; i< nTransducers; i++)
  {
      for (k=0;k<3;k++) position[k] = uxyz[k*3 + i] ;

      cout << uxyz[i] << " " << uxyz[3 + i] << " " << uxyz[6 + i] << endl;

      un_amp = ure[i] + I*uim[i];

      RSComputeHomogeneous( un_amp, rho, c, kr, position, &pFieldRe, &pFieldIm );

  }

  return;
}
