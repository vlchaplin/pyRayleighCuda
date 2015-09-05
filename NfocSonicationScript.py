#!/usr/bin/env python

import h5py
import sys
import re
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import collections
from matplotlib import image
 
import matplotlib.animation as animation;
    
from math import *;

sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\myPy')  
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\AblationSims')
sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\BioHeatCpp\\PBHEswig\\x64')
import ablation_utils
import geom
import sonalleve
import transducers
import PBHEswig
from countlines import countlines

import imagemanip as imp;

import argparse
     
#################################
### SIMULATION PARAMETERS ###
#################################

uxyz = sonalleve.get_sonalleve_xdc_vecs()

f0 = 1.2e6
c0 = 1540
k0 = 2.0*pi*(f0/c0)

## Focal zone center trajectory ##
maxR_mm = 20 #mm
turnspace_mm=4  #mm
minR_mm = turnspace_mm / 2.0  #mm
z_mm = 140;  #z plane mm
avgSpeed_mm_per_sec=0.6
focalpoint_dwell_seconds=6  # time for each sonication
wait=2  # wait time between sonications

npass0=4
npass1=4

## Focal pattern ##
M=3
d=0.0035 #ring diameter
ring,radius = geom.ring(d,M,z=0.14)
spacing = 2*(radius**2)*(1 - cos(2*pi/M))
h=radius
pxyz=ring;

## Peak intensity ##
Ispta0 = 1.25e7;

## Medium ## 
rho=1000
Cp =3700
ktdiffusion=0.6
perfRate = 0.00;
alpha_acc = 1.0; #Np/m (5.75 Np/m = 0.5 dB/cm)

## free-flow BC.  0 = fixed temperature boundary
flowBCs=1

## Grid ##
Nx=70
Ny=70
Nz=70

xw=6.0;
yw=6.0;
zw=6.0;
Z0=11.0;

parser = argparse.ArgumentParser()
parser.add_argument("-o", help="Output h5 file", type=str)
parser.add_argument("-maxR", help="Max trajectory radius (mm)", type=float)
parser.add_argument("-minR", help="Min trajectory radius (mm)", type=float)
parser.add_argument("-DR", help="Turn spacing (mm)", type=float)
parser.add_argument("-nfoc", help="# focal points (1 for single focus)", type=int)
parser.add_argument("-I", help="Peak intensity (Ispta) of the acoustic field in W/cm^2. Default = 1000 W/cm^2", type=float)
parser.add_argument("-d", help="Diameter of focal ring (mm)", type=float)
parser.add_argument("-a", help="Dwell seconds (aka heating time per position), default = %f" % focalpoint_dwell_seconds, type=float)
parser.add_argument("-w", help="Wait time", type=float)
parser.add_argument("-speed", help="Average speed (mm per sec), default = %f" % avgSpeed_mm_per_sec, type=float)
parser.add_argument("-alpha", help="Attenuation coefficient (Np/m), default=1.0", type=float)
parser.add_argument("-perf", help="Perfusion rate (1/s), default=0", type=float)
parser.add_argument("-fix", help="Turn on fixed temperature boundary conditions", action='store_true')
parser.add_argument("-XR", help="Width of the simulation in X in cm, default = 6 cm", type=float)
parser.add_argument("-YR", help="Width of the simulation in Y in cm, default = 6 cm", type=float)
parser.add_argument("-ZR", help="Width of the simulation in Z in cm, default = 6 cm", type=float)
parser.add_argument("-Z0", help="Minimum z-slice locaiton in cm, default z=11", type=float)
parser.add_argument("-Nx", help="# X grid", type=int)
parser.add_argument("-Ny", help="# Y grid", type=int)
parser.add_argument("-Nz", help="# Z grid", type=int)

args = parser.parse_args()
if args.o:
    h5name=args.o
if args.maxR:
    maxR_mm = args.maxR
if args.minR:
    minR_mm = args.minR
if args.DR:
    turnspace_mm = args.DR
if args.nfoc:
    M = args.nfoc
if args.I:
    Ispta0 = args.I*1e4
if args.d :
    d = 1e-3*args.d
if args.a :
    focalpoint_dwell_seconds = args.a
if args.w :
    wait = args.w
if args.alpha :
    alpha_acc = args.alpha
if args.perf :
    perfRate = args.perf
if args.fix :
    flowBCs=0
if args.XR :
    xw = args.XR
if args.YR :
    yw = args.YR
