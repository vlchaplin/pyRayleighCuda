#!/usr/bin/env python3

import numpy as np;
import matplotlib.image as image
import matplotlib.pyplot as plt
import pylab
import math
import h5py
import sys

sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\BioHeat\\BioHeatCpp\\PBHEswig\\x64')
import PBHEswig


try:
    sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\CUDA\\RSgpu\\Release')
    import PBHE_CUDA
except ImportError:
    print('PBHE_CUDA not loaded, using PBHEswig interface to BioHeat')

import transducers
import sonalleve
import geom

# simPhysGrid params
# 'Tmesh' - corresponding 4d mesh object
# 'Tdotmesh' - 3d mesh object
# 'kmesh' - 3d mesh object
# 'rhoCpmesh' - 3d mesh object
#
# 'T' - numpy 4d array
# 'CEM' numpy 3d array
#  'dtxyz' - 4d resolution

def test():
    obj=PBHEswig.mesh1d()
    return obj

def isarray(a):
    try:
        shp = a.shape
        return True
    except:
        return False

def makeSimPhysGrid(dtype=np.float32,nx=64,ny=64,nz=64,nt=30, dt=0.1, xr=[-2.0, 2.0], yr=[-2.0,2.0], zr=[11., 17.], rho=1000.0, Cp=3700.0,ktherm=0.6, c0=1540,f0=1.2e6):
    """

    Grid spacing will be dx=(xr[-1] - xr[0])/(nx-1), same for dy,dz.
    Total duration of a grid will be nt*dt

    Kwargs:
        dtype: numpy.float32 or numpy float64
        dt: (seconds)
        xr: (cm)
        yr: (cm)
        zr: (cm)
        Cp: heat capacitance (J/(kg*K))
        rho: density (kg/m^3)
        ktherm:  thermal conductivity (W/(m*K))

    """

    dataType=dtype

    T=np.zeros([nt,nx,ny,nz],dtype=dataType)
    Tdot=np.zeros([nx,ny,nz],dtype=dataType)
    kdiff=np.zeros([nx,ny,nz],dtype=dataType)
    rhoCp=np.zeros([nx,ny,nz],dtype=dataType)

    CEM=np.zeros([nx,ny,nz],dtype=dataType)
    CEM0=np.zeros_like(CEM)

    xrp = 0.01*np.linspace(xr[0],xr[1], nx, dtype=dataType)
    yrp = 0.01*np.linspace(yr[0],yr[1], ny, dtype=dataType)
    zrp = 0.01*np.linspace(zr[0],zr[1], nz, dtype=dataType)
    dx=xrp[1]-xrp[0]
    dy=yrp[1]-yrp[0]
    dz=zrp[1]-zrp[0]
    #dt=0.1

    k0 = 2*math.pi*f0/c0
    #zplane=0.14
    #focplaneZpix=np.where(np.logical_and( (zrp[1:-1]-zplane>=0) , (zrp[0:-2]-zplane<0) ))[0][0]

    res = np.array([dt,dx,dy,dz],dtype=dataType)

    kdiff[:]=ktherm
    rhoCp[:]= rho*Cp


    try:
        #If the CUDA version is loaded, use it
        PBHE = PBHE_CUDA
    except NameError:
        PBHE = PBHEswig

    if dataType == np.float32:
        Tmesh = PBHE.mesh4d_f()
        Tdotmesh = PBHE.mesh34d_f();
        kmesh = PBHE.mesh3d_f();
        rhoCpmesh = PBHE.mesh3d_f();


        PBHE.ShareMemoryMesh4_f(T, res, Tmesh)
        PBHE.ShareMemoryMesh34_f(Tdot, res, Tdotmesh)
        PBHE.ShareMemoryMesh3_f(kdiff, res[1:4], kmesh)
        PBHE.ShareMemoryMesh3_f(rhoCp, res[1:4], rhoCpmesh)
    else:
        Tmesh = PBHE.mesh4d()
        Tdotmesh = PBHE.mesh34d();
        kmesh = PBHE.mesh3d();
        rhoCpmesh = PBHE.mesh3d();

        PBHE.ShareMemoryMesh4(T, res, Tmesh)
        PBHE.ShareMemoryMesh34(Tdot, res, Tdotmesh)
        PBHE.ShareMemoryMesh3(kdiff, res[1:4], kmesh)
        PBHE.ShareMemoryMesh3(rhoCp, res[1:4], rhoCpmesh)

    #gxp,gyp,gzp = np.meshgrid(xrp, yrp, zrp, sparse=False, indexing='ij')
    #calcGridDist= lambda rr: np.sqrt((gxp-rr[0])**2 + (gyp-rr[1])**2 + (gzp-rr[2])**2)

    simPhysGrid = {'T':T,'Tdot':Tdot,'Tmesh':Tmesh,'Tdotmesh':Tdotmesh,'kmesh': kmesh, 'rhoCpmesh':rhoCpmesh, 'kt': kdiff, 'rhoCp': rhoCp}
    simPhysGrid['dtxyz'] = res
    simPhysGrid['c0']=c0
    simPhysGrid['rho']=rho
    simPhysGrid['k0']=k0
    simPhysGrid['xrp']=xrp
    simPhysGrid['yrp']=yrp
    simPhysGrid['zrp']=zrp

    xrp = simPhysGrid['xrp']
    yrp = simPhysGrid['yrp']
    zrp = simPhysGrid['zrp']

    return simPhysGrid

