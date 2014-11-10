// MultiFocusTransducer.cpp : Defines the entry point for the console application.
//

//#include "stdafx.h"

#include "MultiDimArrays.h"
#include "RaySommPressure.h"
#include <math.h>
#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
	const complex<double> I(0,1);
	cout << "allo" << endl;
	
	typedef complex<double> _mytype;

	size_t M=5;
	size_t N=5;
	long m,n;

	_mytype crap[] = { 1.0 + I,I,I,I,I  , 1,1.0+I,I,I,I  ,  1,1,1.0+I,I,I  ,  1,1,1,1.0+I, I,  1,1,1,1,1.0+I   };

	_mytype ** H = Create2D< _mytype >(M , N);
	_mytype * p_control = new _mytype[M];
	_mytype * u = new _mytype[N];

	size_t * source_ijk = new size_t[N];
	double * source_params = new double[2*N];
	double * gradF = new double[2*N];
	double F, dFdu;
	double Rmn, kr = 2.0*PI/1.0;

	for (n=0; n<N; n++) {
		source_params[n] = 1;
		source_params[n+N]=1;

		u[n] = exp(I*source_params[n+N])*source_params[n];
		
	}
	char msg[1000];
	complex<double> f;
	for (m=0; m<M; m++) {

		p_control[m] = 0;

		for (n=0; n<N; n++) {
			
			//H[m][n] = PI*crap[m*N + n];
				
			//windows compiler = P.O.S.  m,n must explictely cast to signed or be signed types
			Rmn = abs(0.1*double( m - n + 1)); //just junk not real for now

			if ( Rmn > 1e-03 ) {
				H[m][n] = I*exp( I*kr*Rmn ) / Rmn;
			}
			else {
				H[m][n] = 0; 
			}

			//sprintf_s(msg, "H[%d][%d] = <%f,%f>   Rmn = %f ", m, n, H[m][n].real(),  H[m][n].imag(), Rmn );
			//cout << msg << endl;
		}

	}

	F = RS_objective(source_params, source_params+N, H[0], p_control, M, N);

	RS_R2_objective(u, H[0], p_control, M, N);
	//dFdu = RS_gradient(source_params, source_params+N, H[0], p_control, M, N, gradF);

	//cout << "||gradF|| = " << dFdu << endl;
	cout << "kr = " << kr << endl;

	cout << "F = " << F << endl;

	Delete2D( H );
	delete [] source_params;
	delete [] p_control;

	cout << "Press return to quit" << endl;
	cin.get();
	return 0;
}

