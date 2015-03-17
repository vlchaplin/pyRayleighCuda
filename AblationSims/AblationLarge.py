#!/usr/bin/env python3

import numpy as np;
import matplotlib.image as image
import matplotlib.pyplot as plt
import pylab
from math import *;
import h5py

import sys;

# add path to the C++ extension library (PBHEswig)
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\code\\BioHeatCpp\\PBHEswig\\x64');
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\code\\myPy')
import PBHEswig;
import sonalleve;
import geom;


# ------ Sim globals --------- #
Nx = 80
Ny = 80
Nz = 40
Nt = 6

xrp = 1e-2*np.linspace(-3,3,Nx)
yrp = 1e-2*np.linspace(-3,3,Ny)
zrp = 1e-2*np.linspace(7,18,Nz)

#for stability, dt ~ 0.1 sec and dx ~ 1mm (CFL criteria for drift-diffusion), Nt < ~20

dx = xrp[1]-xrp[0]
dy = yrp[1]-yrp[0]
dz = zrp[1]-zrp[0]

dt = 0.1
#voxSide = 1e-3
res = np.array([dt,dx,dy,dz])
voxVol=dx*dy*dz
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


zplane=0.14
focplaneZpix=np.where(np.logical_and( (zrp[1:-1]-zplane>0) , (zrp[0:-2]-zplane<0) ))[0][0]

roiVolumeXPix = np.where(np.logical_and( (xrp>=-0.01) , (xrp<=0.01) ))[0]
roiVolumeYPix = np.where(np.logical_and( (yrp>=-0.01) , (yrp<=0.01) ))[0]
roiVolumeZPix = np.where(np.logical_and( (zrp>=zplane-0.01) , (zrp<=zplane+0.01) ))[0]

roiMask = np.zeros([Nx,Ny,Nz], dtype=np.bool)
roiMask[ np.meshgrid(roiVolumeXPix, roiVolumeYPix, roiVolumeZPix) ] = True


numVox = Nx*Ny*Nz
roiNumVox = np.sum(roiMask)
roiVolume = roiNumVox*voxVol

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

imageBounds = [ xrp[0]*100, xrp[-1]*100, yrp[0]*100, yrp[-1]*100 ]
vertImageBounds = [ xrp[0]*100, xrp[-1]*100, zrp[0]*100, zrp[-1]*100 ]

#Whether or not to use a control cell
doControl=True

### 
# free parameter: Active dwell time  <--------------------
activeDwellTime_sec = 30

### 
# free parameter: Power  <--------------------
# Spatial peak, temporal average intensity of desired focus in W/m^2
# Multiply by 1e-4 to get W/cm^2 (ie it's smaller than W/m^2)
Ispta = 1.7e7

## triangle template
### 
# free parameter: spacing ('d')  <--------------------
d=0.002;
h=d*sin(pi/3);

triangle = np.array([[-d/2, -h/2, 0.0], [d/2, -h/2, 0.0], [0, h/2, 0] ])
pxyz=triangle
pxyz[:,2]=0.14
p0 = 1e7*np.ones(len(pxyz));


uxyz = sonalleve.get_sonalleve_xdc_vecs()
uamp = sonalleve.get_focused_element_vals(k0, uxyz, pxyz, p0 )

#starting position

xstart = -0.01+d/2
ystart = -0.01+h/2

x0 = np.array([xstart, ystart, 0 ])
uxyz = geom.translate3vecs(uxyz, x0 )

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
    
numAcqPoints = round(activeDwellTime_sec/tempCheckInterval_sec)
activeDwellTime_sec = numAcqPoints*tempCheckInterval_sec

#retain CEM map for each acquisition in this sonication
CEMthis = np.zeros([Nx,Ny,Nz])

aqcidx = 0;
time = 0
step = tempCheckInterval_sec

tacqstops = step*np.array(range(1,numAcqPoints+1))
Rbase = 4*np.ones([nnt,Nx,Ny,Nz]);

#plt.ion()
#fig=plt.figure(1)

