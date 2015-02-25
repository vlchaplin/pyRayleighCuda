
#ifndef MESHFUNC_H
#define MESHFUNC_H

#include "stdlib.h"



template<typename mesh_t>
class MeshFunction 
{

public:
    long * d;
    mesh_t * ds;
    mesh_t * data;

    
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
    MeshFunction(long n) {
        d=NULL;
        ds=NULL;
        data=NULL;
        usesSharedData=false;
        isRowMaj=true;
        this->setndims(n);
    };
    ~MeshFunction() {
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

    //virtual mesh_t& val(long *idx)=0;

};






#endif