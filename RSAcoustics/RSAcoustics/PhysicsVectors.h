#ifndef PHYSVECTORS_H
#define PHYSVECTORS_H 1
 
#include <stddef.h>
#include <stdlib.h>
#include <cstring>
#include <math.h>
#include <vector>
#include <iostream>

using namespace std;

namespace physvec {
	double PI = 4.0*atan(1.0);
	double DTOR = PI/180.0;
	
	inline double deg2rad(double& d) { return d*DTOR; };
	inline double rad2deg(double& r) { return r/DTOR; };
	
	class x3 {
		public:
		double x0;
		double x1;
		double x2;
		
		x3(){
			x0 = x1 = x2 = 0.0;
		};
		x3(double q0, double q1, double q2) : x0(q0), x1(q1), x2(q2) {};
		x3(double * vect) {
			set(vect);
		};
		
		x3& set(double * vect) {
			x0 = *vect;
			x1 = *(vect+1);
			x2 = *(vect+2);
			return *this;
		}
		
		double mag() {
			return sqrt(x0*x0 + x1*x1 +x2*x2);
		};
		friend double dot(x3& ths, x3& that) {
			return ths.x0 * that.x0 + ths.x1 * that.x1 + ths.x2 * that.x2;
		};
		x3 operator+(x3& that) {
			return x3(x0 + that.x0, x1 + that.x1, x2 + that.x2);
		};
		x3 operator-(x3& that) {
			return x3(x0 - that.x0, x1 - that.x1, x2 - that.x2);
		};
		x3 operator*(x3& that) {
			return x3(x0 * that.x0, x1 * that.x1, x2 * that.x2);
		};
		x3 operator+(double scalar) {
			return x3(x0 + scalar, x1 + scalar, x2 + scalar);
		};
		x3 operator-(double scalar) {
			return x3(x0 - scalar, x1 - scalar, x2 - scalar);
		};
		x3 operator*(double scalar) {
			return x3(x0 * scalar, x1 * scalar, x2 * scalar);
		};
		x3 operator/(double scalar) {
			return x3(x0 / scalar, x1 / scalar, x2 / scalar);
		};
		x3& operator+=(x3& that) {
			x0 += that.x0;
			x1 += that.x1;
			x2 += that.x2;
			return *this;
		};
		x3& operator-=(x3& that) {
			x0 -= that.x0;
			x1 -= that.x1;
			x2 -= that.x2;
			return *this;
		};
		x3& operator=(double scalar) {
			x0 = x1 = x2 = scalar;
			return *this;
		};
		x3& operator+=(double scalar) {
			x0 += scalar;
			x1 += scalar;
			x2 += scalar;
			return *this;
		};
		x3& operator-=(double scalar) {
			x0 -= scalar;
			x1 -= scalar;
			x2 -= scalar;
			return *this;
		};
		x3& operator*=(double scalar) {
			x0 *= scalar;
			x1 *= scalar;
			x2 *= scalar;
			return *this;
		};
		x3& operator/=(double scalar) {
			x0 /= scalar;
			x1 /= scalar;
			x2 /= scalar;
			return *this;
		};
		template<typename T>
		x3& operator=(vector<T>& vec3) {
			x0 = vec3[0];
			x1 = vec3[1];
			x2 = vec3[2];
			return *this;
		};
		double& operator[](int i) {
			switch (i % 3) {
				case 0: return x0;
				case 1: return x1;
				case 2: return x2;
				default: return x0;
			};
		};
		
		friend ostream& operator<<(ostream& os, x3& data)
		{
			os << "(" << data.x0 << "," << data.x1 << "," << data.x2 << ")";
			return os;
		}
		
	};
    template<typename T> 
    T distance( T* r0, T * r1 )
    {
        return sqrt( (r0[0] - r1[0])*(r0[0] - r1[0]) + (r0[1]-r1[1])*(r0[1]-r1[1]) + (r0[2] - r1[2])*(r0[2] - r1[2]) );
    };
    template<typename T> 
    T distance( x3& r0, T * r1 )
    {
        return sqrt( (r0[0] - r1[0])*(r0[0] - r1[0]) + (r0[1]-r1[1])*(r0[1]-r1[1]) + (r0[2] - r1[2])*(r0[2] - r1[2]) );
    };
    double distance( x3& r0, x3& r1 )
    {
        x3 delta = r0 - r1;
        return delta.mag();
    }


