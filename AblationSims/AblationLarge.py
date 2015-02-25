#!/usr/bin/env python3

import numpy as np;

import matplotlib.pyplot as plt
from math import *;

import sys;

# add path to the C++ extension library (PBHEswig)
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\code\\BioHeatCpp\\PBHEswig\\x64');

import PBHEswig;


# ------ Sim globals --------- #
Nx = 50
Ny = 50
Nz = 50
Nt = 20

#for stability, dt ~ 0.1 sec and dx ~ 1mm (CFL criteria for drift-diffusion), Nt < ~20
dt = 0.1
voxSide = 1e-3
res = np.array([dt,voxSide,voxSide,voxSide])

dx = dy = dz = voxSide


# ----- allocate numpy data arrays --- #
T = np.zeros([Nt,Nx,Ny,Nz])
Tdot = np.zeros([Nx,Ny,Nz])
kdiff = np.zeros([Nx,Ny,Nz])
rhoCp = np.zeros([Nx,Ny,Nz])

# ---- Create C++ mesh objects ---
Tmesh = PBHEswig.mesh4d()
Tdotmesh = PBHEswig.mesh34d();
kmesh = PBHEswig.mesh3d();
rhoCpmesh = PBHEswig.mesh3d();

# ----- tie data arrays to mesh objects (to pass to C++) ---
# the data in each mesh can now be accessed/manipulated from python via the arrays, 'T', 'Tdot', etc.
PBHEswig.ShareMemoryMesh4(T, res, Tmesh)
PBHEswig.ShareMemoryMesh34(Tdot, res, Tdotmesh)
PBHEswig.ShareMemoryMesh3(kdiff, res[1:4], kmesh)
PBHEswig.ShareMemoryMesh3(rhoCp, res[1:4], rhoCpmesh)


#initial conditions
T[:] = 37.0
Tdot[:] = 1;
kdiff[:] = 0.5;
rhoCp[:] = 3700*1000;

perfRate = 0.01;

sx=Nx/10
for xi in range(0,Nx):
    for yi in range(0,Ny):
        for zi in range(0,Nz):
            Tdot[xi,yi,zi] = 1.0*np.exp( -(xi+0.5 - Nx/2)**2/(2*(sx)**2) )*np.exp( -(yi+0.5 - Ny/2)**2/(2*(sx)**2) )*np.exp( -(zi+0.5 - Nz/2)**2/(2*(sx)**2) ) 
            

# total number of sonications
Nson = 1


# feed-back control time (must be >= dt for obvious reasons, and <= Nt*dt b.c. that's convenient programming for now)
tempCheckInterval_sec = 1.0



#first make sure times are all digitized based on finite simulation rate
if Nt*dt > tempCheckInterval_sec:
    nnt = round(tempCheckInterval_sec/dt);
    tempCheckInterval_sec = nnt*dt;
elif tempCheckInterval_sec > Nt*dt:
    nnt = Nt
    tempCheckInterval_sec = nnt*dt
else:
    nnt=Nt
    
# free parameter: Active dwell time
activeDwellTime_sec = 25.0

numAcqPoints = round(activeDwellTime_sec/tempCheckInterval_sec)
activeDwellTime_sec = numAcqPoints*tempCheckInterval_sec

#retain CEM map for each acquisition in this sonication
CEMthis = np.zeros([numAcqPoints,Nx,Ny,Nz])

aqcidx = 0;
time = 0
step = tempCheckInterval_sec

tacqstops = step*np.array(range(1,numAcqPoints+1))

while aqcidx<numAcqPoints :
    print("Doing acqidx ",aqcidx)
    PBHEswig.pbheSolve(0,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, 37.0, perfRate,0,nnt-1 )
    Rbase = 4*np.ones([nnt,Nx,Ny,Nz]);
    Rbase[np.where(T[0:,nnt] > 43.0, True, False)] = 2
    
    #time integrate to get the thermal dose
    CEMthis[aqcidx] = dt*np.sum( Rbase**(T[0:nnt]-43), 0  )
    aqcidx+=1
    time+=step
    T[0] = T[nnt-1]





ti=12;
plt.imshow( CEMthis[ti,:,:,floor(Nz/2)] )
plt.colorbar()




    

    