def kohler_trajectories( maxR_mm, z_mm ):

    """

    maxR_mm must be either 4,8,12,16
    z_mm is the plane of the trajectory (typically z_mm=140)

    Returns (coords_mm, nturns, num_sonications_per_turn)
    """

    #Nppt = {}
    #Nppt["4"]=8
    #Nppt["8"]=16
    #Nppt["12"]=24
    #Nppt["16"]=32
    Nppt=[8, 16, 24, 32]

    if abs(math.floor(maxR_mm/4.0) - maxR_mm/4.0) > 1e-7:
        raise ValueError
    else:
        maxR_mmstr="%d"%maxR_mm

    nnt = 0
    if maxR_mmstr == "4":
        nnt = 1
    if maxR_mmstr == "8":
        nnt = 2
    if maxR_mmstr == "12":
        nnt = 3
    if maxR_mmstr == "16":
        nnt = 4

    num_sonications_per_turn = np.array(Nppt[0:nnt])
    focalpoint_coords_mm = np.zeros([np.sum(num_sonications_per_turn), 3])
    turn_radii_mm = np.linspace(4.0,maxR_mm,nnt)

    turnIdxStart=0;
    for n in range(0,nnt):
        ns = num_sonications_per_turn[n]
        dphi = (2.0*math.pi/ns)*(ns/2.0 -1)
        #phis = np.arange(1,ns+1)*(2.0*math.pi/ns) + 0.5*(2.0*math.pi/ns)
        phis = np.arange(0,ns)*dphi
        x = turn_radii_mm[n]*np.cos(phis)
        y = turn_radii_mm[n]*np.sin(phis)
        z = z_mm*np.ones(ns);

        i = turnIdxStart

        focalpoint_coords_mm[i:(i+ns),0] = x;
        focalpoint_coords_mm[i:(i+ns),1] = y;
        focalpoint_coords_mm[i:(i+ns),2] = z;

        turnIdxStart += ns


    return (focalpoint_coords_mm, nnt, num_sonications_per_turn)



def contstruct_circ_sonication_points( maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec ):
    """
    (coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points(...)
    Return the points used in constructing concentric circular paths
    """
    turnspace_mm=deltaR_mm
    minR_mm = turnspace_mm / 2.0

    nturns = math.ceil( (maxR_mm - minR_mm)/turnspace_mm )

    avgSpeed_mm_per_sec=avgSpd
    focalpoint_dwell_seconds=dwellSec
    wait=waitSec

    turn_radii_mm = minR_mm + turnspace_mm*np.arange(0,nturns)
    num_sonications_per_turn = (np.round( (2*math.pi*turn_radii_mm/avgSpeed_mm_per_sec) / focalpoint_dwell_seconds ) );

    num_sonications_total = np.sum(num_sonications_per_turn,dtype=int)
    focalpoint_coords_mm = np.zeros([num_sonications_total, 3])
    #pass_relative_amplitudes = np.zeros([num_sonications_total, 256])

    turnIdxStart=0;
    for n in range(0,nturns):
        ns = num_sonications_per_turn[n]
        phis = np.arange(1,ns+1)*(2.0*math.pi/ns) + 0.5*(2.0*math.pi/ns)
        x = turn_radii_mm[n]*np.cos(phis)
        y = turn_radii_mm[n]*np.sin(phis)
        z = z_mm*np.ones(ns);

        i = turnIdxStart

        focalpoint_coords_mm[i:(i+ns),0] = x;
        focalpoint_coords_mm[i:(i+ns),1] = y;
        focalpoint_coords_mm[i:(i+ns),2] = z;

        turnIdxStart += ns

    return (focalpoint_coords_mm, nturns, num_sonications_per_turn)


def countSonications(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec):
    """
    Return the number of sonications in a single pass.
    """
    param_tuple = (maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec)
    (junk,junk, nn)=contstruct_circ_sonication_points(*param_tuple)
    return sum(nn)


def trajTotalTime(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec):
    """
    Return the total time of the sonication pass (including dwell + wait)
    """
    (junk,junk, nn)=contstruct_circ_sonication_points(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec)
    return sum(nn)*(dwellSec + waitSec) - waitSec


