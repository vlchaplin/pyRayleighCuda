#ifndef RAYSOMMP_H
#define RAYSOMMP_H

#include <math.h>
#include <stdlib.h>
#include <complex>
#include <iostream>

const double PI=4.0*atan(1.0);
const double PI2 = 2.0*PI;

using namespace std;


//! Objective function from the Ebbini paper, modified for complex u. F(u) = <Hu - p | Hu - p>
    /*! 
	\param a Array of transducer amplitudes (unknowns to be fit)
    \param d Array of transducer phase offsets (i.e., 0 to 2pi) (unknowns to be fit) 
    \param Hmat 1-D matrix of the H(m,n) Rayleigh-Sommerfield integrals, from a source at point n seen at observer point m
	\param p flattened control point pressure vector. 
     */
double RS_R2_objective( double * u_real, double * u_imag, double * H_real, double * H_imag, double * p_real, double * p_imag, size_t M, size_t N )
{
		const complex<double> I(0, 1);

	size_t ki, kj;
	size_t i,j,k;

	complex<double> Hki, Hki_conj, pk, pk_conj;

	complex<double> sum(0,0);

	complex<double> aH_k, bH_k, aHc_k, bHc_k;

	complex<double> * w= new complex<double> [M];
	complex<double> * wconj= new complex<double> [M];

	double ai,bi;

	std::cout << "MxN = " << M << "x" << N << endl;

	for (k=0; k<M; k++) {

		pk = complex<double> ( p_real[k] , p_imag[k] );
		pk_conj = conj(pk);

		aH_k = complex<double>(0,0);
		bH_k = complex<double>(0,0);
		aHc_k = complex<double>(0,0);
		bHc_k = complex<double>(0,0);

		w[k] = complex<double>(0,0);

		for (i=0; i<N; i++) {

			ki = k*N + i;

			Hki = H_real[ki] + I*H_imag[ki];
			Hki_conj = conj(Hki);

			ai = u_real[i];
			bi = u_imag[i];

			w[k] += Hki*(ai + I*bi);

			/*
			aH_k += ai*Hki;
			bH_k += bi*Hki;

			aHc_k += ai*Hki_conj;
			bHc_k += bi*Hki_conj;
			*/
		}

		w[k] -= pk;
		wconj[k] = conj(w[k]);

		//sum += ( (aHc_k - I*bHc_k)*(aH_k + I*bH_k) - pk*(aHc_k - I*bHc_k) - pk_conj*(aH_k + I*bH_k) +  pk_conj*pk);

		sum += w[k]*wconj[k];

	}

	delete [] w;
	delete [] wconj;

	cout << "Sum: " << endl;
	cout << sum << endl;

	return sum.real();
}


//! Gradient of the objective function from the Ebbini paper, modified for complex u. Pass a vector of length 2N to hold the gradient
    /*! 
	\param a Array of transducer amplitudes (unknowns to be fit)
    \param d Array of transducer phase offsets (i.e., 0 to 2pi) (unknowns to be fit) 
    \param Hmat 1-D matrix (M*N long) of the H(m,n) Rayleigh-Sommerfield integrals, from a source at point n seen at observer point m
	\param p flattened control point pressure vector (length M).
	\param gradF array to hold the result. Should be 2N elements long. Elements 0 ..N-1 is the amplitdue gradient, N..2N-1 is the phase gradient
     */
double RS_R2gradient( double * ure, double * uim, double * H_real, double * H_imag, double * p_real, double * p_imag, size_t M, size_t N, double * gradF )
{
	const complex<double> I(0, 1);

	size_t kn,kj;
	size_t n,j,k;

	double phik, aj,bj, HknStarHkj_re, HknStarHkj_im, HknStarpk_re, HknStarpk_im;

	complex<double> Hkn, Hkn_conj, Hkj, Hkj_conj, Hknconj_pk, Hknconj_Hkj, dFda_n, dFdb_n;
	complex<double> pk;

	double gradNorm=0;
	for(n=0; n<N; n++) {

		dFda_n = 0.0;  //derivatives w.r.t. real part
		dFdb_n = 0.0;  //derivatives w.r.t. imag part

		for (k=0; k<M; k++) {

			pk = p_real[k] + I*p_imag[k];
			kn = k*N + n;
			Hkn = H_real[kn] + I*H_imag[kn];
			Hkn_conj = conj(Hkn);

			Hknconj_pk = Hkn_conj*pk;

			dFda_n -= 2.0*Hknconj_pk.real();
			dFdb_n -= 2.0*Hknconj_pk.imag();

			for (j=0; j<N; j++) {

				kj = k*N + j;
				Hkj = H_real[kj] + I*H_imag[kj];
				Hkj_conj = conj(Hkj);

				Hknconj_Hkj = Hkn_conj*Hkj;

				aj = ure[j];
				bj = uim[j];


				//amplitude derivative 1st term
				dFda_n += aj*2.0 * Hknconj_Hkj.real();
				dFdb_n += bj*2.0 * Hknconj_Hkj.real();

				//phase derivative 1st term
				if (j!=n) {
					dFda_n -= bj*2.0*Hknconj_Hkj.imag();
					dFdb_n += aj*2.0*Hknconj_Hkj.imag();
				}
			}

		}

		cout << "dFda[n="<<n<<"]= " << dFda_n << " , dFdb[n="<<n<<"]= " << dFdb_n << endl;

		//both derivatives are entirely real (there is a small imag() part due only to float rounding)
		//convert from type complex<double> to double
		gradF[n] = dFda_n.real();
		gradF[n+N] = dFdb_n.real();

		gradNorm += pow( abs(dFda_n), 2.0 ) + pow( abs(dFdb_n), 2.0 );
	}

	return sqrt(gradNorm);
}

