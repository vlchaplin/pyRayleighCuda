#!/usr/bin/env python

import sys

from math import *;

sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\myPy')  
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\AblationSims')
sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\BioHeatCpp\\PBHEswig\\x64')

import numpy as np
import geom
import sonalleve
import transducers
import PBHEswig 
import argparse
import ablation_utils

import matplotlib.image as image
import matplotlib.pyplot as plt

import HookJeeves

sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\CUDA\\RSgpu\\Release')
import PBHE_CUDA


# free params of path will be avgSped, dwellSec, waitSec

def isarray(a):
    try:
        shp = a.shape
        return True
    except:
        return False

def contstruct_circ_sonication_points( maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec ):
    """
    (coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points(...)
    Return the points used in constructing concentric circular paths
    """
    turnspace_mm=deltaR_mm
    minR_mm = turnspace_mm / 2.0
    
    nturns = ceil( (maxR_mm - minR_mm)/turnspace_mm )
    
    avgSpeed_mm_per_sec=avgSpd
    focalpoint_dwell_seconds=dwellSec
    wait=waitSec
    
    turn_radii_mm = minR_mm + turnspace_mm*np.arange(0,nturns)
    num_sonications_per_turn = (np.round( (2*pi*turn_radii_mm/avgSpeed_mm_per_sec) / focalpoint_dwell_seconds ) );
    
    num_sonications_total = np.sum(num_sonications_per_turn,dtype=int)
    focalpoint_coords_mm = np.zeros([num_sonications_total, 3])
    #pass_relative_amplitudes = np.zeros([num_sonications_total, 256])
    
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
        
    return (focalpoint_coords_mm, nturns, num_sonications_per_turn)



## Sonication frequency and sound speed
f0 = 1.2e6
c0 = 1540
k0 = 2.0*pi*(f0/c0)


## Default Ispta of single focus field (W/m^2)
Ispta0 = 1.0e7

##Default multi-focus params
M=3
d=0.004 #ring diameter

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

focalpoint_dwell_seconds = 5
avgSpeed_mm_per_sec = 0.6
wait = 2.0

turnspace_mm = 4
maxR_mm = 10

use_gpu=0

parser = argparse.ArgumentParser()
parser.add_argument("-o", help="Output h5 file", type=str)
parser.add_argument("-maxR", help="Max trajectory radius (cm), default = %f" % (maxR_mm*0.1), type=float)
#parser.add_argument("-minR", help="Min trajectory radius (cm), default = %f", type=float)
parser.add_argument("-DR", help="Turn spacing (cm). Default = %f" % (0.1*turnspace_mm), type=float)
parser.add_argument("-nfoc", help="# focal points (1 for single focus)", type=int)
parser.add_argument("-I", help="Peak intensity (Ispta) of the acoustic field in W/cm^2. Default = %f W/cm^2" % (Ispta0*1e-4), type=float)
parser.add_argument("-d", help="Diameter of focal ring (mm)", type=float)
parser.add_argument("-a", help="Dwell seconds (aka heating time per position), default = %f" % focalpoint_dwell_seconds, type=float)
parser.add_argument("-w", help="Wait time, default = %f" % wait, type=float)
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
parser.add_argument("-Nt", help="# time steps to allocate. Default is to allocate enough for max dwell or a max of 50. -Nt will override the max.", type=int)
parser.add_argument("-gpu", help="Use the CUDA kernel version of Rayleigh Sommerfield", action='store_true')

args = parser.parse_args()
if args.o:
    h5name=args.o
if args.maxR:
    maxR_mm = args.maxR*10.0
#if args.minR:
#    minR_mm = args.minR*0.1
if args.DR:
    turnspace_mm = args.DR*10.0
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
if args.gpu :
    use_gpu=1

if use_gpu:
    dataType=np.float32
else:
    dataType=np.float64

xedges = 1e-2*np.linspace(-xw/2.0, xw/2.0,Nx+1)
yedges = 1e-2*np.linspace(-yw/2.0, yw/2.0,Ny+1)
zedges = 1e-2*np.linspace(Z0, Z0+zw,Nz+1)

xrp = xedges[0:Nx]
yrp = yedges[0:Ny]
zrp = zedges[0:Nz]

gxp,gyp,gzp = np.meshgrid(xrp, yrp, zrp, sparse=False, indexing='ij')
calcGridDist= lambda rr: np.sqrt((gxp-rr[0])**2 + (gyp-rr[1])**2 + (gzp-rr[2])**2)

