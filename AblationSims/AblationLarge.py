#!/usr/bin/env python3

import numpy as np;
import matplotlib.image as image
import matplotlib.pyplot as plt
import pylab
from math import *;
import h5py

import sys;

# add path to the C++ extension library (PBHEswig)
sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\code\\BioHeatCpp\\PBHEswig\\x64');
sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\code\\myPy')
import PBHEswig;
import sonalleve;
import geom;


# ------ Sim globals --------- #
Nx = 80
Ny = 80
Nz = 30
Nt = 10

xrp = 1e-2*np.linspace(-2,2,Nx)
yrp = 1e-2*np.linspace(-2,2,Ny)
zrp = 1e-2*np.linspace(10,18,Nz)

#for stability, dt ~ 0.1 sec and dx ~ 1mm (CFL criteria for drift-diffusion), Nt < ~20

dx = xrp[1]-xrp[0]
dy = yrp[1]-yrp[0]
dz = zrp[1]-zrp[0]

dt = 0.1
#voxSide = 1e-3
res = np.array([dt,dx,dy,dz])

#dx = dy = dz = voxSide




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
rho=3700
T[:] = 37.0
Tdot[:] = 5;
kdiff[:] = 0.5;
rhoCp[:] = rho*1000;

perfRate = 0.01;

f0 = 1.2e6
c0 = 1540
k0 = 2.0*pi*(f0/c0)


focplaneZpix=np.where(np.logical_and( (zrp[1:-1]-0.14>0) , (zrp[0:-2]-0.14<0) ))[0][0]

voxArea=dx*dy*dz

uxyz = sonalleve.get_sonalleve_xdc_vecs()


# total number of sonications
Nson = 1

## triangle template
d=0.002;
h=d*sin(pi/3);

triangle = np.array([[-d/2, -h/2, 0.0], [d/2, -h/2, 0.0], [0, h/2, 0] ])
pxyz=triangle
pxyz[:,2]=0.14
p0 = 1e7*np.ones(len(pxyz));

uamp = sonalleve.get_focused_element_vals(k0, uxyz, pxyz, p0 )

# feed-back control time (must be >= dt for obvious reasons, and <= Nt*dt b.c. that's convenient programming for now)
tempCheckInterval_sec = 0.5


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
activeDwellTime_sec = 10

numAcqPoints = round(activeDwellTime_sec/tempCheckInterval_sec)
activeDwellTime_sec = numAcqPoints*tempCheckInterval_sec

#retain CEM map for each acquisition in this sonication
CEMthis = np.zeros([Nx,Ny,Nz])

aqcidx = 0;
time = 0
step = tempCheckInterval_sec

tacqstops = step*np.array(range(1,numAcqPoints+1))

uxyz = geom.translate3vecs(uxyz, np.array([-0.01, -0.01, 0 ]) )

#plt.ion()
#fig=plt.figure(1)

#plt.imshow( T[0,:,:,floor(Nz/2)] )
#plt.show()

imageBounds = [ xrp[0]*100, xrp[-1]*100, yrp[0]*100, yrp[-1]*100 ]
vertImageBounds = [ xrp[0]*100, xrp[-1]*100, zrp[0]*100, zrp[-1]*100 ]

Rbase = 4*np.ones([nnt,Nx,Ny,Nz]);

first=True
Ni=8
Nj=6

numTimes = numAcqPoints*Ni*Nj
timeList = np.zeros(numTimes)
cemVolume = np.zeros(numTimes)
t=0
for i in range(0,Ni):
    
    x0i = i*(3.0/2.0)*d
    
    for j in range(0,Nj):
    
        print(i ,j)
       # y0j = ((i+1)%2)*h + (j)*3*h
        y0j = (i%2)*h + (j)*2.0*h
        P = sonalleve.calc_pressure_field(k0, geom.translate3vecs(uxyz, np.array([x0i, y0j, 0 ]) ), uamp, xrp, yrp, zrp)
        I = np.abs(P)**2 / (2.0*rho*c0)
        I *= (1e7/np.max(I))

        Tdot[:] = 2.0*(0.5)*I / (rho*c0)
        
        del [P,I]

        aqcidx=0
        while aqcidx<numAcqPoints :
            print("Doing acqidx ",aqcidx)
            PBHEswig.pbheSolve(0,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, 37.0, perfRate,0,nnt-1 )
            Rbase[:]=4
            Rbase[np.where(T[0:,nnt] > 43.0, True, False)] = 2
            
            #time integrate to get the thermal dose
            CEMthis[:] += dt*np.sum( Rbase**(T[0:nnt]-43), 0  )
            
            
            aqcidx+=1
            time+=step
            T[0] = T[nnt-1]
            
            cemVolume[t] = 1e6*voxArea*np.sum( np.where( CEMthis >= 240.0, 1, 0 ) )
            timeList[t]=time
            t+=1
            
            #plt.imshow( np.transpose( T[nnt-1,:,:,floor(Nz/2)] ), cmap=image.cm.hot, extent=imageBounds, origin='lower' )
            #if first:
            #    plt.colorbar()
            #    first=False
            #plt.draw()
            ##tmmm.sleep(0.1)
            #plt.pause(0.0001)
            


#ti=4
#fig=plt.figure()
#plt.imshow( T[nnt-1,:,:,floor(Nz/2)] )
##plt.imshow( CEMthis[:,:,floor(Nz/2)] )
#plt.colorbar()
#plt.ion()
#plt.show()

filename = 'cem_%f_%f_I=100' % (d, activeDwellTime_sec) 
f = h5py.File("C:\\Users\\vchaplin\\Documents\\HiFU\code\\AblationSims\\simdata\\"+filename+".hdf5", "w")
dset = f.create_dataset("CEM", data=CEMthis)
dset.attrs['dwelltime'] = activeDwellTime_sec
dset.attrs['d'] = d

f.flush()
f.close()

plt.ioff()
fig2=plt.figure(2, figsize=(10,6), dpi=72)
plt.subplot(221)
#plt.imshow( T[nnt-1,:,:,floor(Nz/2)] )
plt.imshow( np.transpose(CEMthis[:,:,focplaneZpix]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=imageBounds, origin='lower' )

plt.subplot(222)
plt.imshow( np.transpose(CEMthis[:,:,focplaneZpix-3]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=imageBounds, origin='lower' )

plt.subplot(223)
plt.imshow( np.transpose(CEMthis[:,floor(Ny/2),:]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=vertImageBounds, origin='lower' )
plt.colorbar()

plt.subplot(224)
plt.plot(timeList, cemVolume,'k')

#plt.show()

plt.savefig(filename+'.png')
plt.close()




    

    