def trajSumEnergy(xrp,yrp,zrp,maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec, L1renorm=1, Npass=1, k0=4895.98855, uxyz=None, unvecs=None, pxyz=None, use_gpu=False, subsampN=None, verbose=False ):

    if uxyz is None:
        uxyz = sonalleve.get_sonalleve_xdc_vecs()
    if pxyz is None:
        pxyz = [[0,0,0]]

    M = len(pxyz)
    N = uxyz.shape[0]

    Nx=len(xrp); Ny = len(yrp); Nz=len(zrp);

    Itot = np.zeros([Nx,Ny,Nz])

    (focalpoint_coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec)

    num_sonications_total = np.sum(num_sonications_per_turn,dtype=int)

    passnum=1
    while (passnum<=Npass):

        pass_relative_amplitudes = np.zeros([num_sonications_total, N], dtype=complex)
        for n in range(0,num_sonications_total,1):
            pass_relative_amplitudes[n] = transducers.get_focused_element_vals(k0, uxyz, pxyz + focalpoint_coords_mm[n]*1e-3, np.ones([M]), L1renorm=L1renorm )

        for n in range(0,num_sonications_total,1):

            if verbose:
                print( '\rPass %d/%d, %d%%' % (passnum, Npass, float(n+1)/num_sonications_total *100.0), end=' ',  flush=True)

            if use_gpu:
                P1 = transducers.calc_pressure_field_cuda(k0, uxyz, unvecs, pass_relative_amplitudes[n], xrp, yrp, zrp, subsampN=subsampN, subsampDiam=0.0033, ROC=0.14, gpublocks=512 )
            else:
                P1 = sonalleve.calc_pressure_field(k0, uxyz, pass_relative_amplitudes[n], xrp, yrp, zrp)

            Itot += (dwellSec*np.abs(P1)**2)

        passnum+=1

    return Itot

def trajectorySettings(trajectorySpec,  is_path=False, doRotation=True, use_kohler_traj=False, AlternatePhases=False,
                        L1renorm=None, L2renorm=None, Npass=1, k0=4895.98855, tzero=0.0, PathRotMat=None,
                        uxyz=None, pxyz=None,  **kwargs):

    """
    Returns (timeEdges,amplitudes). There are 2 points per sonication: 1 dwell, 1 wait

    trajectorySpec = [maxR_mm, deltaR_mm, z_mm, speed (mm/s), dwell (s), wait (s) ]

    if use_kohler_traj=True, and trajectorySpec is a two-element list:
         trajectorySpec = [maxR_mm, z_mm], in which case deltaR_mm=4 and the other params are zero


    pxyz= pass an Mx3 array for a multi-focus beam geometry. Typically z=0 in these vectors.  The pxyz is shifted to the focal point coords and at the z_mm plane in trajectory spec.
    """
    #(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec) = trajectorySpec

    if uxyz is None:
        uxyz = sonalleve.get_sonalleve_xdc_vecs()
    if pxyz is None:
        pxyz = [[0,0,0]]

    M = len(pxyz)
    N = uxyz.shape[0]

    if L1renorm is None and L2renorm is None:
        L1renorm=1

    if use_kohler_traj:
        if len(trajectorySpec)==2:
            maxR_mm = trajectorySpec[0]
            z_mm = trajectorySpec[1]
            (deltaR_mm, avgSpd, dwellSec, waitSec) = [4.0, 0, 0, 0]
        else:
            (maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec) = trajectorySpec

        (focalpoint_coords_mm, nturns, num_sonications_per_turn) = kohler_trajectories(maxR_mm, z_mm)
    elif is_path:
        #Trajectory is a Nx3 array of focal point centroids.  pxyz pattern will be applied at each point
        (focalpoint_coords_mm, dwellSec, waitSec) = trajectorySpec
        nturns=1
        num_sonications_per_turn=[len(focalpoint_coords_mm)]
    else:
        (maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec) = trajectorySpec
        (focalpoint_coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec)


    num_sonications = np.sum(num_sonications_per_turn,dtype=int)
    num_sonications_total = Npass*num_sonications
    num_vectors = 2*num_sonications_total

    passnum=1
    angle = 2*math.pi/(Npass)
    Rn = geom.getRotZYZarray(angle,0,0)

    amplitudes = np.zeros([num_vectors, N], dtype=complex)
    timeEdges = np.zeros(num_vectors+1) + tzero

    if PathRotMat is not None:
        focalpoint_coords_mm = (focalpoint_coords_mm - [0.0, 0.0, z_mm]).dot(PathRotMat) + [0.0, 0.0, z_mm]

    while (passnum<=Npass):

        for n in range(0,num_sonications,1):
            #sonication index
            si = n + num_sonications*(passnum-1)
            timeEdges[2*si+1] = timeEdges[2*si] + dwellSec
            timeEdges[2*si+2] = timeEdges[2*si+1] + waitSec
            amplitudes[2*si] = transducers.get_focused_element_vals(k0, uxyz, pxyz + focalpoint_coords_mm[n]*1e-3, np.ones([M]), L1renorm=L1renorm, L2renorm=L2renorm, AlternatePhases=AlternatePhases )
            amplitudes[2*si+1][:] = 0

        passnum+=1
        if doRotation:
            focalpoint_coords_mm = focalpoint_coords_mm.dot(Rn)

    return (timeEdges,amplitudes)