dx = dataType(xrp[1]-xrp[0])
dy = dataType(yrp[1]-yrp[0])
dz = dataType(zrp[1]-zrp[0])
dt = dataType(0.1)

res = np.array([dt,dx,dy,dz],dtype=dataType)
voxVol=dx*dy*dz

zplane=0.14
focplaneZpix=np.where(np.logical_and( (zrp[1:-1]-zplane>=0) , (zrp[0:-2]-zplane<0) ))[0][0]


maxDwell = focalpoint_dwell_seconds
if maxDwell < wait:
    maxDwell = wait

if args.Nt:
    Nt = args.Nt
else:
    Nt = int(round(maxDwell/dt))
    if Nt > 50:
        Nt=50


## ROI ##
roiOnTarget = np.logical_and( np.sqrt(gxp**2 + gyp**2) <= (1e-3*(maxR_mm-2)), np.abs(gzp-0.1375) <= 0.005 )
roiOffTarget = np.logical_and( np.sqrt(gxp**2 + gyp**2) <= 0.025, np.abs(gzp-0.14) <= 0.015 )
roiOffTarget = np.logical_and(roiOffTarget, np.logical_not(roiOnTarget) )
roiExtra = np.logical_and( np.sqrt(gxp**2 + gyp**2) <= (1e-3*1.5*maxR_mm), np.abs(gzp-0.1375) <= 0.0075 )
roiExtra = np.logical_or( roiExtra,
                np.logical_and( np.sqrt(gxp**2 + gyp**2) <= (1e-3*7.5),
                    np.logical_and( gzp-0.14 <= 0.0125, gzp-0.14 >= -0.02 )
                    )
                )

roiOnTarget = geom.roiGen([[0,0,0.14]], lambda x,y,z: geom.inEllipse(x,y,z, 0.01, 0.01,0.017), gxp, gyp, gzp)
roiExtra = geom.roiGen([[0,0,0.14]], lambda x,y,z: geom.inEllipse(x,y,z,0.02,0.02,0.04), gxp, gyp, gzp )
roiOffTarget = np.logical_and( roiExtra, np.logical_not(roiOnTarget))


#this would be useful only if in an interactive session
try:
    del CEM, Rbase, T, Tdot, kdiff, rhoCp, Tmesh, Tdotmesh, kmesh, rhoCpmesh, roiOnTarget, roiOffTarget, roiExtra
except NameError:
   1

try:
    del simPhysGrid
except NameError:
   1

# ----- allocate numpy data arrays --- #
T = np.zeros([Nt,Nx,Ny,Nz],dtype=dataType)
Tdot = np.zeros([Nx,Ny,Nz],dtype=dataType)
kdiff = np.zeros([Nx,Ny,Nz],dtype=dataType)
rhoCp = np.zeros([Nx,Ny,Nz],dtype=dataType)

# ---- Create C++ mesh objects ---

if dataType == np.float32:
    Tmesh = PBHE_CUDA.mesh4d_f()
    Tdotmesh = PBHE_CUDA.mesh34d_f();
    kmesh = PBHE_CUDA.mesh3d_f();
    rhoCpmesh = PBHE_CUDA.mesh3d_f();


    kdiff[:]=ktdiffusion
    rhoCp[:]= rho*Cp
    ### IMPORTANT!! The 'tying' step appears to be needed before copying a reference into simPhysGrid{} below
    # ----- tie data arrays to mesh objects (to pass to C++) ---
    # the data in each mesh can now be accessed/manipulated from python via the arrays, 'T', 'Tdot', etc.
    PBHE_CUDA.ShareMemoryMesh4_f(T, res, Tmesh)
    PBHE_CUDA.ShareMemoryMesh34_f(Tdot, res, Tdotmesh)
    PBHE_CUDA.ShareMemoryMesh3_f(kdiff, res[1:4], kmesh)
    PBHE_CUDA.ShareMemoryMesh3_f(rhoCp, res[1:4], rhoCpmesh)
else:
    Tmesh = PBHE_CUDA.mesh4d()
    Tdotmesh = PBHE_CUDA.mesh34d();
    kmesh = PBHE_CUDA.mesh3d();
    rhoCpmesh = PBHE_CUDA.mesh3d();


    kdiff[:]=ktdiffusion
    rhoCp[:]= rho*Cp
    ### IMPORTANT!! The 'tying' step appears to be needed before copying a reference into simPhysGrid{} below
    # ----- tie data arrays to mesh objects (to pass to C++) ---
    # the data in each mesh can now be accessed/manipulated from python via the arrays, 'T', 'Tdot', etc.
    PBHE_CUDA.ShareMemoryMesh4(T, res, Tmesh)
    PBHE_CUDA.ShareMemoryMesh34(Tdot, res, Tdotmesh)
    PBHE_CUDA.ShareMemoryMesh3(kdiff, res[1:4], kmesh)
    PBHE_CUDA.ShareMemoryMesh3(rhoCp, res[1:4], rhoCpmesh)

