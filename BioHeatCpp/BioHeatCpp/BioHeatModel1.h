#ifndef BIOHEATMODEL1_H
#define BIOHEATMODEL1_H

#include <iostream>
#include "MeshFunction4D.h"

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

    (*T)(ti+1,xi,yi,zi) = dt*ts_dot + t0_xiyizi + (kt0->val(xi,yi,zi)*laplacainT  + gradKdotgradT  ) * dt / rho_Cp0;
    

};

#endif