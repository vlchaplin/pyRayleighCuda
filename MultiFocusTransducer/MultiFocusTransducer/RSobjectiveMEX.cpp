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
    mexErrMsgIdAndTxt("MATLAB:RSobjectiveMEX:nargin", 
            "4 arguments required: (a, d, H, p)");
  } 

  if ( !mxIsComplex(prhs[2]) || !mxIsComplex(prhs[3]) )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RSobjectiveMEX:inputsNotComplex",
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
	  mexErrMsgIdAndTxt( "MATLAB:RSobjectiveMEX:dimensions",
              msg);
  }

  double * Hre, * Him, * pre, * pim, *a, *d, retval;

  a = (double *) mxGetPr(prhs[0]);
  d = (double *) mxGetPr(prhs[1]);

  Hre = mxGetPr(prhs[2]);
  Him = mxGetPi(prhs[2]);

  pre = mxGetPr(prhs[3]);
  pim = mxGetPi(prhs[3]);  

  retval = RS_objective(a, d, Hre, Him, pre, pim, np, na);

  plhs[0] = mxCreateDoubleScalar( retval );

  return;
}