simPhysGrid = {}
simPhysGrid['T'] = T
simPhysGrid['Tdot'] = Tdot
simPhysGrid['kt'] = kdiff
simPhysGrid['rhoCp'] = rhoCp
simPhysGrid['Tmesh'] = Tmesh
simPhysGrid['Tdotmesh'] = Tdotmesh
simPhysGrid['kmesh'] = kmesh
simPhysGrid['rhoCpmesh'] = rhoCpmesh
simPhysGrid['dtxyz'] = res


Rbase = np.zeros([Nx,Ny,Nz],dtype=dataType)
CEM = np.zeros([Nx,Ny,Nz],dtype=dataType)

## Load Sonalleve element positions
uxyz = sonalleve.get_sonalleve_xdc_vecs()
N = uxyz.shape[0]

unvecs = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, [0.0,0.0,0.14] - uxyz )

uamp0 = np.ones(N) / N

if use_gpu:
    P0 = transducers.calc_pressure_field_cuda(k0, uxyz, unvecs, uamp0, xrp, yrp, zrp, subsampN=10, subsampDiam=0.0033, ROC=0.14)
else:
    P0 = sonalleve.calc_pressure_field(k0, geom.translate3vecs(uxyz, np.array([0, 0, 0 ]) ), uamp0, xrp, yrp, zrp)
    
I0 = np.abs(P0)**2 / (2.0*rho*c0)

preNormI0max = np.max(I0)
### >> First use of 'd'
### >> First use of 'M'
# Multi-focus template (in xy plane)
ring,radius = geom.ring(d,M,z=0.0)
spacing = 2*(radius**2)*(1 - cos(2*pi/M))
h=radius
pxyz=ring;

#uamp1OnAxis = transducers.get_focused_element_vals(k0, uxyz, pxyz, np.ones([M]), L1renorm=sqrt(powerRenorm) )
#P1Onaxis = sonalleve.calc_pressure_field(k0, uxyz, uamp1OnAxis, xrp, yrp, zrp)
#I1Onaxis = np.abs(P1Onaxis)**2 / (2.0*rho*c0)

print('Proceeding with simulation...', flush=True)

