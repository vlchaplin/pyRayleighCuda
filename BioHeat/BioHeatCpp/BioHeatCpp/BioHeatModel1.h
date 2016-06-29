#ifndef BIOHEATMODEL1_H
#define BIOHEATMODEL1_H

#include <iostream>
#include "MeshFunction4D.h"

using namespace std;

/*
#ifndef MESH_T
#define MESH_T float
#endif
*/

template<typename MESH_T>
void Pennes_2ndOrder(long& ti, long& xi, long& yi, long& zi, MESH_T * ds, MeshFunction4D<MESH_T> * T, MeshFunction4D<MESH_T> * Tdot_source, MeshFunction3D<MESH_T> * kt0, MeshFunction3D<MESH_T> * rCp0  )
{
    //MeshFunction3D<MESH_T> * Tt0, *Tt1;
    //MESH_T ds[4];
    MESH_T dx,dy,dz,dt, dxdx, dydy, dzdz;

    MESH_T t0_xiyizi;
    MESH_T rho_Cp0, laplacainT, gradKdotgradT, ts_dot=0.0;

    //T->getres(ds);
    dt = ds[0]; dx = ds[1]; dy = ds[2]; dz = ds[3];
    dxdx = dx*dx;
    dydy = dy*dy;
    dzdz = dz*dz;


    rho_Cp0 = (*rCp0)(xi, yi, zi);

    t0_xiyizi = T->val(ti,xi,yi,zi);

    if ( Tdot_source != NULL ) ts_dot = (*Tdot_source)(ti,xi,yi,zi);

    laplacainT = 
        ( T->val(ti,xi+1,yi,zi) + T->val(ti,xi-1,yi,zi) - 2*t0_xiyizi ) / dxdx +
        ( T->val(ti,xi,yi+1,zi) + T->val(ti,xi,yi-1,zi) - 2*t0_xiyizi ) / dydy +
        ( T->val(ti,xi,yi,zi+1) + T->val(ti,xi,yi,zi-1) - 2*t0_xiyizi ) / dzdz;

    gradKdotgradT =
    (kt0->val(xi+1,yi,zi) - kt0->val(xi-1,yi,zi))/(2*dx) * (T->val(ti,xi+1,yi,zi) - T->val(ti,xi-1,yi,zi))/(2*dx) +
    (kt0->val(xi,yi+1,zi) - kt0->val(xi,yi-1,zi))/(2*dy) * (T->val(ti,xi,yi+1,zi) - T->val(ti,xi,yi-1,zi))/(2*dy) +
    (kt0->val(xi,yi,zi+1) - kt0->val(xi,yi,zi-1))/(2*dz) * (T->val(ti,xi,yi,zi+1) - T->val(ti,xi,yi,zi-1))/(2*dz);

    (*T)(ti+1,xi,yi,zi) = dt*ts_dot + t0_xiyizi + (kt0->val(xi,yi,zi)*laplacainT  + gradKdotgradT - (0.0)*(4100)*(t0_xiyizi - 37) ) * dt / rho_Cp0 ;
    

};