if args.ZR :
    zw = args.Zr
if args.Z0 :
    Z0 = args.Z0
if args.Nx :
    Nx = args.Nx
if args.Nx :
    Ny = args.Ny
if args.Nz :
    Nz = args.Nz
if args.speed :
    avgSpeed_mm_per_sec = args.speed

xedges = 1e-2*np.linspace(-xw/2.0, xw/2.0,Nx+1)
yedges = 1e-2*np.linspace(-yw/2.0, yw/2.0,Ny+1)
zedges = 1e-2*np.linspace(Z0, Z0+zw,Nz+1)

xrp = xedges[0:Nx]
yrp = yedges[0:Ny]
zrp = zedges[0:Nz]

gxp,gyp,gzp = np.meshgrid(xrp, yrp, zrp, sparse=False, indexing='ij')
calcGridDist= lambda rr: np.sqrt((gxp-rr[0])**2 + (gyp-rr[1])**2 + (gzp-rr[2])**2)

dx = xrp[1]-xrp[0]
dy = yrp[1]-yrp[0]
dz = zrp[1]-zrp[0]
dt = 0.1

res = np.array([dt,dx,dy,dz])
voxVol=dx*dy*dz

zplane=0.14
focplaneZpix=np.where(np.logical_and( (zrp[1:-1]-zplane>=0) , (zrp[0:-2]-zplane<0) ))[0][0]

## ROI ##
roiOnTarget = np.logical_and( np.sqrt(gxp**2 + gyp**2) <= (1e-3*maxR_mm), np.abs(gzp-0.14) <= 0.005 )
roiOffTarget = np.logical_and( np.sqrt(gxp**2 + gyp**2) <= 0.025, np.abs(gzp-0.14) <= 0.015 )
roiOffTarget = np.logical_and(roiOffTarget, np.logical_not(roiOnTarget) )


def isarray(a):
    try:
        shp = a.shape
        return True
    except:
        return False

def sonication_heating(T, CEM, duration, T0=None, CEMinit=None, Tmax=None, Freeflow=0):
    
    if T0 is not None:
        if isarray(T0):
            T=T0
        else:
            T[:] = T0
    if CEMinit is not None:
        if isarray(CEMinit):
            CEM=CEMinit
        else:
            CEM[:]=CEMinit
    if Tmax is None:
        Tmax = np.zeros_like(CEM)
    
    
    time=0
    ti=0
    buffsize=T.shape[0]
    tstep=dt*buffsize
    while time<duration :

        print( '%d%%' % (time/duration *100.0), end='\r')
        
        if (time + tstep > duration):
            buffsize = ceil((duration-time)/dt)
            tstep = dt*buffsize
            

        PBHEswig.pbheSolve(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, 37.0, perfRate,0,buffsize-1 )
        Rbase[:]=4
        Rbase[np.where(T[0] > 43.0, True, False)] = 2
        
        #update = np.where(T[buffsize-1] > Tmax, True, False)
        #Tmax[update] = T[buffsize-1][update]

        #time integrate to get the thermal dose
        CEM[:] += (dt/60.0)*np.sum( Rbase**(T[0:buffsize]-43), 0  )
        
        ti+=1
        time+=tstep
        T[0] = T[buffsize-1]
        
       
    update = np.where(T[buffsize-1] > Tmax, True, False)
    Tmax[update] = T[buffsize-1][update]
        
    return (Tmax, time)