def trajectorySonication(trajectorySpec, simPhysGrid, perfRate=0.0, perfTemp=37.0, AlternatePhases=False,
                        L1renorm=None, L2renorm=None, Npass=1, k0=4895.98855, Tavg=False, voxmask=None, tzero=0.0, PathRotMat=None,
                        use_kohler_traj=False,
                        uxyz=None, unvecs=None, pxyz=None, use_gpu=False, CEM=None,Rbase=None, RSkeys={}, PBkeys={}, **kwargs):

    """
    trajectorySpec = [maxR_mm, deltaR_mm, z_mm, speed (mm/s), dwell (s), wait (s) ]
    pxyz= pass an Mx3 array for a multi-focus beam geometry. Typically z=0 in these vectors.  The pxyz is shifted to the focal point coords and at the z_mm plane in trajectory spec.
    """
    (maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec) = trajectorySpec

    if uxyz is None:
        uxyz = sonalleve.get_sonalleve_xdc_vecs()
    if pxyz is None:
        pxyz = [[0,0,0]]
    if unvecs is None:
        unvecs=[0,0,0.14] - uxyz

    if L1renorm is None and L2renorm is None:
        L1renorm=1


    M = len(pxyz)
    N = uxyz.shape[0]

    if use_kohler_traj:
            (focalpoint_coords_mm, nturns, num_sonications_per_turn) = kohler_trajectories(maxR_mm, z_mm)
    else:
        (focalpoint_coords_mm, nturns, num_sonications_per_turn) = contstruct_circ_sonication_points(maxR_mm, deltaR_mm, z_mm, avgSpd, dwellSec, waitSec)

    num_sonications = np.sum(num_sonications_per_turn,dtype=int)
    num_sonications_total = Npass*num_sonications
    num_vectors = 2*num_sonications_total

    passnum=1
    angle = 2*math.pi/(Npass)
    Rn = geom.getRotZYZarray(angle,0,0)

    amplitudes = np.zeros([num_vectors, N], dtype=complex)
    timeEdges = np.zeros(num_vectors+1) + tzero

    if PathRotMat is not None:
        focalpoint_coords_mm = (focalpoint_coords_mm - [0.0, 0.0, z_mm]).dot(PathRotMat) + [0.0, 0.0, z_mm]

    while (passnum<=Npass):

        for n in range(0,num_sonications,1):
            #sonication index
            si = n + num_sonications*(passnum-1)
            timeEdges[2*si+1] = timeEdges[2*si] + dwellSec
            timeEdges[2*si+2] = timeEdges[2*si+1] + waitSec
            amplitudes[2*si] = transducers.get_focused_element_vals(k0, uxyz, pxyz + focalpoint_coords_mm[n]*1e-3, np.ones([M]), L1renorm=L1renorm, L2renorm=L2renorm, AlternatePhases=AlternatePhases )
            amplitudes[2*si+1][:] = 0

        passnum+=1
        focalpoint_coords_mm = focalpoint_coords_mm.dot(Rn)

    tstarts = timeEdges[0:-1]
    tstops = timeEdges[1:]
    CEM = sonicate4D(simPhysGrid,tstarts, tstops, amplitudes, uxyz, unvecs, use_gpu=use_gpu, CEM=CEM, Rbase=Rbase, RSkeys=RSkeys, PBkeys=PBkeys, **kwargs)

    return (timeEdges,focalpoint_coords_mm,CEM)