	template<typename T> 
	inline T vdot(const vector<T>& a,const vector<T>& b, unsigned int cos=0) {
		typename vector<T>::size_type i,N;
		N = a.size();
		if (b.size() < N) N = b.size();
		
		i=0;
		T dot = 0;
		if (cos == 0) {
			while (i < N) dot += a[i]*b[i++];
		}
		else {
			T norm1 = 0;
			T norm2 = 0;
			while (i < N) {
				dot += a[i]*b[i];
				norm1 += pow(a[i],2);
				norm2 += pow(b[i],2);
				i++;
			}
			
			//cout << "dot = " << dot << "," << norm1 << "," << norm2 << endl;
			
			dot /= (sqrt(norm1)*sqrt(norm2));
			
			
			if (dot > 1.0) dot = 1.0;
			else if (dot < -1.0) dot = -1.0;
			
			if ( cos > 1 ) dot = acos(dot);
		}
		
		
		return dot;
	};

	/* q = xyquadrant(x,y):
	q : 
			 +y
			  |
			2 | 1 
	   -x ----|---- +x
			3 | 4 
			 -y
	*/
	template<typename T>
	inline int xyquadrant( T& x, T& y) {
				
		int i,j,q,jdim;
		if (x > 0) j=1; else j=0;
		if (y < 0) i=1; else i=0;

		jdim=2;
		if (i % 2 == 0) q = i*jdim + (jdim - j-1); 
		else q = i*jdim + j;

		return q+1;
	};

	template<typename T>
	inline vector<T>& vec3(vector<T>& v,T v0,T v1,T v2) {
		v.resize(3);
		v[0] = v0;
		v[1] = v1;
		v[2] = v2;
		return v;
	};

	template<typename T>
	inline vector<T>& sphere2cart (vector<T>& v, T& az, T& el) {
		
		double x,y,z;
		x = cos(DTOR*az)*cos(DTOR*el);
		y = sin(DTOR*az)*cos(DTOR*el);
		z = sin(DTOR*el);
		
		return vec3( v, x,y,z);
	};
	inline x3& sphere2cart (x3& v, double& az, double& el, int u=0) {

		if (u == 1) {
			v[0] = cos(DTOR*az)*cos(DTOR*el);
			v[1] = sin(DTOR*az)*cos(DTOR*el);
			v[2] = sin(DTOR*el);
		} else {
			v[0] = cos(az)*cos(el);
			v[1] = sin(az)*cos(el);
			v[2] = sin(el);
		}
		
		return v;
	};
	inline void cart2sphere (x3& v, double& az, double& el, int u=0) {
		double r = v.mag();
		az = atan( v[1] / v[0] );
		el = asin( v[2] / r );
		if (v[0] < 0) az += PI;
		
		if (az < 0) az += (PI+PI);
		
		if (u == 1) {
			az /= DTOR;
			el /= DTOR;
		};
		
	};
	inline void cart2sphere (x3& v, double& r, double& az, double& el, int u=0) {
		r = v.mag();
		az = atan( v[1] / v[0] );
		el = asin( v[2] / r );
		if (v[0] < 0) az += PI;
		
		if (az < 0) az += (PI+PI);
		
		if (u == 1) {
			az /= DTOR;
			el /= DTOR;
		};
		
	};
	
	class Rmatrix {
		private:
		double _A[3][3];
		
		public:
		
		friend class quaternion;
		
		Rmatrix(){};
		Rmatrix(double g00, double g11, double g22) {
			this->zero();
			this->setdiag(g00,g11,g22);
		};
		
		void setdiag(double g00, double g11, double g22) {
			(*this)(0,0) = g00;
			(*this)(1,1) = g11;
			(*this)(2,2) = g22;
		};
		void zero() {
			size_t i,m,n;
			i=0;
			while(i<9) {
				m = i / 3;
				n = i % 3;
				(*this)(m,n) = 0;
				i++;
			}
		};
		void identity() {
			this->zero();
			this->setdiag(1.0, 1.0, 1.0);
		};
		