def sonication_heating_physical_move_nofeedback(xdcDwells, xdcWaits, xdcPoints, uamp, CEM, CEMvst, TempVsTime,
                                                TempOnvsTime, TempOffvsTime,
                                                Tmax=None, frad=0.003, timeZero=0.0, Freeflow=0, onroi=None, offroi=None):
    
    if Tmax is None:
        Tmax = np.zeros_like(CEM)
    
    CEMvst[:]=0

    ti=0
    
    numSonicationPoints = len(xdcDwells)
    
    totalCooling=0
    
    #pre-calc HIFU-induced source term (not actual dT/dt, just what is due to HIFU)
    Pr = sonalleve.calc_pressure_field(k0, uxyz, uamp, xrp, yrp, zrp)
    Iavg = np.abs(Pr)**2 / (2.0*rho*c0)
    Tdot[:] = 2.0*(alpha_acc)*Iavg / (rhoCp)
    
    elapsedTime = timeZero
    sonicationEndTimes = np.zeros(numSonicationPoints);
    
    if onroi is None:
        onroi= (calcGridDist( [0,0,0.14] ) < 0.005)
    
        
    ti=0
    while ti < numSonicationPoints :
        
        print('%d / %d' % (ti+1, numSonicationPoints), end =' ')
        
        dwell = xdcDwells[ti];
        Tdot[:] = 2.0*(alpha_acc)* imp.shiftImageRegular3D(Iavg,xedges,yedges,zedges, -xdcPoints[ti]) / (rhoCp)
        Tmax, duration = sonication_heating(T, CEM, dwell, Tmax=Tmax, Freeflow=Freeflow )
        
        elapsedTime += duration
        
        wait = xdcWaits[ti];
        Tdot[:] = 0
        Tmax, duration = sonication_heating(T, CEM, wait, Tmax=Tmax, Freeflow=Freeflow )
        
        elapsedTime += duration
        sonicationEndTimes[ti] = elapsedTime
        CEMvst[ti] = CEM
        TempVsTime[ti] = T[0]
        TempOnvsTime[ti] = np.mean(T[0][onroi])
        if offroi is None:
            TempOffvsTime[ti] = np.mean(T[0])
        else:
            TempOffvsTime[ti] = np.mean(T[0][offroi])
        ti+=1
            
    return (Tmax, sonicationEndTimes, elapsedTime)






#Trajectory calculation
nturns = ceil( (maxR_mm - minR_mm)/turnspace_mm )

turn_radii_mm = minR_mm + turnspace_mm*np.arange(0,nturns)
num_sonications_per_turn = (np.round( (2*pi*turn_radii_mm/avgSpeed_mm_per_sec) / focalpoint_dwell_seconds ) );

num_sonications_total = np.sum(num_sonications_per_turn)
focalpoint_coords_mm = np.zeros([num_sonications_total, 3])
pass_relative_amplitudes = np.zeros([num_sonications_total, 256])

turnIdxStart=0;
for n in range(0,nturns):
    ns = num_sonications_per_turn[n]
    phis = np.arange(1,ns+1)*(2.0*pi/ns) + 0.5*(2.0*pi/ns)
    x = turn_radii_mm[n]*np.cos(phis)
    y = turn_radii_mm[n]*np.sin(phis)
    z = z_mm*np.ones(ns);
    
    i = turnIdxStart
    
    focalpoint_coords_mm[i:(i+ns),0] = x;
    focalpoint_coords_mm[i:(i+ns),1] = y;
    focalpoint_coords_mm[i:(i+ns),2] = z;
    
    turnIdxStart += ns



nacq0 = num_sonications_total
nacq1 = num_sonications_total

dwell_time0 = focalpoint_dwell_seconds
dwell_time1 = focalpoint_dwell_seconds
wait_time = wait

maxDwell=dwell_time0
if maxDwell < dwell_time1:
    maxDwell=dwell_time1
    
Nt = round(maxDwell/dt)

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

CEM0 = np.zeros([Nx,Ny,Nz])
CEM1 = np.zeros([Nx,Ny,Nz])
Rbase = np.zeros([Nx,Ny,Nz])

CEM0vsTime=np.zeros([nacq0,Nx,Ny,Nz])
CEM1vsTime=np.zeros([nacq1,Nx,Ny,Nz])

Tmax0 = np.zeros([Nx,Ny,Nz])
Tmax1 = np.zeros([Nx,Ny,Nz])

#initial conditions
kdiff[:] = ktdiffusion;
rhoCp[:] = rho*Cp;
CEM0[:] = 0
CEM1[:] = 0


#native focus field
N = uxyz.shape[0]
uamp0 = np.ones(N) / N

P0 = sonalleve.calc_pressure_field(k0, geom.translate3vecs(uxyz, np.array([0, 0, 0 ]) ), uamp0, xrp, yrp, zrp)
I0 = np.abs(P0)**2 / (2.0*rho*c0)

powerRenorm = (Ispta0/np.max(I0))
I0 *= powerRenorm
#update uamp0
uamp0 *= sqrt(powerRenorm)


p0 = 1e7*np.ones(len(pxyz));

pcentroid = np.mean(pxyz,0);
uamp1 = transducers.get_focused_element_vals(k0, uxyz, pxyz, p0 )
uamp1 = sqrt(powerRenorm)*( uamp1  ) / sum(abs(uamp1))