//! Objective function from the Ebbini paper, modified for complex u. F(u) = <Hu - p | Hu - p>
    /*! 
	\param a Array of transducer amplitudes (unknowns to be fit)
    \param d Array of transducer phase offsets (i.e., 0 to 2pi) (unknowns to be fit) 
    \param Hmat 1-D matrix of the H(m,n) Rayleigh-Sommerfield integrals, from a source at point n seen at observer point m
	\param p flattened control point pressure vector. 
     */
double RS_objective( double * a, double * d, double * H_real, double * H_imag, double * p_real, double * p_imag, size_t M, size_t N )
{
	const complex<double> I(0, 1);

	size_t ki, kj;
	size_t i,j,k;

	double pk, phik;

	complex<double> Hki, Hkj, Hki_conj, Hkj_conj;
	complex<double> dij, diphik;

	complex<double> sum(0,0);
	complex<double> term1a(0,0);
	complex<double> term1b(0,0);
	complex<double> term2(0,0);

	double tan_p;

	for (k=0; k<M; k++) {

		tan_p = p_imag[k] / p_real[k];

		if ( abs(p_real[k]) < 1e-14 ) {

			if ( p_imag[k] < 0 ) {
				if (p_real[k] <0 )
					phik=PI/2.0;
				else
					phik=-PI/2.0;
			} else if (p_real[k] > 0)
				phik = -PI/2.0;
			else
				phik = PI/2.0;

		} else {
			phik = atan( tan_p );
		}

		pk = sqrt( p_real[k]*p_real[k] + p_imag[k]*p_imag[k] );

		term1a = complex<double>(0,0);
		term1b = complex<double>(0,0);
		term2 = complex<double>(0,0);

		for (i=0; i<N; i++) {

			ki = k*N + i;

			Hki = H_real[ki] + I*H_imag[ki];
			Hki_conj = conj(Hki);

			diphik = I*(d[i] - phik);

			term2 -= a[i]*pk*( Hki*exp(diphik) + Hki_conj*exp(-diphik) ) ;

			term1a += a[i]*Hki_conj*exp(-d[i]);
			term1b += a[i]*Hki*exp(d[i]);
		}

		sum += (term1a*term1b + term2 + pk*pk);

	}

	cout << "Sum: " << endl;
	cout << sum << endl;

	return sum.real();
}



//! Gradient of the objective function from the Ebbini paper, modified for complex u. Pass a vector of length 2N to hold the gradient
    /*! 
	\param a Array of transducer amplitudes (unknowns to be fit)
    \param d Array of transducer phase offsets (i.e., 0 to 2pi) (unknowns to be fit) 
    \param Hmat 1-D matrix (M*N long) of the H(m,n) Rayleigh-Sommerfield integrals, from a source at point n seen at observer point m
	\param p flattened control point pressure vector (length M).
	\param gradF array to hold the result. Should be 2N elements long. Elements 0 ..N-1 is the amplitdue gradient, N..2N-1 is the phase gradient
     */
