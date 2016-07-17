# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 17:24:56 2016

@author: vlchaplin@gmail.com
"""

import sys
import sqlite3 as sql
import importlib

from math import *;
from os.path import basename;

sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\myPy')  
sys.path.append('C:\\Users\\vchaplin\\Documents\\HiFU\\code\\AblationSims')
sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\BioHeatCpp\\PBHEswig\\x64')

import numpy as np
import geom
import matplotlib.image as image
import matplotlib.pyplot as plt
import importlib
import sonalleve 
import transducers

import MRDataAnalysis
#from matplotlib.mlab import griddata

import matplotlib as mpl
import matplotlib.transforms as mpl_trans

import scipy.interpolate as snt
import scipy.ndimage.filters as sflt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.ticker import LinearLocator, FormatStrFormatter

import nibabel
import pandas 

try:
    sys.ps1
    interactive=True
except AttributeError:
    interactive=False

np.set_printoptions(precision=4, suppress=True, threshold=1300)

plt.rc('font', family='sans-serif', size=20)


dbfile = "/Users/Vandiver/Data/sonalleve/sonalleve.db"
con=sql.connect(dbfile)

do_plot=True

#%%

Sfiles =[]
Sdata={'avgT':[],'finalT':[],'maxT':[],'t':[],'fi':[]}

MetaData={'file':[],'scan':[],'date':[],'roi':[],'fi':[],'unwrapped':[]}
qrySet = pandas.read_sql_query("select file,path,interleave,scan,date from data where date='2016-07-09'", con )

#qrySet = qrySet[0:2]
interactive=False
baselinedynamics=[0,1,2]
unwrap=1
for fi in range(len(qrySet)):
    file1 = qrySet['path'][fi]+"/"+qrySet['file'][fi]
    print(file1)
    (tempdata1,complIm1,im1, dyntimes1)= MRDataAnalysis.read_TempScan(file1, basedynes=baselinedynamics,
            MP_interleaved=qrySet['interleave'][fi], phase_unwrap=unwrap, pi_val=-0.3)
            
              
            
    roi1=list(con.execute("select start0,end0,start1,end1,start2,end2 from data where file='"+qrySet['file'][fi]+"' " ).fetchone())

    #roi1 = [1,2,58,70,1,5]      

    #reorder
    roi1 = np.array(roi1)[[2,3,0,1,4,5]]

    T1roi = tempdata1[roi1[0]-1:roi1[1] , roi1[2]-1:roi1[3], roi1[4]-1:roi1[5], : ]
    avgT1 = np.mean(T1roi,axis=(0,1,2))   
    maxT1 = np.max(T1roi,axis=(0,1,2))  
    
    MetaData['file'].append(qrySet['file'][fi])
    MetaData['scan'].append(qrySet['scan'][fi])
    MetaData['date'].append(qrySet['date'][fi])
    MetaData['roi'].append(roi1)
    MetaData['unwrapped'].append(unwrap)
    Sdata['avgT'].append(avgT1)
    Sdata['finalT'].append(avgT1[-1])
    Sdata['maxT'].append(maxT1)
    Sdata['t'].append(dyntimes1)
    Sdata['fi'].append(fi)
    MetaData['fi'].append(fi)
    #plt.plot(dyntimes1,maxT1)
    
    if do_plot:
        
        dyn = -1
        sl = floor( (roi1[4]-1+roi1[5])/2.0 )
        Tsl = tempdata1[:,:,sl,dyn]
        
        magImg = MRDataAnalysis.rescale( np.abs(complIm1[:,:,sl,0]) )
        greyPix = Tsl < 1.0
        cmin=0.0
        cmax=30.0
        rgbIm = image.cm.hot( MRDataAnalysis.rescale(Tsl,vmin=cmin,vmax=cmax) )
        
        rgbIm[greyPix,3]=0
        #rgbIm[roi1[0]-1:roi1[1] , roi1[2]-1:roi1[3], 0:3]=0
        
        (nM,nP) = Tsl.shape
        (d0,d1,d2,junk) = im1.get_header().get_zooms()
        extent = [0,d1*nP,d0*nM,0 ]
        
        fig=plt.figure(figsize=(6,8))
        ax=fig.gca()        
        
        if not interactive:
            
            datafile_basename=os.path.basename(file1)
            print('')
            print('Making figure for: %s'% datafile_basename)    
    
            path=os.path.dirname(os.path.abspath(file1)) 
            
            path="/Users/Vandiver/Data/Verasonics/sonalleve_20160709/scan_plots/"           
            
            (dataname,junk) = datafile_basename.split(".")         
            
            figName = path+"/"+dataname+".png"
            
            print("Writing: ", figName,flush=True)
            plt.ioff()
            
    
        ax.imshow(magImg, cmap=image.cm.gray, vmin=0.0, vmax=0.95,  extent=extent, interpolation='none')
        im=ax.imshow(rgbIm, interpolation='none', extent=extent)        
        
        ax.set_xlabel('cm',fontsize=14)
        ax.set_ylabel('cm',fontsize=14)
        ax.tick_params(labelsize=14)      
        
        roix = np.array([ roi1[2]-1, roi1[2]-1, roi1[3], roi1[3], roi1[2]-1 ])
        roiy = np.array([ roi1[0]-1, roi1[1], roi1[1], roi1[0]-1, roi1[0]-1 ])
        plt.plot( d1*roix, d0*roiy, color=(0.7,0.6,1.0),linewidth=2.0)
        
        sc=mpl.cm.ScalarMappable(cmap=image.cm.hot)
        sc.set_array(rgbIm)
        cb=plt.colorbar(mappable=sc)
        #cb.set_cmap(image.cm.hot)
        tickp = np.arange(0,1.01,1/6)
        tickstr = list(map(lambda s:"%0.f" % s,tickp*(cmax-cmin) + cmin))
        cb.set_ticks(tickp)
        cb.set_ticklabels(tickstr)    
        #plt.draw()
        
        if not interactive:
            fig.savefig(figName)    
            plt.close(fig)
    
    
    
#%%
outpath='/Users/Vandiver/Data/Verasonics\sonalleve_20160709'

df=pandas.DataFrame(Sdata)
dm=pandas.DataFrame(MetaData)

combined=dm.merge(df)

combined.to_csv(outpath+'/scans_batch_DT_unwr2.csv')
#dm.to_csv(outpath+'/scans_batch_DT.csv')
