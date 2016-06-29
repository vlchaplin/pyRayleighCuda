
#ifndef MESHFUNC3D_H
#define MESHFUNC3D_H

#include "MeshFunction.h"

template<typename mesh_t>
class MeshFunction3D : public MeshFunction<mesh_t>
{

public:
	
    MeshFunction3D() : MeshFunction<mesh_t>(3) {

	};

	MeshFunction3D(long n1, long n2, long n3) : MeshFunction<mesh_t>(3) {
		this->d[0]=n1;
		this->d[1]=n2;
		this->d[2]=n3;
		this->data = new mesh_t[n1*n2*n3];
	};
    MeshFunction3D(mesh_t*array,long n1, long n2, long n3) : MeshFunction<mesh_t>(3) {
		
        this->d[0]=n1;
		this->d[1]=n2;
		this->d[2]=n3;
		this->data = array;
	};
	~MeshFunction3D()
	{
        this->clear();
	};
    
    long index(long& i0, long& i1, long& i2)
    {
        if (this->isRowMaj) 
            return i0*this->d[1]*this->d[2] + i1*this->d[2] + i2;
        else
            return i2*this->d[0]*this->d[1] + i1*this->d[0] + i0;
    };
    long index(long *& idx)
    {
        if (this->isRowMaj) 
            return idx[0]*this->d[1]*this->d[2] + idx[1]*this->d[2] + idx[2];
        else
            return idx[2]*this->d[0]*this->d[1] + idx[1]*this->d[0] + idx[0];
    };

	virtual mesh_t& val(long * idx) {
		return this->data[this->index(idx)];
	};
	mesh_t& val(long i0, long i1, long i2) {
		return this->data[this->index(i0,i1,i2)];
	};
    mesh_t& operator()(long i0, long i1, long i2) {
		return this->data[this->index(i0,i1,i2)];
	};
    mesh_t getval(long i0, long i1, long i2) {
		return this->data[this->index(i0,i1,i2)];
	};
    void setval(mesh_t val, long i0, long i1, long i2) {
		this->data[this->index(i0,i1,i2)] = val;
	};

};






#endif