P1 = sonalleve.calc_pressure_field(k0, geom.translate3vecs(uxyz, np.array([0, 0, 0 ]) ), uamp1, xrp, yrp, zrp)
I1reg = np.abs(P1)**2 / (2.0*rho*c0)


Ispta1 = np.max(I1reg)
powerAdj1=1;
uamp1adj = sqrt(powerAdj1)*( uamp1  ) 
    
I1 =powerAdj1*I1reg





if M == 1:
    
    
    CEM0passFinal = np.zeros([npass0,Nx,Ny,Nz])
    Tmax0passFinal = np.zeros([npass0,Nx,Ny,Nz])
    T0passFinal = np.zeros([npass0,Nx,Ny,Nz])
    CEM0vsTimevsPass = np.zeros([npass0,nacq1,Nx,Ny,Nz])
    Temp0vsTimevsPass = np.zeros([npass0,nacq1,Nx,Ny,Nz])
    sonicationEndTimesvsPass0 = np.zeros([npass0, nacq0])
    Temp0vsTimevsPassON = np.zeros([npass0, nacq0])
    Temp0vsTimevsPassOFF = np.zeros([npass0, nacq0])
    
    
    T0=37
    T[0][:]=T0
    CEM0[:]=0
    CEM0vsTime[0][:]=0
    Tmax0[:]=0
    
    
    endTime=0.0;
    try:
        del xdcDwells, xdcWaits, xdcPoints
    except NameError:
       1
        
    xdcDwells = dwell_time1*np.ones([nacq0])
    xdcWaits = wait_time*np.ones([nacq0])
    xdcPoints = 1e-3*focalpoint_coords_mm
    xdcPoints[:,2]=0
    
    for n in range(0,npass0):
        print('pass # ', n+1)
    
        Tmax0, sonicationEndTimes, elapsedTime = sonication_heating_physical_move_nofeedback(
                                                        xdcDwells,xdcWaits, xdcPoints, uamp0,
                                                        CEM0, CEM0vsTime, Temp0vsTimevsPass[n], Temp0vsTimevsPassON[n], Temp0vsTimevsPassOFF[n],
                                                        Tmax=Tmax0, timeZero=endTime, Freeflow=0, onroi=roiOnTarget, offroi=roiOffTarget)
        
        Tfinal0 = T[0].copy()
        
        CEM0passFinal[n] = CEM0;
        Tmax0passFinal[n] = Tmax0
        T0passFinal[n] = Tfinal0
        CEM0vsTimevsPass[n] = CEM0vsTime;
        sonicationEndTimesvsPass0[n] = sonicationEndTimes
        
        endTime = sonicationEndTimes[-1];
    

    t0 = sonicationEndTimesvsPass0[0:npass0].flatten()
    TcurveOn0 = Temp0vsTimevsPassON[0:npass0].flatten()
    TcurveOff0 = Temp0vsTimevsPassOFF[0:npass0].flatten()
    
    f = h5py.File(h5name, "a")
    
    dset= f.create_dataset("geom/trajectory", data=1e-3*focalpoint_coords_mm)
    f.flush()
    
    dset = f.create_dataset("geom/gridx", data=gxp)
    dset.attrs['xp']=xrp
    f.flush()
    
    dset = f.create_dataset("geom/gridy", data=gyp)
    dset.attrs['yp']=zrp
    f.flush()
    
    dset = f.create_dataset("geom/gridz", data=gzp)
    dset.attrs['zp']=zrp
    f.flush()
    
    dset = f.create_dataset("geom/ROION", data=roiOnTarget)
    f.flush()
    
    dset = f.create_dataset("geom/ROIOFF", data=roiOffTarget)
    f.flush()
    
    dset = f.create_dataset("1/CEM", data=CEM0vsTimevsPass)
    
    dset.attrs['T0']=T0
    dset.attrs['kdiff']=ktdiffusion
    dset.attrs['alpha']=alpha_acc
    dset.attrs['perfRate']=perfRate
    dset.attrs['d']=d
    dset.attrs['nfoc']=1
    dset.attrs['xp']=xrp
    dset.attrs['zp']=zrp
    dset.attrs['yp']=yrp
    dset.attrs['resolution'] = [dt,dx,dy,dz]
    dset.attrs['tstops'] = t0
    dset.attrs['passes'] = npass0
    dset.attrs['wait'] = wait_time
    dset.attrs['dwell'] = dwell_time0
    dset.attrs['Ispta'] = Ispta0
    dset.attrs['uamp'] = uamp0
    f.flush()
    
    dset = f.create_dataset("1/TonCurve", data=TcurveOn0)
    dset.attrs['tstops'] = t0
    f.flush()
    dset = f.create_dataset("1/ToffCurve", data=TcurveOff0)
    dset.attrs['tstops'] = t0
    
    f.flush()
    dset = f.create_dataset("%d/T" % M, data=Temp0vsTimevsPass)
    dset.attrs['tstops'] = t0
    
    
    f.flush()
    f.close()
    
    
    
