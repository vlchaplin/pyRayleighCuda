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

  if (nrhs != 3) {
    mexErrMsgIdAndTxt("MATLAB:RS_R2gradMEX:nargin", 
            "3 arguments required: (u, H, p)");
  } 

  if (! mxIsComplex(prhs[0])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2gradMEX:inputsNotComplex",
              "Inputs 1 (u vector) must be complex.\n");
  }
  if (! mxIsComplex(prhs[1])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2gradMEX:inputsNotComplex",
              "Inputs 2 (H vector) must be complex.\n");
  }
  if (! mxIsComplex(prhs[2])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2gradMEX:inputsNotComplex",
              "Inputs 3 (p vector) must be complex.\n");
  }

  size_t nu = mxGetN(prhs[0]);
  size_t mH = mxGetM(prhs[1]);
  size_t nH = mxGetN(prhs[1]);
  size_t np = mxGetN(prhs[2]);

  if ( nu != mH  ) {
	  char msg[1000];
	  sprintf( msg, "Input dimensions must be agree... dim(H*u) = dim(p).  Nu = %d, H = %d x %d, Np = %d \n", nu, mH, nH, np);
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2gradMEX:dimensions",
              msg);
  }

  double * gradF;
  double * Hre, * Him, * pre, * pim, *ure, *uim, retval;

  ure = mxGetPr(prhs[0]);
  uim = mxGetPi(prhs[0]);

  Hre = mxGetPr(prhs[1]);
  Him = mxGetPi(prhs[1]);

  pre = mxGetPr(prhs[2]);
  pim = mxGetPi(prhs[2]);  

  plhs[0] = mxCreateNumericMatrix(1, 2*nu, mxDOUBLE_CLASS, mxREAL);

  gradF = mxGetPr(plhs[0]);
  RS_R2gradient(ure, uim, Hre, Him, pre, pim, np, nu, gradF );



  return;
}