// perfusionrate should be units of 1/seconds
template<typename MESH_T>
void Pennes_Perfused(long& ti, long& xi, long& yi, long& zi, MESH_T * ds, MeshFunction4D<MESH_T> * T, MeshFunction4D<MESH_T> * Tdot_source, MeshFunction3D<MESH_T> * kt0, MeshFunction3D<MESH_T> * rCp0, MESH_T Tblood, MESH_T perfusionrate  )
{
    //MeshFunction3D<MESH_T> * Tt0, *Tt1;
    //MESH_T ds[4];
    MESH_T dx,dy,dz,dt, dxdx, dydy, dzdz;

    MESH_T t0_xiyizi;
    MESH_T rho_Cp0, laplacainT, gradKdotgradT, ts_dot=0.0;
    const double RhoCpBlood = 1060*4100; // (1060 kg/m^3 * 4100 J/(kg*C)) --> [J/m^3*C]

    

    //T->getres(ds);
    dt = ds[0]; dx = ds[1]; dy = ds[2]; dz = ds[3];
    dxdx = dx*dx;
    dydy = dy*dy;
    dzdz = dz*dz;


    rho_Cp0 = (*rCp0)(xi, yi, zi);

    t0_xiyizi = T->val(ti,xi,yi,zi);

    if ( Tdot_source != NULL ) ts_dot = (*Tdot_source)(ti,xi,yi,zi);

    laplacainT = 
        ( T->val(ti,xi+1,yi,zi) + T->val(ti,xi-1,yi,zi) - 2*t0_xiyizi ) / dxdx +
        ( T->val(ti,xi,yi+1,zi) + T->val(ti,xi,yi-1,zi) - 2*t0_xiyizi ) / dydy +
        ( T->val(ti,xi,yi,zi+1) + T->val(ti,xi,yi,zi-1) - 2*t0_xiyizi ) / dzdz;

    gradKdotgradT =
    (kt0->val(xi+1,yi,zi) - kt0->val(xi-1,yi,zi))/(2*dx) * (T->val(ti,xi+1,yi,zi) - T->val(ti,xi-1,yi,zi))/(2*dx) +
    (kt0->val(xi,yi+1,zi) - kt0->val(xi,yi-1,zi))/(2*dy) * (T->val(ti,xi,yi+1,zi) - T->val(ti,xi,yi-1,zi))/(2*dy) +
    (kt0->val(xi,yi,zi+1) - kt0->val(xi,yi,zi-1))/(2*dz) * (T->val(ti,xi,yi,zi+1) - T->val(ti,xi,yi,zi-1))/(2*dz);

    (*T)(ti+1,xi,yi,zi) = dt*ts_dot + t0_xiyizi + (kt0->val(xi,yi,zi)*laplacainT  + gradKdotgradT - (perfusionrate)*(RhoCpBlood)*(t0_xiyizi - Tblood) ) * dt / rho_Cp0 ;
    
};