else:
        
    CEM1passFinal = np.zeros([npass1,Nx,Ny,Nz])
    Tmax1passFinal = np.zeros([npass1,Nx,Ny,Nz])
    T1passFinal = np.zeros([npass1,Nx,Ny,Nz])
    CEM1vsTimevsPass = np.zeros([npass1,nacq1,Nx,Ny,Nz])
    Temp1vsTimevsPass = np.zeros([npass1,nacq1,Nx,Ny,Nz])
    sonicationEndTimesvsPass = np.zeros([npass1, nacq1])
    Temp1vsTimevsPassON = np.zeros([npass1, nacq1])
    Temp1vsTimevsPassOFF = np.zeros([npass1, nacq1])
    
    
    T0=37
    T[0][:]=T0
    CEM1[:]=0
    CEM1vsTime[0][:]=0
    Tmax1[:]=0
    
    
    endTime=0.0;
    try:
        del xdcDwells, xdcWaits, xdcPoints
    except NameError:
       1
        
    xdcDwells = dwell_time1*np.ones([nacq1])
    xdcWaits = wait_time*np.ones([nacq1])
    xdcPoints = 1e-3*focalpoint_coords_mm
    xdcPoints[:,2]=0
    
    for n in range(0,npass1):
        print('pass # ', n+1)
    
        Tmax1, sonicationEndTimes, elapsedTime = sonication_heating_physical_move_nofeedback(
                                                        xdcDwells,xdcWaits, xdcPoints, uamp1adj,
                                                        CEM1, CEM1vsTime, Temp1vsTimevsPass[n], Temp1vsTimevsPassON[n], Temp1vsTimevsPassOFF[n], 
                                                        Tmax=Tmax1, timeZero=endTime, Freeflow=flowBCs, onroi=roiOnTarget, offroi=roiOffTarget)
        
        Tfinal1 = T[0].copy()
        
        CEM1passFinal[n] = CEM1;
        Tmax1passFinal[n] = Tmax1
        T1passFinal[n] = Tfinal1
        CEM1vsTimevsPass[n] = CEM1vsTime;
        sonicationEndTimesvsPass[n] = sonicationEndTimes
        
        endTime = sonicationEndTimes[-1];    
        
        
    t1 = sonicationEndTimesvsPass[0:npass1].flatten()
    TcurveOn1 = Temp1vsTimevsPassON[0:npass1].flatten()
    TcurveOff1 = Temp1vsTimevsPassOFF[0:npass1].flatten()
        
    f = h5py.File(h5name, "a")
    
    dset = f.create_dataset("%d/CEM" % M, data=CEM1vsTimevsPass)
    dset.attrs['nfoc']=M
    dset.attrs['passes'] = npass1
    dset.attrs['kdiff']=ktdiffusion
    dset.attrs['alpha']=alpha_acc
    dset.attrs['perfRate']=perfRate
    dset.attrs['d']=d
    dset.attrs['xp']=xrp
    dset.attrs['zp']=zrp
    dset.attrs['yp']=yrp
    dset.attrs['resolution'] = [dt,dx,dy,dz]
    dset.attrs['tstops'] = t1
    dset.attrs['wait'] = wait_time
    dset.attrs['dwell'] = dwell_time1
    dset.attrs['uamp'] = uamp1adj
    f.flush()
    dset = f.create_dataset("%d/TonCurve" % M, data=TcurveOn1)
    dset.attrs['tstops'] = t1
    f.flush()
    dset = f.create_dataset("%d/ToffCurve" % M, data=TcurveOff1)
    dset.attrs['tstops'] = t1
    
    f.flush()
    dset = f.create_dataset("%d/T" % M, data=Temp1vsTimevsPass)
    dset.attrs['tstops'] = t1
    
    f.flush()
    dset = f.create_dataset("%d/pattern" % M, data=pxyz)
    
    
    f.flush()
    f.close()

