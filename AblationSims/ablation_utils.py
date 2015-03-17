#!/usr/bin/env python3

import numpy as np;
import matplotlib.image as image
import matplotlib.pyplot as plt
import pylab
import math
import h5py

import sys;


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
    