def sonicate4D(simPhysGrid, tstarts, tstops, uamplitudes, uxyz, unvecs, calcField=True, alpha_acc=1, use_gpu=False, CEM=None,Rbase=None, verbose=False, RSkeys={}, PBkeys={} ):
    """
    Returns CEM.
    uxyz - an Nx3 or kk x N x 3

    subsampN=subsampN, subsampDiam=0.0033, ROC=0.14, gpublocks=512

    PBkeys:
    see calc_heating()
    """
    xrp = simPhysGrid['xrp']
    yrp = simPhysGrid['yrp']
    zrp = simPhysGrid['zrp']

    T = simPhysGrid['T']
    Tdot = simPhysGrid['Tdot']
    Tmesh = simPhysGrid['Tmesh']
    Tdotmesh= simPhysGrid['Tdotmesh']
    rhoCpmesh = simPhysGrid['rhoCpmesh']
    kmesh = simPhysGrid['kmesh']
    k3d= simPhysGrid['kt']
    rhoCp3d = simPhysGrid['rhoCp']

    rho=simPhysGrid['rho']
    c0=simPhysGrid['c0']
    k0=simPhysGrid['k0']

    (dt,dx,dy,dz) = simPhysGrid['dtxyz']
    (nt,nx,ny,nz) = T.shape

    dataType = T.dtype.type

    if CEM is None:
        CEM = np.zeros([nx,ny,nz])

    if Rbase is None:
        Rbase = np.zeros([nx,ny,nz])

    if type(uamplitudes)==list:
        ka=len(uamplitudes)
    elif uamplitudes.ndim == 2:
        ka = uamplitudes.shape[0]
    else:
        ka=1
        uamplitudes=[uamplitudes]

    if type(uxyz)==list:
        kk=len(uxyz)
        N=uxyz[0].shape[0]
    elif uxyz.ndim == 3:
        kk = uxyz.shape[0]
        N = uxyz.shape[1]
    else:
        kk=1
        N = uxyz.shape[0]
        uxyz=[uxyz]

    if type(unvecs)==list:
        kv=len(unvecs)
    elif unvecs.ndim == 3:
        kv = unvecs.shape[0]
    else:
        kv=1
        unvecs=[unvecs]

    nnt = len(tstarts)

    doFieldUpdate=np.zeros(nnt,dtype=bool)

    if calcField:
        doFieldUpdate[0]=True
        a=0
        for ti in range(1,nnt):
            b=(ti % kk) + (ti % kv) + (ti % ka)
            if a!=b:
                doFieldUpdate[ti]=True
            a=b

    Tinit = T[0].copy()

    PBHEgpu=use_gpu
    if 'GPU' in PBkeys:
        PBHEgpu=PBkeys['GPU']
    else:
        PBkeys['GPU']=PBHEgpu

    for ti in range(0,nnt):

        if verbose:
            print( '\r%3d/%3d, %d%%' % (ti, nnt, float(ti)/nnt *100.0), end=' ',  flush=True)

        if doFieldUpdate[ti]:

            if np.sum( np.abs(uamplitudes[ti % ka]) ) < 1.0:
                Tdot[:]=0
            else:
                if use_gpu:

                    P1 = transducers.calc_pressure_field_cuda(k0, uxyz[ti % kk], unvecs[ti % kv], uamplitudes[ti % ka], xrp, yrp, zrp, **RSkeys )
                else:
                    P1 = transducers.calc_pressure_field(k0, uxyz[ti % kk], uamplitudes[ti % ka], xrp, yrp, zrp, unormals=unvecs[ti % kv],  **RSkeys )

                I1 = np.abs(P1)**2 / (2.0*rho*c0)
                Tdot[:] = dataType(2.0*alpha_acc*I1 / rhoCp3d)

        duration = tstops[ti] - tstarts[ti]
        calc_heating(simPhysGrid, T, Tdot, Tmesh, Tdotmesh, kmesh, rhoCpmesh, duration, CEM, Rbase, interpoffset=tstarts[ti], **PBkeys)

    if verbose:
        print( '\r%3d/%3d, %d%%' % (ti+1, nnt, float(ti+1)/nnt *100.0), end=' ',  flush=True)
    return CEM