#run_simulation_4  -  (speed, dwell, wait, Ispta)
def run_simulation_4( param_vec, verbose=False, show=False, Npass=1, T0=37.0, calc_Tmax=False, subsampN=None ):
    """
    param_vec = [speed (mm/s), dwell (s), wait (s), I0 (W/m^2) ]
    """
    (avgSpeed_mm_per_sec, focalpoint_dwell_seconds, wait, Ispta) = param_vec
    
    ### >> First use of ISPTA 
    # Get power normalization value 
    powerRenorm = (Ispta/preNormI0max)
    
    
    
    ### >> First use of TRAJECTORY params: maxR, deltaR, speed, dwell, wait
    ## Construct trajectory
    (focalpoint_coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points( maxR_mm, turnspace_mm, zplane*1000,
                                                                                                 avgSpeed_mm_per_sec, focalpoint_dwell_seconds, wait)
    if show:
        plt.plot( focalpoint_coords_mm[:,0], focalpoint_coords_mm[:,1], '*-' )
        plt.show()
    num_sonications_total = np.sum(num_sonications_per_turn,dtype=int)
    
    #elapsedTime = ablation_utils.calc_heating( simPhysGrid, duration, CEM, Rbase, perfRate=perfRate, perfTemp=37.0, Freeflow=flowBCs)
    
    if calc_Tmax:
        Tmax = np.zeros_like(T[0])
    else:
        Tmax=None
    
    T[0][:] = T0
    CEM[:] = 0
    sonicate=True
    angle = pi/(Npass+1)
    Rn = geom.getRotZYZarray(angle,0,0)
    passnum=1
    while (passnum<=Npass):
        
        
        ## Compute apodization for these trajectory points
        pass_relative_amplitudes = np.zeros([num_sonications_total, N], dtype=complex)
        for n in range(0,num_sonications_total,1):
            pass_relative_amplitudes[n] = transducers.get_focused_element_vals(k0, uxyz, pxyz + focalpoint_coords_mm[n]*1e-3, np.ones([M]), L1renorm=sqrt(powerRenorm) )
    
        
        for n in range(0,num_sonications_total,1):
            
            if verbose:
                print ('sonication %d / %d' % (n+1, num_sonications_total), end='\n' )
            if use_gpu:
                P1 = transducers.calc_pressure_field_cuda(k0, uxyz, unvecs, pass_relative_amplitudes[n], xrp, yrp, zrp, subsampN=subsampN, subsampDiam=0.0033, ROC=0.14, gpublocks=512 )
            else:
                P1 = sonalleve.calc_pressure_field(k0, uxyz, pass_relative_amplitudes[n], xrp, yrp, zrp)
                
            I1 = np.abs(P1)**2 / (2.0*rho*c0)
            #print ('                                                 ', end='\r' )
            #print ("0 %f, %f" % (np.max(T), np.max(Tdot)), end=' ok \n')
            Tdot[:] = dataType(2.0*alpha_acc*I1 / rhoCp)
            ablation_utils.calc_heating(simPhysGrid,T,Tdot,Tmesh,Tdotmesh,kmesh,rhoCpmesh,focalpoint_dwell_seconds, CEM, Rbase, perfRate=perfRate, perfTemp=37.0, Freeflow=flowBCs,verbose=verbose, GPU=use_gpu, Ntbuff=Nt)
            
            #PBHE_CUDA.Pennes_2ndOrder_GPU64_mesh(flowBCs, dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, 37.0, perfRate )
            
            Tdot[:] = 0.0
            ablation_utils.calc_heating(simPhysGrid,T,Tdot,Tmesh,Tdotmesh,kmesh,rhoCpmesh,wait, CEM, Rbase, perfRate=perfRate, perfTemp=37.0, Freeflow=flowBCs, GPU=use_gpu , Ntbuff=Nt)
            
            if calc_Tmax:
                #update = np.where(T[0] > Tmax, True, False)
                update = T[0] > Tmax
                Tmax[update] = T[0][update]
            
            
        passnum+=1
        #rotate sonication points
        focalpoint_coords_mm = focalpoint_coords_mm.dot(Rn)
        
    return Tmax
        
        

numTargetVox = np.sum(roiOnTarget)
def VolumeObjective_4(param_vec, verbose=False, show=False, Npass=1, T0=37.0, subsampN=None ):
    """
    param_vec = [speed (mm/s), dwell (s), wait (s), I0 (W/m^2) ]
    """
    
    run_simulation_4( param_vec, verbose=verbose, show=show, Npass=Npass, T0=T0, subsampN=subsampN)
    value = ( np.sum(CEM[roiExtra] >= 240.0) - numTargetVox )**2
    print (param_vec, " -> ", value, flush=True)
    return value

def VolumeTempObjective_4(param_vec, verbose=False, show=False, Npass=1, T0=37.0, subsampN=None ):
    """
    param_vec = [speed (mm/s), dwell (s), wait (s), I0 (W/m^2) ]
    """
    
    Tmax=run_simulation_4( param_vec, verbose=verbose, show=show, Npass=Npass, T0=T0, calc_Tmax=True, subsampN=subsampN)
    value = ( np.sum(CEM[roiExtra] >= 240.0) - numTargetVox )**2
    
    duration = ablation_utils.trajTotalTime(maxR_mm, turnspace_mm, 0, param_vec[0], param_vec[1], param_vec[2])
    
    onRate=np.mean(Tmax[roiOnTarget]) - T0
    offRate=np.mean(Tmax[roiOffTarget]) - T0
    print (param_vec, " -> ", value, onRate, offRate, flush=True)
    return (value, onRate, offRate)
 
def CEMObjective_4( param_vec, verbose=False, show=False, Npass=1, T0=37.0, subsampN=None ):
    """
    param_vec = [speed (mm/s), dwell (s), wait (s), I0 (W/m^2) ]
    """
    run_simulation_4( param_vec, verbose=verbose, show=show, Npass=Npass, T0=T0, subsampN=subsampN)
    value = np.mean( (CEM[roiOnTarget] - 240.0)**2 )
    print (param_vec, " -> ", value, flush=True)
    return value


x0 = np.array([avgSpeed_mm_per_sec, focalpoint_dwell_seconds, wait, Ispta0])
dx0 = np.array([0.25, 0.5, 1.0, 200e4])
tol = np.array([0.075, 0.1, 0.1, 50e4])
