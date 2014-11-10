#include "RaySommPressure.h"
#include <math.h>
#include <iostream>
#include <string.h>

#include "mex.h"

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

  if (nrhs != 4) {
    mexErrMsgIdAndTxt("MATLAB:RSgradMEX:nargin", 
            "4 arguments required: (a, d, H, p)");
  } 

  if ( !mxIsComplex(prhs[2]) || !mxIsComplex(prhs[3]) )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RSgradMEX:inputsNotComplex",
              "Inputs 3 and 4 (H matrix and p vector) must be complex.\n");
  }

  size_t na = mxGetN(prhs[0]);
  size_t nd = mxGetN(prhs[1]);
  size_t mH = mxGetM(prhs[2]);
  size_t nH = mxGetN(prhs[2]);
  size_t np = mxGetN(prhs[3]);

  if ( na != nd || nd != mH  ) {
	  char msg[1000];
	  sprintf( msg, "Input vectors must be the same length.  Na = %d, Nd = %d, H = %d x %d, Np = %d \n", na, nd, mH, nH, np);
	  mexErrMsgIdAndTxt( "MATLAB:RSgradMEX:dimensions",
              msg);
  }

  double * gradF;

  double * Hre, * Him, * pre, * pim, *a, *d;

  a = (double *) mxGetPr(prhs[0]);
  d = (double *) mxGetPr(prhs[1]);

  Hre = mxGetPr(prhs[2]);
  Him = mxGetPi(prhs[2]);

  pre = mxGetPr(prhs[3]);
  pim = mxGetPi(prhs[3]);  

  //returns a row vector to matlab
  plhs[0] = mxCreateNumericMatrix(1, 2*na, mxDOUBLE_CLASS, mxREAL);

  gradF = mxGetPr(plhs[0]);
  RS_gradient(a, d, Hre, Him, pre, pim, np, na, gradF );


  /* Put the C array into the mxArray and define its dimensions */
  //mxSetPr(plhs[0], gradF);
  //mxSetM(plhs[0], 1);
  //mxSetN(plhs[0], 2*na);

  //delete [] gradF;
  return;
}