template<typename MESH_T>
void Pennes_Perfused(long * txyz, MESH_T * ds, 
                     MeshFunction4D<MESH_T> * T, MeshFunction4D<MESH_T> * Tdot_source, 
                     MeshFunction3D<MESH_T> * kt0, MeshFunction3D<MESH_T> * rCp0, 
                     MESH_T Tblood, MESH_T perfusionrate  )
{
    
    //vector containing t,x,y,z tuples of each point in the finite template around the reference point (6 total)
    static long template4TupleSet[6*4];
	const long * vXa = &(template4TupleSet[0]);  const long * Xa = vXa + 1;
	const long * vXb = &(template4TupleSet[4]);  const long * Xb = vXb + 1;
	const long * vYa = &(template4TupleSet[8]);  const long * Ya = vYa + 1;
	const long * vYb = &(template4TupleSet[12]);  const long * Yb = vYb + 1;
	const long * vZa = &(template4TupleSet[16]);  const long * Za = vZa + 1;
	const long * vZb = &(template4TupleSet[20]);  const long * Zb = vZb + 1;
    const long XvertStep[] = {-1, 1, 0, 0, 0, 0};
    const long YvertStep[] = { 0, 0,-1, 1, 0, 0};
    const long ZvertStep[] = { 0, 0, 0, 0,-1, 1};

    static MESH_T Tpoints[6];
    static MESH_T Kpoints[6];
    
    long i,v;
    for (v=0; v<6; v++) 
    {
        i = v*4;
        template4TupleSet[i] = txyz[0];
        template4TupleSet[i+1] = txyz[1] + XvertStep[v];
        template4TupleSet[i+2] = txyz[2] + YvertStep[v];
        template4TupleSet[i+3] = txyz[3] + ZvertStep[v];

        Tpoints[v] = T->val( &(template4TupleSet[i]) );
        Kpoints[v] = kt0->val( &(template4TupleSet[i+1]) );
    }

    const double RhoCpBlood = 1060*4100; // (1060 kg/m^3 * 4100 J/(kg*C)) --> [J/m^3*C]
    long t1xyz[4];
    long * xyz = &(txyz[1]);
    MESH_T dx,dy,dz,dt, dxdx, dydy, dzdz;
    MESH_T t0_xiyizi;
    MESH_T rho_Cp0, laplacainT, gradKdotgradT, ts_dot;
	//cout << "txyz = " << txyz[0] << "," << txyz[1] << "," << txyz[2] << "," << txyz[3] << endl;
    
    dt = ds[0]; dx = ds[1]; dy = ds[2]; dz = ds[3];
    dxdx = dx*dx;
    dydy = dy*dy;
    dzdz = dz*dz;

    for (i=0;i<4;i++) t1xyz[i] = txyz[i];

    t1xyz[0]++;

    rho_Cp0 = rCp0->val(xyz);
    t0_xiyizi = T->val(txyz);

    if ( Tdot_source != NULL ) ts_dot = Tdot_source->val(txyz);
    else ts_dot = 0.0;


    laplacainT = 
        ( Tpoints[0] + Tpoints[1] - 2*t0_xiyizi ) / dxdx +
        ( Tpoints[2] + Tpoints[3] - 2*t0_xiyizi ) / dydy +
        ( Tpoints[4] + Tpoints[5] - 2*t0_xiyizi ) / dzdz;

    gradKdotgradT =
        ( (Kpoints[1]-Kpoints[0]) * (Tpoints[1]-Tpoints[0]) )/(2*dx) +
        ( (Kpoints[3]-Kpoints[2]) * (Tpoints[3]-Tpoints[2]) )/(2*dy) +
        ( (Kpoints[5]-Kpoints[4]) * (Tpoints[5]-Tpoints[4]) )/(2*dz);

    //Blood flow rate is mass/(volume*time).  'perfcoef' is a fraction from 0 to 1
    T->val(t1xyz) = dt*ts_dot + t0_xiyizi + (kt0->val(xyz)*laplacainT  + gradKdotgradT - (perfusionrate)*(RhoCpBlood)*(t0_xiyizi - Tblood) ) * dt / rho_Cp0 ;
    
    //cout << "tsdot = " << ts_dot << endl;
    //cout << dt*ts_dot << " + " << t0_xiyizi << " + (" << kt0->val(xyz)*laplacainT << " + " << gradKdotgradT << " - " << (perfusionrate)*(RhoCpBlood)*(t0_xiyizi - Tblood) << ")*("<<dt/rho_Cp0<<") = "<< T->val(t1xyz) <<endl;
};