#plt.imshow( T[0,:,:,floor(Nz/2)] )
#plt.show()

first=True
Ni= round( 0.02 / (1.5*d))
Nj= round( 0.02 / (2.0*h))

#Ni=2
#Nj=1

# proportionality of acoustic absorption
alpha_acc = 0.5

numTimes = numAcqPoints*Ni*Nj
timeList = np.zeros(numTimes)
#cemVolume = np.zeros(numTimes)
cemROIavg = np.zeros(numTimes)
cemNonROIavg = np.zeros(numTimes)

cem240VolROI = np.zeros(numTimes)
cem240VolNonROI = np.zeros(numTimes)

sonicationCoords = np.zeros([Ni,Nj,4])
sonicationDwellTimes = np.zeros([Ni,Nj])

t=0
for i in range(0,Ni):
    
    x0i = i*(3.0/2.0)*d
    
    gridx = np.where(np.abs(x0[0] + x0i - xrp ) <= d*0.5)[0]

    for j in range(0,Nj):
    
        print('%d / %d , %d / %d' % (i, Ni, j, Nj) )
       # y0j = ((i+1)%2)*h + (j)*3*h
        y0j = (i%2)*h + (j)*2.0*h
        
        gridy = np.where(np.abs(x0[1] + y0j - yrp) <= d*0.5)[0]
        
        xdc_position = x0 + [x0i, y0j, 0]
        
        P = sonalleve.calc_pressure_field(k0, geom.translate3vecs(uxyz, np.array([x0i, y0j, 0 ]) ), uamp, xrp, yrp, zrp)
        I = np.abs(P)**2 / (2.0*rho*c0)
        I *= (Ispta/np.max(I))

        Tdot[:] = 2.0*(alpha_acc)*I / (rho*c0)
        
        del [P,I]
        
        controlCellij =  np.meshgrid(gridx, gridy, roiVolumeZPix)

        ncontrolVoxels = controlCellij[0].size
        
        print('# control cell voxels = ', ncontrolVoxels)

        aqcidx=0
        tstart=time
        while aqcidx<numAcqPoints :
            
            PBHEswig.pbheSolve(0,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, 37.0, perfRate,0,nnt-1 )
            Rbase[:]=4
            Rbase[np.where(T[0:,nnt] > 43.0, True, False)] = 2
            
            #time integrate to get the thermal dose
            CEMthis[:] += dt*np.sum( Rbase**(T[0:nnt]-43), 0  )
            
            nnec = np.sum( np.where( CEMthis[controlCellij] >= 240.0, 1, 0 ) )
            
            print("At acqidx ",aqcidx, ", # voxels>=240 = ", nnec)
            
            aqcidx+=1
            time+=step
            T[0] = T[nnt-1]
            
            cem240VolROI[t] = 1e+6*voxVol*np.sum( np.where( CEMthis[roiMask] >= 240.0, 1, 0 ) )
            cem240VolNonROI[t] = 1e6*voxVol*np.sum( np.where( CEMthis[~roiMask] >= 240.0, 1, 0 ) )
            
            #cemVolume[t] = 1e6*voxArea*np.sum( np.where( CEMthis >= 240.0, 1, 0 ) )
            cemROIavg[t] = np.sum(CEMthis[roiMask])/roiNumVox
            cemNonROIavg[t] = np.sum(CEMthis[~roiMask])/(numVox - roiNumVox)
            timeList[t]=time
            t+=1
            
            if doControl and nnec >= 0.5*ncontrolVoxels:
                print('Terminated at ', time-tstart)
                aqcidx=numAcqPoints
            
            #plt.imshow( np.transpose( T[nnt-1,:,:,floor(Nz/2)] ), cmap=image.cm.hot, extent=imageBounds, origin='lower' )
            #if first:
            #    plt.colorbar()
            #    first=False
            #plt.draw()
            ##tmmm.sleep(0.1)
            #plt.pause(0.0001)
            
        sonicationCoords[i,j,0] = tstart
        sonicationCoords[i,j,1:4] = xdc_position
        sonicationDwellTimes[i,j] = time-tstart
            


