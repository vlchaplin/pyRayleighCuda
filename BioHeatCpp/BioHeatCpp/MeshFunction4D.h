
#ifndef MESHFUNC4D_H
#define MESHFUNC4D_H

#include "MeshFunction.h"
#include "MeshFunction3D.h"


//! Default constructor; calls base class MeshFunction, allocates two 4-element arrays. this->data array not allocated.  Cleanup will be automatic.
    /*!
     The two pointer arguments are multi-dimensional arrays returned by allocate_sized_components(). Prior to calling this function the 0th order input spectrum must be normalized to 1.0 and written into P_components[0], where P_components[0][i] is the ith channel. The spectrum channel edges must be the same as those defined in the instance of PPUModelthis->data, which can be obtained with PPUModelthis->data::edges_ptr() and PPUModelthis->data::numChannels().
     On return from this function, P_components[k] is the address for the kth order spectral state (a probability function), <tt> and P_components[k][i] </tt> is the ith channel of that array.
     Likewise, <tt> Q_components[a][b][c] </tt> is the address of the tail spectrum for state <abc>, and <tt> Q_components[a][b][c][i] </tt> is the ith channel of the <abc> spectrum.  
     Since there are no tail measurements for c=0, all Q_components[a][b][0] are set to NULL.
     \param P_components Allocated array to hold peak spectral components. Use allocate_sized_components() to allocate the P and Q arrays 
     \param Q_components Allocated array to hold tail spectral components
     \param maxOrder Order to calculate (if absent, <tt> correspondingthis->data.maxOrdToCalc </tt> is used)
     \sa allocate_sized_components
     */

template<typename mesh_t>
class MeshFunction4D : public MeshFunction<mesh_t>
{
	 
public:

    //! Default constructor; calls base class MeshFunction, allocates two 4-element arrays. this->data array not allocated.  Cleanup will be automatic.
    MeshFunction4D() : MeshFunction<mesh_t>(4)  {
        
    };

    //! Array of this->data type <tt> mesh_t </tt> is allocated and has size n1*n2*n3*n4.  Total memory size is this size*sizeof(mesh_t), the template this->data type.
	MeshFunction4D(long n1, long n2, long n3, long n4) : MeshFunction<mesh_t>(4) {

		this->d[0]=n1;
		this->d[1]=n2;
		this->d[2]=n3;
		this->d[3]=n4;
		this->data = new mesh_t[n1*n2*n3*n4];
	};
	~MeshFunction4D()
	{

	};

    virtual long index(long& i0, long& i1, long& i2, long& i3)
    {
        if (this->isRowMaj) 
            return i0*this->d[1]*this->d[2]*this->d[3] + i1*this->d[2]*this->d[3] + i2*this->d[3] + i3 ;
        else
            return i3*this->d[0]*this->d[1]*this->d[2] + i2*this->d[0]*this->d[1] + i1*this->d[0] + i0;
    };
    virtual long index(long *& idx)
    {
        if (this->isRowMaj) 
            return idx[0]*this->d[1]*this->d[2]*this->d[3] + idx[1]*this->d[2]*this->d[3] + idx[2]*this->d[3] + idx[3];
        else
            return idx[3]*this->d[0]*this->d[1]*this->d[2] + idx[2]*this->d[0]*this->d[1] + idx[1]*this->d[0] + idx[0];
    };

	virtual mesh_t& val(long * idx) {
		return this->data[index(idx)];
	};
	mesh_t& val(long i0, long i1, long i2, long i3) {
		return this->data[index(i0,i1,i2,i3)];
	};
    mesh_t& operator()(long i0, long i1, long i2, long i3) {
		return this->data[index(i0,i1,i2,i3)];
	};

    //remember to delete the page in the caller after using it
    MeshFunction3D<mesh_t> * getpage(long i0) {
        static long zero=0;
        mesh_t * pageaddr = this->data + index(i0,zero,zero,zero);

        MeshFunction3D<mesh_t> * newpage = new MeshFunction3D<mesh_t> ;

        newpage->useSharedData(this->d+1,pageaddr,this->ds+1);

        return newpage;
    };

};






template<typename mesh_t>
class MeshFunctionPseudo4D : public MeshFunction4D<mesh_t>
{
	 
public:
	
    MeshFunctionPseudo4D() {
        
    };
    MeshFunctionPseudo4D(long n2, long n3, long n4) {

		this->d[0]=0;
		this->d[1]=n2;
		this->d[2]=n3;
		this->d[3]=n4;
		this->data = new mesh_t[n2*n3*n4];
	};
	MeshFunctionPseudo4D(long n1, long n2, long n3, long n4) {

		this->d[0]=0;
		this->d[1]=n2;
		this->d[2]=n3;
		this->d[3]=n4;
		this->data = new mesh_t[n2*n3*n4];
	};
	~MeshFunctionPseudo4D()
	{

	};

    virtual long index(long& i0, long& i1, long& i2, long& i3)
    {
        if (this->isRowMaj) 
            return i1*this->d[2]*this->d[3] + i2*this->d[3] + i3 ;
        else
            return i3*this->d[1]*this->d[2] + i2*this->d[1] + i1;
    };
    virtual long index(long *& idx)
    {
        if (this->isRowMaj) 
            return idx[1]*this->d[2]*this->d[3] + idx[2]*this->d[3] + idx[3];
        else
            return idx[3]*this->d[1]*this->d[2] + idx[2]*this->d[1] + idx[1];
    };

};








#endif