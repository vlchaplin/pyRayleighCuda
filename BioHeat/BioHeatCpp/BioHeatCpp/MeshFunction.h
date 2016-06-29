
#ifndef MESHFUNC_H
#define MESHFUNC_H

#include "stdlib.h"
#include <iostream>

using namespace std;

// Base class for to use in an abstract factory and sub-typing the 3D and 4D versions
// This base class also handles the shared data lifecyle, though the actual interface would be through
// one of the subclasses.
template<typename mesh_t>
class MeshFunction 
{

public:
    long * d; //will be array of dimensions. This class is 0-D (a scalar), not 1-D.
    mesh_t * ds; //will be array of resolution step
    mesh_t * data; //will be pointing to grid data. This pointer can be shareable, perhaps allocated elsewhere.
    mesh_t scalar; // the "data" for a MeshFunction<> object. Not super useful but is logically consistent

private:
    
public:
    long ndims;
    bool usesSharedData;

	MeshFunction() {
        ndims=0;
        d=NULL;
        ds=NULL;
        data=NULL;
        usesSharedData=false;
        isRowMaj=true;
    };

	//This constructor is called from each sub-class constructor (instead of the default)
	//to init pointers and define the dimensionality.
    MeshFunction(long n) {
        d=NULL;
        ds=NULL;
        data=NULL;
        usesSharedData=false;
        isRowMaj=true;
        this->setndims(n);
    };
    ~MeshFunction() {

        this->clear();

        if ( d!=NULL ) {
            delete [] d;
            delete [] ds;
        }
    };
    void setndims(long num) {
        this->ndims=num;
        if ( d!=NULL || num==0 ) {
            delete [] d;
            delete [] ds;
            d=NULL;
            ds=NULL;
        }
        if (num>0) {
            this->d = new long[ndims];
            this->ds = new mesh_t[ndims];
        }
    };
    void setdims(long * dims)
    {
        long i;
        long n=this->getndims();
        this->setndims(n);
        for(i=0;i<n;i++)
        {
            d[i] = dims[i];
        }
        
    };
	
public:

    bool isRowMaj;

    long getndims() {
        return this->ndims;
    };
    void getdims(long * dims) {
        long i;
        for ( i=0; i<ndims; i++) dims[i] = d[i];
    };
    void setres(mesh_t * dres) { for(int i=0; i<ndims;i++) ds[i]=dres[i]; };
    void getres(mesh_t * dres) { for(int i=0; i<ndims;i++) dres[i]=ds[i]; };

    void clear() {
        if (data != NULL && (!usesSharedData) ) {
            delete [] data;
            data=NULL;
        }
        if (d!=NULL) {
            delete [] d;
            delete [] ds;
            d=NULL;
            ds=NULL;
        }
    };

    //set the entire mesh to a scalar
    void setToScalar(mesh_t value)
    {
        if ( data==NULL || d==NULL) return;
        long nd = this->getndims();
        long i,maxi;
        maxi=d[0];
        for (i=1;i<nd;i++)
            maxi*=d[i];

        maxi--;

        for (i=0;i<=maxi;i++)
            this->data[i] = value;

    };

	// void useSharedData(...)
	// This important method passes in a pointer to data block (ptr2meshdata) which 
	// corresponds a mesh with 'dims' dimensions (i.e., size dims[0]*dims[1]*...*dims[n-1] ).
	// The usesShared flag is set, which prevents that data block from being freed when
	// this object gets destroyed (otherwise the object would assume it allocated the data block
	// and must therefore free it on destruction). 'ptr2meshdata' memory must be freed from the calling program.
	// However the 'dims' and 'resolution' values are copied into object memory. This applies to all subclasses.  

    void useSharedData( long * dims, mesh_t * ptr2meshdata, mesh_t * resolution )
    {
        long ndims = this->getndims();
        if (ndims <=0 ) return;

        
        this->clear();
        this->setndims(ndims);
        this->setdims(dims);
        this->setres(resolution);
        
        data = ptr2meshdata;
        usesSharedData=true;
    };

    virtual mesh_t& val(long *idx) {return scalar;};

};






#endif