double RS_gradient( double * a, double * d, double * H_real, double * H_imag, double * p_real, double * p_imag, size_t M, size_t N, double * gradF )
{
	const complex<double> I(0, 1);

	size_t kn,kj;
	size_t n,j,k;

	double pk, phik, gradNorm, tan_p;

	complex<double> Hkn, Hkn_conj, Hkj, Hkj_conj;
	complex<double> djn, dnphik;
	complex<double> dFda_n(0,0);
	complex<double> dFdd_n(0,0);

	gradNorm=0;
	for(n=0; n<N; n++) {

		dFda_n = I*0.0;  //derivatives w.r.t. amplitude
		dFdd_n = I*0.0;  //  ''  ''    phase

		for (k=0; k<M; k++) {

			tan_p = p_imag[k] / p_real[k];

			if ( abs(p_real[k]) < 1e-14 ) {

				if ( p_imag[k] < 0 ) {
					if (p_real[k] <0 )
						phik=PI/2.0;
					else
						phik=-PI/2.0;
				} else if (p_real[k] > 0)
					phik = -PI/2.0;
				else
					phik = PI/2.0;

			} else {
				phik = atan( tan_p );
			}

			pk = sqrt( p_real[k]*p_real[k] + p_imag[k]*p_imag[k] );

			kn = k*N + n;
			Hkn = H_real[kn] + I*H_imag[kn];
			Hkn_conj = conj(Hkn);

			dnphik = I*(d[n] - phik);

			for (j=0; j<N; j++) {

				kj = k*N + j;
				Hkj = H_real[kj] + I*H_imag[kj];
				Hkj_conj = conj(Hkj);

				djn = I*( d[j] - d[n] );

				//amplitude derivative 1st term
				dFda_n += a[j]*( Hkn_conj*Hkj*exp(djn) + Hkn*Hkj_conj*exp(-djn) );

				//phase derivative 1st term
				if (j!=n) 
					dFdd_n -= I*a[n]*a[j]*(  Hkn_conj*Hkj*exp(djn) - Hkn*Hkj_conj*exp(-djn) );

			}

			//amplitude derivative 2nd term
			dFda_n -= pk*(Hkn*exp( dnphik ) + Hkn_conj*exp( -dnphik ));

			//phase derivative 2nd term
			dFdd_n -= I*a[n]*pk*(Hkn*exp( dnphik ) - Hkn_conj*exp( -dnphik ));

		}

		cout << "dFda[n="<<n<<"]= " << dFda_n << " , dFdd[n="<<n<<"]= " << dFdd_n << endl;

		//both derivatives are entirely real (there is a small imag() part due only to float rounding)
		//convert from type complex<double> to double
		gradF[n] = dFda_n.real();
		gradF[n+N] = dFdd_n.real();

		gradNorm += pow( abs(dFda_n), 2.0 ) + pow( abs(dFdd_n), 2.0 );
	}

	return sqrt(gradNorm);
}

double RS_objective( double * a, double * d, complex<double> * H, complex<double> * p, size_t M, size_t N )
{

	double * Hcomplex = new double[2*M*N];
	double * Hre = Hcomplex;
	double * Him = Hcomplex + M*N;

	double * pcomplex = new double[2*M];
	double * pre = pcomplex;
	double * pim = pcomplex + M;

	size_t n,m;

	for (m=0;m<M;m++)
	{
		pre[m] = p[m].real();
		pim[m] = p[m].imag();
		for(n=0;n<N;n++)
		{
			Hre[m*N + n] = H[m*N + n].real();
			Him[m*N + n] = H[m*N + n].imag();
		}
	}

	double ret;

	ret = RS_objective(a,d,Hre,Him,pre,pim,M,N);

	delete [] Hcomplex;
	delete [] pcomplex;

	return ret;
}


double RS_gradient( double * a, double * d, complex<double> * H, complex<double> * p, size_t M, size_t N, double * gradF )
{

	double * Hcomplex = new double[2*M*N];
	double * Hre = Hcomplex;
	double * Him = Hcomplex + M*N;

	double * pcomplex = new double[2*M];
	double * pre = pcomplex;
	double * pim = pcomplex + M;

	size_t n,m;

	for (m=0;m<M;m++)
	{
		pre[m] = p[m].real();
		pim[m] = p[m].imag();
		for(n=0;n<N;n++)
		{
			Hre[m*N + n] = H[m*N + n].real();
			Him[m*N + n] = H[m*N + n].imag();
		}
	}

	double ret;

	ret = RS_gradient(a,d,Hre,Him,pre,pim,M,N,gradF);

	delete [] Hcomplex;
	delete [] pcomplex;

	return ret;
}




double RS_R2_objective( complex<double> * u, complex<double> * H, complex<double> * p, size_t M, size_t N )
{

	double * ucomplex = new double[2*N];
	double * ure = ucomplex;
	double * uim = ucomplex + N;

	double * Hcomplex = new double[2*M*N];
	double * Hre = Hcomplex;
	double * Him = Hcomplex + M*N;

	double * pcomplex = new double[2*M];
	double * pre = pcomplex;
	double * pim = pcomplex + M;

	size_t n,m;

	for (m=0;m<M;m++)
	{
		pre[m] = p[m].real();
		pim[m] = p[m].imag();
		for(n=0;n<N;n++)
		{
			Hre[m*N + n] = H[m*N + n].real();
			Him[m*N + n] = H[m*N + n].imag();
		}
	}
	for(n=0;n<N;n++)
		{
			ure[n] = u[n].real();
			uim[n] = u[n].imag();
		}

	double ret;

	ret = RS_R2_objective(ure,uim,Hre,Him,pre,pim,M,N);

	delete [] Hcomplex;
	delete [] pcomplex;
	delete [] ucomplex;

	return ret;
}



#endif