		Rmatrix& tr() {
			Rmatrix tmp  = *this;
			size_t i,m,n;
			i=0;
			while(i<9) {
				m = i / 3;
				n = i % 3;
				(*this)(m,n) = tmp(n,m);
				i++;
			}
			return *this;
		};
		
		double& operator() (size_t& m, size_t& n) {
			return _A[m][n];
		};
		double& operator() (int m, int n) {
			return _A[m][n];
		};
		Rmatrix& operator= (double scalar) {
			size_t i,j;
			i=0;
			while(i < 3) {
				j=0;
				while(j < 3) {
					(*this)(i,j) = scalar;
					j++;
				}
				i++;
			}
			
			return *this;
		};
		virtual Rmatrix& operator= (Rmatrix& that) {
			size_t i,j;
			i=0;
			while(i < 3) {
				j=0;
				while(j < 3) {
					(*this)(i,j) = that(i,j);
					j++;
				}
				i++;
			}
			
			return *this;
		};
		Rmatrix operator* (Rmatrix& that) {			
			Rmatrix tmp;
			
			size_t i,j,q;
			i=0;
			while(i < 3) {
				j=0;
				while(j < 3)  {
					q=0;
					tmp(i,j)=0;
					while(q < 3) {
						tmp(i,j) += (*this)(i,q)*that(q,j);
						q++;
					}
					j++;
				}
				
				i++;
			}
			
			return tmp;
		};
		
		//Note about self-assignment:
		/*
		A *= B is equivalent to A = B*A
		
		This operation is the reverse of typical self-assignment operators,
		where x *= y usually is equivalent as x = x * y.
		
		This is to take advantage of
		familiar concepts from matrix algebra where B 'operates' on A,
		and results in a mutated A.
				
		Using self-assignment allows
		mutation with less memory overhead, as the construction
		A = B*A requires holding the result in a temporary allocation
		and using the copy constructor =.
		
		If Pn is the nth product of matrices n+1 R, then the inefficient way to
		calculate Pn is:
		
		P1 = R1*R0
		P2 = R2*P1 = R2*(R1*R0)
		P3 = R3*P2 = R3*(R2*(R1*R0))
		.
		.
		Pn = Rn * (Rn-1 * (Rn-2 * ... (R3 * (R2 * (R1 * R0))) ... );
		
		This would result in allocating a temporary 3x3 matrix n times, and
		copying it n times.
		
		An equivalent formula which does not allocate any uneccesary memory is:
				
		( ... (((R0*=R1) *= R2) *= R3) ... ) *= Rn-2) *= Rn-1) *= Rn );
		
		Now, R0 has been mutated n times, and our nth product Pn equals the new R0;
		
		In C++, this composition could be written in a loop, for n+1 matrices.
		If we don't want to effect R0, then simply initializing Pn = R0 before
		calculating the product let's us use *= operations on the variable Pn.
		
		
		Rmatrix R[n+1]; //the Rn matrices
		Rmatrix Pn;   //to hold product of the Rn matrices
		...code to define R[n]...
		
		Pn = R0; //initialize
		
		for(i=1; i<n+1; i++) {
			Pn *= R[i];
		}
		
		//now Pn equals the compound operation of all R matrices.
		*/
		
		Rmatrix& operator*= (Rmatrix& that) {
			double ell[3];
			size_t i,j,q;
			i=0;
			while(i < 3) {
				j=0;
				while(j < 3)  {
					q=0;
					ell[j]=0;
					while(q < 3) {
						ell[j] += (*this)(i,q)*that(q,j);
						q+=1;
					}
					j+=1;
				}
				
				j=0;
				while(j < 3) {
					(*this)(i,j) = ell[j];
					j+=1;
				}
				i+=1;
			}
			
			return *this;
		};
		
		template<typename T>
		vector<T> rot(vector<T>& v) {
			size_t i,q;
			vector<T> vprime(3);
			i=0;
			while(i<3) {
				vprime[i]=0;
				q=0;
				while(q < 3) vprime[i] += (*this)(i,q)*v[q++];
				i=i+1;
			}
			return vprime;
		};
		
		x3& rot(x3& point) {
			x3 tmp = point;
			size_t i,q;
			i=0;
			while(i<3) {
				point[i]=0;
				q=0;
				while(q < 3) {
					point[i] += (*this)(i,q)*tmp[q];
					q+=1;
				}
				i=i+1;
			}
			return point;
		};
	};