def calc_heating(simPhysGrid,T,Tdot,Tmesh,Tdotmesh,kmesh,rhoCpmesh, duration, CEM, Rbase,
                 interpTimes=None, interpolatedTemp=None, interpoffset=0.0, interpmask=None, interpFunc=None,
                 Ntbuff=None, perfRate=0.0, perfTemp=37.0, Tavg=False, voxmask=None,
                 T0=None, CEMinit=None, Tmax=None, Freeflow=0, verbose=False, GPU=False, useSimGrid=False):

    """
    Returns (time, Tmax, timeList, TavgList)
    where 'time' is the actual duration of that was calculated

    simPhysGrid is a dict with the following keys:
        'Tmesh' - 4d PBHESwig mesh object, containing temperature data for the grid
        'Tdotmesh' - 3d PBHESwig mesh object, containing temperature source data for the grid
        'kmesh' - 3d PBHESwig mesh object, containing thermal conductivity values
        'rhoCpmesh' - 3d PBHESwig mesh object, containing values of density times heat capacity

        'T' - numpy 4d array corresponding to Tmesh. Should have already been associated using PBHESwig.ShareMemoryMesh4(T, res, Tmesh)

    Other args:
    'duration' - duration for which source is on and calculated for.  If duration is greater than dt*Nt, loops are performed.
    'CEM' - numpy 3d array. Thermal dose will be integrated at each step of the temperature calculation
    'Rbase' -  numpy 3d array with same shape as CEM. passing this in saves allocation time.

    Optional args;
    'perfRate' - 1/seconds.  Magnitude of perfusion sink. Set to zero for no perfusion.
    'perfTemp' - Temperature of perfusion sink term, in C.
    'T0' - modify T[0] to this value. Can be a scalar value or 3d array with same dims as T.shape[1:4].
    'CEMinit' - modify CEM to be this before doing the calculation.
    'Tmax' - if a 3D array is passed in via this keyword, it will contain the maximum temperature reached in each voxel.
    'Freeflow' - 0 or 1.  0 means fixed temperature boundaries.  1 means heat is allowed to flow out (adiabatic condition).

    Tavg=False , or True.
    voxmask = 3d mask of voxels for averaging temperature




    If Tavg=True, ti
    """

    if GPU:
        try:
            #If the CUDA version is loaded, use it
            PBHE_CUDA
        except NameError:
            print('PBHE_CUDA not loaded so GPU enabled')
            return

    if useSimGrid:
        T = simPhysGrid['T']
        Tdot = simPhysGrid['Tdot']
        Tmesh = simPhysGrid['Tmesh']
        Tdotmesh= simPhysGrid['Tdotmesh']

    k3d= simPhysGrid['kt']
    rhoCp3d = simPhysGrid['rhoCp']

    (dt,dx,dy,dz) = simPhysGrid['dtxyz']
    (nt,nx,ny,nz) = T.shape

    #Dtxyz = np.array([dt,dx,dy,dz])

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


    time=0
    ti=0
    if Ntbuff is None:
        buffsize=nt
    else:
        buffsize=Ntbuff

    tstep=dt*buffsize

    record_temporal=False
    timeList=None
    TavgList=None
    if (Tavg) and voxmask is not None:
        record_temporal=True
        timeList=[]
        if Tavg:
            TavgList=[]
        else:
            TavgList=None

    if interpTimes is not None:
        numInterp = len(interpTimes)
        kk=0;

        interpMode=0
        if interpmask is not None:
            interpMode+=2
        if interpFunc is not None:
            interpMode+=4

    else:
        numInterp=0

    while time<duration :
        #print("here 2", flush=True)
        if verbose:
            print( '%d%%' % (time/duration *100.0), end='\n',  flush=True)

        if (time + tstep > duration):
            buffsize = math.ceil((duration-time)/dt)
            if (buffsize > nt):
                buffsize=nt
            tstep = dt*buffsize

        if not GPU:
            if T.dtype == np.float64:
                PBHEswig.pbheSolve(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
            elif T.dtype == np.float32:
                PBHEswig.pbheSolve_f(Freeflow,float(dt),float(dx),float(dy),float(dz), Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
        else:
            if T.dtype == np.float64:
                #PBHE_CUDA.Pennes_2ndOrder_GPU64_mesh(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
                PBHE_CUDA.Pennes_2ndOrder_GPU64(T, Tdot, k3d, rhoCp3d, simPhysGrid['dtxyz'], perfTemp,perfRate,buffsize,nx,ny,nz,Freeflow)
            elif T.dtype == np.float32:
                PBHE_CUDA.Pennes_2ndOrder_GPU32(T, Tdot, k3d, rhoCp3d, simPhysGrid['dtxyz'], perfTemp,perfRate,buffsize,nx,ny,nz,Freeflow)
                #PBHE_CUDA.Pennes_2ndOrder_GPU32_mesh(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )

        Rbase[:]=4
        Rbase[np.where(T[0] > 43.0, True, False)] = 2

        #time integrate to get the thermal dose
        CEM[:] += (dt/60.0)*np.sum( Rbase**(T[0:buffsize]-43), 0  )

        #if interpolating some output, compute at interpolated points
        #Since this routine uses time from dt*(0:Nt-1) instead of an absolute time,
        if numInterp>0:
            ii = 0
            while( kk < numInterp and ii < buffsize  ):
                ta=time + ii*dt + interpoffset
                tb=ta+dt
                tk = interpTimes[kk]
                if tk < ta:
                    kk+=1
                    continue
                if tk > tb:
                    ii+=1
                    continue



                #if the interpolation point is in the interior of the input time series
                if ii < buffsize-1:
                    u = (tk - ta)/(tb-ta)

                    if interpMode:

                        if interpMode == 2:
                            interpolatedTemp[kk] = T[ii][interpmask]*(1-u) + T[ii+1][interpmask]*(u)
                        elif interpMode == 4:
                            interpFunc.idx=kk
                            interpolatedTemp[kk] = interpFunc( T[ii]*(1-u) + T[ii+1]*(u) )
                        elif interpMode == 6:
                            interpFunc.idx=kk
                            interpolatedTemp[kk] = interpFunc( T[ii][interpmask]*(1-u) + T[ii+1][interpmask]*(u) )


                    else:
                        interpolatedTemp[kk] = T[ii]*(1-u) + T[ii+1]*(u)

                #if the interpolation point is equal to the final input time
                elif ii==buffsize-1:
                    if interpMode:
                        if interpMode == 2:
                            interpolatedTemp[kk] = T[ii][interpmask]
                        elif interpMode == 4:
                            interpFunc.idx=kk
                            interpolatedTemp[kk] = interpFunc( T[ii] )
                        elif interpMode == 6:
                            interpFunc.idx=kk
                            interpolatedTemp[kk] = interpFunc( T[ii][interpmask] )
                    else:
                        interpolatedTemp[kk] = T[ii]

                    #print("kk = %d, ii = %d, tk = %f, ta = %f, Tn[kk] = %f (break)" %(kk,ii,tk,ta, interpolatedTemp[kk]))
                    break

                #print("kk = %d, ii = %d, tk = %f, ta = %f, Tn[kk] = %f" %(kk,ii,tk,ta, interpolatedTemp[kk]))

                kk+=1


        if record_temporal:
            timeList.append(time+tstep)
            if Tavg:
                TavgList.append(np.mean( T[buffsize-1][voxmask], axis=(1,2,3) ))




        ti+=1
        time+=tstep
        T[0] = T[buffsize-1]

        #print ("2 %f, %f" % (np.max(T), np.max(Tdot)), end=' ok \n')

    if Tmax is not None:
        update = np.where(T[buffsize-1] > Tmax, True, False)
        Tmax[update] = T[buffsize-1][update]

    return (time, Tmax, timeList, TavgList)






def load_sim_hdf5(filename):

    f = h5py.File(filename)

    dset= f['/CEM']

    simdata = {}

    simdata['CEM'] = dset.value

    attrs = ['times', 'Ispta_W_m2', 'dwelltime_sec', 'd_m', 'restxyz',
             'ROIAvgCEM', 'NonROIAvgCEM', 'xp', 'yp', 'zp', 'focplaneZpix',
             'roiVolume', 'cem240VolROI', 'cem240VolNonROI']

    for atr in attrs:
        simdata[atr] = dset.attrs.get(atr, default=None)

    dset2 = f.get('positions', default=None)

    if dset2 is not None:
        attrs = ['dwellTimes', 'focalTemplate']
        simdata['positions'] = dset2.value
        for atr in attrs:
            simdata[atr] = dset2.attrs.get(atr, default=None)

    f.close()

    return( simdata )


def plot_sim_std(CEMthis, timeList, cemROIavg, cemNonROIavg, cem240VolROI, cem240VolNonROI,
                fig=None, xp=None, yp=None,zp=None, ypidx=None, zpidx=None, roiVolume=None,
                CEMmin=0,CEMmax=240.0):

    if fig is None:
        fig=plt.figure(figsize=(10,7), dpi=72)

    (Nx,Ny,Nz)=CEMthis.shape

    if xp is None:
        xp = 1e-2*np.linspace(-2,2,Nx)
    if yp is None:
        yp = 1e-2*np.linspace(-2,2,Ny)
    if zp is None:
        zp = 1e-2*np.linspace(7,18,Nz)

    if ypidx is None:
        ypidx=math.floor(Ny/2)

    if zpidx is None:
        zplane=0.14
        zpidx=np.where(np.logical_and( (zp[1:-1]-zplane>0) , (zp[0:-2]-zplane<0) ))[0][0]
    if roiVolume is None:
        roiVolume = 0.02**3

    imageBounds = [ xp[0]*100, xp[-1]*100, yp[0]*100, yp[-1]*100 ]
    vertImageBounds = [ xp[0]*100, xp[-1]*100, zp[0]*100, zp[-1]*100 ]

    ax = fig.add_subplot(221)
    #plt.imshow( T[nnt-1,:,:,floor(Nz/2)] )
    ax.imshow( np.transpose(CEMthis[:,:,zpidx]), cmap=image.cm.hot, vmin=CEMmin, vmax=CEMmax, extent=imageBounds, origin='lower' )

    ax.plot( [-1,-1,1,1,-1], [-1,1,1,-1,-1], 'b--')

    ax = fig.add_subplot(222)
    #plt.imshow( np.transpose(CEMthis[:,:,focplaneZpix-3]), cmap=image.cm.hot, vmin=0, vmax=240.0, extent=imageBounds, origin='lower' )
    ax.plot(timeList, cemROIavg,'r')
    ax.plot(timeList, cemNonROIavg,'k')
    ax.set_xlabel('Time [s]')
    ax.set_ylabel('Volume-avg CEM')

    ax = fig.add_subplot(223)
    im=ax.imshow( np.transpose(CEMthis[:,ypidx,:]), cmap=image.cm.hot, vmin=CEMmin, vmax=CEMmax, extent=vertImageBounds, origin='lower' )
    #plt.colorbar(orientation='horizontal')
    clbar=plt.colorbar(mappable=im, ax=ax, orientation='horizontal')

    if cem240VolROI is not None:
        ax = fig.add_subplot(224)
        ax.plot(timeList, cem240VolROI,'r')
        ax.plot(timeList, cem240VolNonROI,'k')
        if roiVolume is not None:
            ax.plot(timeList[[1,-1]], [roiVolume*1e6, roiVolume*1e6], 'b--')
        ax.set_xlabel('Time [s]')
        ax.set_ylabel('Volume at CEM >=240 [mL]')


def plot_simdata_std(simdata, fig=None, ypidx=None, CEMmin=0, CEMmax=240.0):


    if simdata['times'] is None:
        return

    plot_sim_std(simdata['CEM'], simdata['times'], simdata['ROIAvgCEM'], simdata['NonROIAvgCEM'],
                 simdata['cem240VolROI'], simdata['cem240VolNonROI'],
                 xp=simdata['xp'], yp=simdata['yp'], zp=simdata['zp'],
                 ypidx=ypidx, zpidx=simdata['focplaneZpix'], roiVolume=simdata['roiVolume'],
                 CEMmin=CEMmin, CEMmax=CEMmax,
                 fig=fig)



def plot_simfile_std(fname, fig=None, ypidx=None, CEMmin=0, CEMmax=240.0):

    simdata = load_sim_hdf5(fname)

    if simdata['times'] is None:
        return

    plot_simdata_std( simdata, fig=fig, ypidx=ypidx, CEMmin=CEMmin, CEMmax=CEMmax )

    del simdata









def write_xyz_simulation_coords(f, gxp=None,gyp=None,gzp=None,xrp=None,yrp=None,zrp=None, roiON=None, roiOFF=None, roiEXTRA=None):

    if gxp is not None:
        dset = f.create_dataset("geom/gridx", data=gxp)
        if xrp is not None:
            dset.attrs['xp']=xrp
        f.flush()

    if gyp is not None:
        dset = f.create_dataset("geom/gridy", data=gyp)
        if yrp is not None:
            dset.attrs['yp']=yrp
        f.flush()

    if gzp is not None:
        dset = f.create_dataset("geom/gridz", data=gzp)
        if zrp is not None:
            dset.attrs['zp']=zrp
        f.flush()

    if roiON is not None:
        dset = f.create_dataset("geom/ROION", data=roiON)
        f.flush()

    if roiOFF is not None:
        dset = f.create_dataset("geom/ROIOFF", data=roiOFF)
        f.flush()

    if roiEXTRA is not None:
        dset = f.create_dataset("geom/ROIEXTRA", data=roiEXTRA)
        f.flush()

    return f

def write_parameter_space(f, sim_result, SetOfParamArrays, NamesOfParams, units=None, scoringfunc=None):
    """
    Write the parameter space definition for the param_grid.
     * SetOfParamArrays is a list or array of vectors representing the sampled across each dimension.
     * NamesOfParams is a list of strings with the name of each parameter
     * 'units=' is an optional keyword containing the parameter unit definition
    E.g.,
    p0 = np.arange(0.2, 0.3, 0.05 ) #speed
    p1 = np.arange(3.0, 9.0, 1.0 )  #dwell
    p2 = np.arange(2.0, 6.0, 1.0 )  #wait
    ...
    paramvecs = [ p0, p1, p2, ...]
    names = ["speed", "dwell", "wait"]
    units = ["mm/sec","sec","sec"]

    write_parameter_space(f, results_ndgrid, paramvecs, names, units=units)

    """

    Ndims = len(sim_result.shape)

    if Ndims >0:
        dset = f.create_dataset("param_grid",data=sim_result)
        f.flush()
    else:
        return

    if type(SetOfParamArrays) == list:
        tupleOfParams = tuple(SetOfParamArrays)
    elif type(SetOfParamArrays) == np.ndarray:
        tupleOfParams = tuple(SetOfParamArrays.tolist())
    elif type(SetOfParamArrays) == tuple:
        tupleOfParams = SetOfParamArrays

    #param_grid = np.meshgrid( *tupleOfParams , indexing='ij')

    param_dims = list(map( lambda *arg: len(*arg) , tupleOfParams))

    dset.attrs['Ndims']=Ndims
    dset.attrs['dims']=param_dims

    if scoringfunc is not None:
        dset.attrs['scoringfunc']=scoringfunc

    for n in range(0,Ndims):
        pname = "p%d" % n
        dset.attrs[pname]=SetOfParamArrays[n]

        dset.attrs[("%sname" % pname)]=NamesOfParams[n]
        if units is not None:
            dset.attrs[("%sunit" % pname)]=units[n]

        f.flush()

    return f


def read_parameter_space(f,dset=None):
    """
    Return a list of arrays containing the parameter space points.
    This can be used to construct a mesh-style grid like

    setOfParamArrays = read_parameter_space(f)
    param_grid = np.meshgrid( *tuple(setOfParamArrays) , indexing='ij')

    Paramter names should be stored in dset.attrs['..']

    """
    if dset is None:
        dset = f['param_grid']

    Ndims = len(SetOfParamArrays)

    Ndims = dset.attrs['Ndims']

    SetOfParamArrays=[]
    for n in range(0,Ndims):
        pname = "p%d" % n
        SetOfParamArrays.append(dset.attrs[pname])

    return SetOfParamArrays
