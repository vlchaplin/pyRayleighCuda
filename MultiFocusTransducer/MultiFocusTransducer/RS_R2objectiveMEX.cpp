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
    mexErrMsgIdAndTxt("MATLAB:RS_R2objectiveMEX:nargin", 
            "3 arguments required: (u, H, p)");
  } 

  if (! mxIsComplex(prhs[0])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:inputsNotComplex",
              "Inputs 1 (u vector) must be complex.\n");
  }
  if (! mxIsComplex(prhs[1])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:inputsNotComplex",
              "Inputs 2 (H vector) must be complex.\n");
  }
  if (! mxIsComplex(prhs[2])  )
  {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:inputsNotComplex",
              "Inputs 3 (p vector) must be complex.\n");
  }

  size_t mu = mxGetM(prhs[0]);
  size_t nu = mxGetN(prhs[0]);
  size_t mH = mxGetM(prhs[1]);
  size_t nH = mxGetN(prhs[1]);
  size_t np = mxGetN(prhs[2]);
  size_t mp = mxGetM(prhs[2]);

  //check to see if p or u vector is transposed (aka see if matlab is retarded...yes it is)
  if ( np == 1 && mp > 1 ) { 
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:pvector",
              "The p vector must be 1 x M dimension (so the 1..Mth array elements have contiguous addresses).  MATLAB is column-major and doesn't use flat storage. No wonder it's so slow\n");
  }
  if ( nu == 1 && mu > 1 ) {
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:uvector",
              "The u vector must be 1 x N dimension (so the 1..Nth array elements have contiguous addresses).  MATLAB is column-major and doesn't use flat storage. No wonder it's so slow\n");
  }

  if ( nu != mH  ) {
	  char msg[1000];
	  sprintf( msg, "Input dimensions must be agree... dim(H*u) = dim(p).  Nu = %d, H = %d x %d, Np = %d \n", nu, mH, nH, np);
	  mexErrMsgIdAndTxt( "MATLAB:RS_R2objectiveMEX:dimensions",
              msg);
  }



  double * Hre, * Him, * pre, * pim, *ure, *uim, retval;

  ure = mxGetPr(prhs[0]);
  uim = mxGetPi(prhs[0]);

  Hre = mxGetPr(prhs[1]);
  Him = mxGetPi(prhs[1]);

  pre = mxGetPr(prhs[2]);
  pim = mxGetPi(prhs[2]);  

  retval = RS_R2_objective(ure, uim, Hre, Him, pre, pim, np, nu);

  plhs[0] = mxCreateDoubleScalar( retval );

  return;
}