	extern Rmatrix I3;
	
	class Rzyz : public Rmatrix {
	
	    private:
	    double a1;
	    double a2;
	    double a3;
	
	    public:
	    Rzyz() {
		
	
	    };
	    Rzyz(double z_rot, double yp_rot, double zpp_rot) {
		
		    this->set(z_rot, yp_rot, zpp_rot);
	    };
	
	    Rzyz& set(double& z_rot, double& yp_rot, double& zpp_rot) {
		    a1 = z_rot;
		    a2 = yp_rot;
		    a3 = zpp_rot;
		    double c1 = cos(z_rot);
		    double s1 = sin(z_rot);
		    double c2 = cos(yp_rot);
		    double s2 = sin(yp_rot);
		    double c3 = cos(zpp_rot);
		    double s3 = sin(zpp_rot);
		
		    (*this)(0,0) = c1*c2*c3 - s1*s3;
		    (*this)(0,1) = s1*c2*c3 + c1*s3;
		    (*this)(0,2) = -s2*c3;
		
		    (*this)(1,0) = -c1*c2*s3 - s1*c3;
		    (*this)(1,1) = -s1*c2*s3 + c1*c3;
		    (*this)(1,2) = s2*s3;
		
		    (*this)(2,0) = c1*s2;
		    (*this)(2,1) = s1*s2;
		    (*this)(2,2) = c2;
		    return *this;
	    };
	
	    virtual Rzyz& operator=(Rmatrix& base) {
		    this->Rmatrix::operator=(base);
		    return *this;
	    };

    };
	
	class gquat {
		public:
		
		double qx;
		double qy;
		double qz;
		double qs;
		gquat(){};
		gquat(double q0, double q1, double q2, double q3) : qx(q0), qy(q1), qz(q2), qs(q3) {};
		gquat(double * vect) {
			set(vect);
		};
		
		gquat& set(double * vect ) {
			qx = *vect;
			qy = *(vect+1);
			qz = *(vect+2);
			qs = *(vect+3);
			return *this;
		}
		
		x3& rot(x3& v) {
			
			Rmatrix m;
			this->rm( m );
			m.rot( v );
			return v;
		};
		
		Rmatrix& rm(Rmatrix& m) {
			
			//left-handed matrix form:
			
			m(0,0) = qx*qx - qy*qy - qz*qz + qs*qs;
			m(1,1) = -qx*qx + qy*qy - qz*qz + qs*qs;
			m(2,2) = -qx*qx - qy*qy + qz*qz + qs*qs;
			
			m(0,1) = 2 * ( qx*qy + qz*qs );
			m(0,2) = 2 * ( qx*qz - qy*qs );
			
			m(1,0) = 2 * ( qx*qy - qz*qs );
			m(1,2) = 2 * ( qx*qs + qy*qz );
			
			m(2,0) = 2 * ( qx*qz + qy*qs );
			m(2,1) = 2 * ( qy*qz - qx*qs );
			
			
			//Calculate product tensor Q
			//There are 9 unique combinations of the components
			
			/*
			double Qp[] = { qx*qx, qx*qy, qx*qz, qx*qs,
							       qy*qy, qy*qz, qy*qs,
								          qz*qz, qz*qs,
										         qs*qs };
			
			
			//if Qij = q[i]*q[j] for all i,j
			//Qk = Qij, where k = i*4 + j - Sum(0+1+2...i) and j >= i, j < 4
			
			//now the equivalent matrix is:
			
			
			m(0,0) =  Qp[0] - Qp[4] - Qp[7] + Qp[9];
			m(1,1) = -Qp[0] + Qp[4] - Qp[7] + Qp[9];
			m(2,2) = -Qp[0] - Qp[4] + Qp[7] + Qp[9];
			
			m(0,1) = 2*( Qp[1] + Qp[8] );
			m(0,2) = 2*( Qp[2] - Qp[6] );
			
			m(1,0) = 2*( Qp[1] - Qp[8] );
			m(1,2) = 2*( Qp[3] + Qp[5] );
			
			m(2,0) = 2*( Qp[2] + Qp[6] );
			m(2,1) = 2*( Qp[5] - Qp[3] );
			*/
			
			return m;
		};
		
		
	};
	
	
	

};





#endif