#!/usr/bin/env python3

import numpy as np;
import matplotlib.image as image
import matplotlib.pyplot as plt
import pylab
import math
import h5py
import sys

sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\BioHeatCpp\\PBHEswig\\x64')
import PBHEswig

sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\CUDA\\RSgpu\\Release')
import PBHE_CUDA

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

def calc_heating(simPhysGrid,T,Tdot,Tmesh,Tdotmesh,kmesh,rhoCpmesh, duration, CEM, Rbase, Ntbuff=None, perfRate=0.0, perfTemp=37.0, T0=None, CEMinit=None, Tmax=None, Freeflow=0, verbose=False, GPU=False):
    
    """
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
        
    return is (time, Tmax), where 'time' is the actual duration of that was calculated
    """
    

    #T = simPhysGrid['T']
    #Tdot = simPhysGrid['Tdot']
    #Tmesh = simPhysGrid['Tmesh']
    #Tdotmesh= simPhysGrid['Tdotmesh']
    #kmesh= simPhysGrid['kmesh']
    #rhoCpmesh = simPhysGrid['rhoCpmesh']
    
    (dt,dx,dy,dz) = simPhysGrid['dtxyz']
    
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
        buffsize=10
    else:
        buffsize=Ntbuff
        
    tstep=dt*buffsize
    
    
    while time<duration :
        #print("here 2", flush=True)
        if verbose:
            print( '%d%%' % (time/duration *100.0), end='\n',  flush=True)
        
        if (time + tstep > duration):
            buffsize = math.ceil((duration-time)/dt)
            tstep = dt*buffsize
            
        #print (buffsize, T.shape[0], flush=True)
        
        #PBHE_CUDA.Pennes_2ndOrder_GPU64_mesh(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
        
        if not GPU:
            PBHEswig.pbheSolve(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
        else:
            if T.dtype == np.float64:
                PBHE_CUDA.Pennes_2ndOrder_GPU64_mesh(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
            elif T.dtype == np.float32:
                PBHE_CUDA.Pennes_2ndOrder_GPU32_mesh(Freeflow,dt,dx,dy,dz, Tmesh, Tdotmesh, kmesh, rhoCpmesh, perfTemp, perfRate,0,buffsize-1 )
            
        Rbase[:]=4
        Rbase[np.where(T[0] > 43.0, True, False)] = 2
        #print(T.shape)
        #print ("1 %f, %f" % (np.max(T), np.max(Tdot)), end=' ok \n', flush=True)
        #update = np.where(T[buffsize-1] > Tmax, True, False)
        #Tmax[update] = T[buffsize-1][update]

        #time integrate to get the thermal dose
        CEM[:] += (dt/60.0)*np.sum( Rbase**(T[0:buffsize]-43), 0  )
        
        #print("here 3", flush=True)
        
        ti+=1
        time+=tstep
        T[0] = T[buffsize-1]
        
        #print ("2 %f, %f" % (np.max(T), np.max(Tdot)), end=' ok \n')
    
    if Tmax is not None:
        update = np.where(T[buffsize-1] > Tmax, True, False)
        Tmax[update] = T[buffsize-1][update]
        
    return (time, Tmax)






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
    