template<typename MESH_T>
void Pennes_Perfused_SolveCube(bool useFreeOutFlowBoundaryConditions, MESH_T * meshResolution, 
                     MeshFunction4D<MESH_T> * T, MeshFunction4D<MESH_T> * Tdot_source, 
                     MeshFunction3D<MESH_T> * kt0, MeshFunction3D<MESH_T> * rho_Cp, 
                     MESH_T Tblood, MESH_T perfusionrate, long ta_i=0, long tb_i=-1  )
{
    long dims[4];
    long txyz[4];
    long t1;
    long interval=1;
    long t,i,j,k;
    long nt,nx,ny,nz;    

    T->getdims(dims);
    nt = dims[0]; nx = dims[1]; ny = dims[2]; nz = dims[3];

    if (interval==0) interval=1;

    if (tb_i < 0)
    {
        tb_i = nt-1;
    } else {
        if (tb_i > (nt-1))
            tb_i = nt-1;

        nt = tb_i - ta_i;
    }

    for (t=ta_i;t<tb_i;t++){
        //if (t % interval == 0)
        //    cout << "ti = " << t << endl;

        txyz[0] = t;

        for (i=1;i<nx-1;i++)
        {
            txyz[1] = i;
            for (j=1;j<ny-1;j++)
            {
                txyz[2] = j;
                for (k=1;k<nz-1;k++)
                {
                    txyz[3] = k;
                    //Pennes_2ndOrder(t,i,j,k, meshResolution, &T, tsdotptr, &Kt, &rCp);
                    Pennes_Perfused(txyz, meshResolution, T, Tdot_source, kt0, rho_Cp, Tblood, perfusionrate );
                }
            }
        }

        
        if (useFreeOutFlowBoundaryConditions) {
        //  These are free-flow boundary conditions.  The directional gradient
        //  of temperature orthogonal to each boundary surface is set to zero.  This means
        //  "temperature can freely flow" out of the volume. This essentially models the case when
        //  there is no change in thermal medium beyond the simulation boundaries, no external heat sources,
        //  and heat would dissipate to zero at infinity. 

            t1 = t+1;

            for (i=0;i<nx;i++)
            {
                //X-Z boundaries
                for (k=0;k<nz;k++)
                {
                    T->val(t1,i,0,k) = T->val(t1,i,1,k);
                    T->val(t1,i,ny-1,k) = T->val(t1,i,ny-2,k);
                }
                //X-Y boundaries
                for (j=0;j<ny;j++)
                {
                    T->val(t1,i,j,0) = T->val(t1,i,j,1);
                    T->val(t1,i,j,nz-1) = T->val(t1,i,j,nz-2);
                }
            }
        
            //Y-Z boundaries
            for (j=0;j<ny;j++)
            {

                for (k=0;k<nz;k++)
                {
                    T->val(t1,0,j,k) = T->val(t1,1,j,k);
                    T->val(t1,nx-1,j,k) = T->val(t1,nx-2,j,k);
                }
            }

        }
        else {

            //  These are fixed-temperature boundary conditions, as though the cube volume
            //  boundaries were held at a constant temperature (whatever T(0) was along each)

            for (i=0;i<nx;i++)
            {
                //X-Z boundaries
                for (k=0;k<nz;k++)
                {
                    T->val(t+1,i,0,k) = T->val(t,i,0,k);
                    T->val(t+1,i,ny-1,k) = T->val(t,i,ny-1,k);
                }
                //X-Y boundaries
                for (j=0;j<ny;j++)
                {
                    T->val(t+1,i,j,0) = T->val(t,i,j,0);
                    T->val(t+1,i,j,nz-1) = T->val(t,i,j,nz-1);
                }
            }
        
            //Y-Z boundaries
            for (j=0;j<ny;j++)
            {
                for (k=0;k<nz;k++)
                {
                    T->val(t+1,0,j,k) = T->val(t,0,j,k);
                    T->val(t+1,nx-1,j,k) = T->val(t,nx-1,j,k);
                }
            }


        }
        


    }

};


template<typename MESH_T>
void Pennes_Perfused_SolveCube_interface(int useFreeflow, MESH_T dt, MESH_T dx, MESH_T dy, MESH_T dz, 
                     MeshFunction4D<MESH_T> * T, MeshFunction4D<MESH_T> * Tdot_source, 
                     MeshFunction3D<MESH_T> * kt0, MeshFunction3D<MESH_T> * rho_Cp, 
                     MESH_T Tblood, MESH_T perfusionrate, long ta_i=0, long tb_i=-1  )
{
    MESH_T resolution[] = {dt,dx,dy,dz};
    
    bool flag = (bool)useFreeflow;

    //cout << "Pennes_Perfused_SolveCube_interface()" << endl;
    Pennes_Perfused_SolveCube(flag>0, resolution, 
                     T, Tdot_source, 
                     kt0, rho_Cp, 
                     Tblood, perfusionrate, ta_i, tb_i  );
}


#endif