#ti=4
#fig=plt.figure()
#plt.imshow( T[nnt-1,:,:,floor(Nz/2)] )
##plt.imshow( CEMthis[:,:,floor(Nz/2)] )
#plt.colorbar()
#plt.ion()
#plt.show()





mmint = floor(d*1000)
mmrem = d*1000 - mmint
if mmrem >= 0.1:
    dstring = '%d.%dmm' % (mmint, mmrem*10)
else:
    dstring = '%dmm' % mmint


filename = 'cem_%s_%dms_I=%d' % (dstring, activeDwellTime_sec*1000, Ispta*1e-4)

if doControl:
    filename+='_RT'

h5name = "C:\\Users\\vchaplin\\Documents\\HiFU\code\\AblationSims\\simdata\\"+filename+".hdf5"
figName = "C:\\Users\\vchaplin\\Documents\\HiFU\code\\AblationSims\\simdata\\plots\\"+filename+".png"

print("Writing ", h5name)
f = h5py.File(h5name, "w")
dset = f.create_dataset("CEM", data=CEMthis)

f.flush()
dset3 = f.create_dataset("Tfinal", data=T[0])
f.flush()

dset.attrs['Ispta_W_m2'] = Ispta
dset.attrs['dwelltime_sec'] = activeDwellTime_sec
dset.attrs['d_m'] = d
dset.attrs['Ntxyz'] = np.array([Nt, Nx, Ny, Nz])
dset.attrs['restxyz'] = res
dset.attrs['alpha'] = alpha_acc
dset.attrs['times'] = timeList[0:t]
dset.attrs['ROIAvgCEM'] = cemROIavg[0:t]
dset.attrs['NonROIAvgCEM'] = cemNonROIavg[0:t]

dset.attrs['cem240VolROI'] = cem240VolROI[0:t]
dset.attrs['cem240VolNonROI'] = cem240VolNonROI[0:t]
dset.attrs['roiVolume'] = roiVolume
dset.attrs['focplaneZpix'] = focplaneZpix
dset.attrs['xp']=xrp
dset.attrs['zp']=zrp
dset.attrs['yp']=yrp

f.flush()

dset2 = f.create_dataset("positions", data=sonicationCoords)
dset2.attrs['dwellTimes'] = sonicationDwellTimes
dset2.attrs['focalTemplate'] = pxyz


f.flush()
f.close()

plt.ioff()
fig2=plt.figure(2, figsize=(10,7), dpi=72)
plt.subplot(221)
#plt.imshow( T[nnt-1,:,:,floor(Nz/2)] )
plt.imshow( np.transpose(CEMthis[:,:,focplaneZpix]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=imageBounds, origin='lower' )

plt.plot( [-1,-1,1,1,-1], [-1,1,1,-1,-1], 'b--')



plt.subplot(222)
#plt.imshow( np.transpose(CEMthis[:,:,focplaneZpix-3]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=imageBounds, origin='lower' )
plt.plot(timeList[0:t], cemROIavg[0:t],'r')
plt.plot(timeList[0:t], cemNonROIavg[0:t],'k')
plt.xlabel('Time [s]')
plt.ylabel('Volume-avg CEM')

plt.subplot(223)
plt.imshow( np.transpose(CEMthis[:,floor(Ny/2),:]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=vertImageBounds, origin='lower' )
plt.colorbar(orientation='horizontal')

plt.subplot(224)
plt.plot(timeList[0:t], cem240VolROI[0:t],'r')
plt.plot(timeList[0:t], cem240VolNonROI[0:t],'k')
plt.plot(timeList[[1,-1]], [roiVolume*1e6, roiVolume*1e6], 'b--')
plt.xlabel('Time [s]')
plt.ylabel('Volume at CEM >=240 [mL]')

#plt.show()

print("Writing ", figName)
plt.savefig(figName)
plt.close()

del tacqstops, Rbase, cemROIavg, cemNonROIavg, cem240VolROI, cem240VolNonROI, timeList




    

    

