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
import matplotlib.gridspec as gridspec

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

def grnumaxis(nslc):
    sqr=np.sqrt(nslc)
    if np.abs(np.mod( sqr, 1.0))<1e-16:
        #is perfect square
        nnc=int(sqr)
    else:
        nnc=floor(sqr)+1
    
    nnr = ceil(nslc/nnc)

    return (nnr,nnc)


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
interactive=True
#%%

Sfiles =[]
Sdata={'avgT':[],'finalT':[],'maxT':[],'t':[],'fi':[],'n5':[],'n10':[],'n15':[],'maxTdata':[],'momR':[],'momX':[],'momY':[],'momZ':[]}

MetaData={'file':[],'scan':[],'date':[],'roi':[],'baselineDyns':[],'fi':[],'unwrapped':[]}
qrySet = pandas.read_sql_query("select file,path,interleave,scan,date from data where (date='x2016-07-09' or date='2016-08-10') and scan IN(29,37)  and file like '%TempSag%'", con )

#qrySet = qrySet[0:2]

baselinedynamics=[1]
unwrap=1
for fi in range(len(qrySet)):
    file1 = qrySet['path'][fi]+"/"+qrySet['file'][fi]
    print(file1)
    (tempdata1,complIm1,im1, dyntimes1)= MRDataAnalysis.read_TempScan(file1, basedynes=baselinedynamics,
            MP_interleaved=qrySet['interleave'][fi], phase_unwrap=unwrap, pi_val=-0.3)
            
              
            
    roi1=list(con.execute("select start0,end0,start1,end1,start2,end2 from data where file='"+qrySet['file'][fi]+"' " ).fetchone())

    #roi1 = [1,2,58,70,1,5]      

    #roi1[0]-=1
    #roi1[1]+=1
    #roi1[2]-=1
    #roi1[3]-=1
    #roi1[4]=1
    #roi1[5]=6
    #reorder
    roi1 = np.array(roi1)[[2,3,0,1,4,5]]
    #roi1 += [1,1,1,1,0,0]
    roi1 += [0,1,0,1,0,1]
    T1roi = tempdata1[roi1[0]-1:roi1[1] , roi1[2]-1:roi1[3], roi1[4]-1:roi1[5], : ]
    avgT1 = np.mean(T1roi,axis=(0,1,2))   
    maxT1 = np.max(T1roi,axis=(0,1,2))  
    
    temporalMax=np.max(T1roi,axis=3)    
    
    #print(avgT1)    
    
    (d0,d1,d2,junk) = im1.get_header().get_zooms()
    (sz0,sz1,sz2)=temporalMax.shape
    (gx,gy,gz)=np.meshgrid( np.arange(sz0)*d0, np.arange(sz1)*d1, np.arange(sz2)*d2, indexing='ij' )

    sumT=np.sum(temporalMax)
    (cent0, cent1, cent2) = [np.sum( gx*temporalMax )/sumT, np.sum( gy*temporalMax )/sumT, np.sum( gz*temporalMax )/sumT]
    
    TwCentralMoment1 = np.sum( np.sqrt((gx-cent0)**2 + (gy-cent1)**2 + (gz-cent2)**2)*temporalMax ) /sumT
    
    TwXMoment1 = np.sum( np.abs(gx-cent0)*temporalMax ) /sumT
    TwYMoment1 = np.sum( np.abs(gy-cent1)*temporalMax ) /sumT
    TwZMoment1 = np.sum( np.abs(gz-cent2)*temporalMax ) /sumT

    n5=np.sum(temporalMax>5)
    n10=np.sum(temporalMax>10)
    n15=np.sum(temporalMax>15)
    
    MetaData['file'].append(qrySet['file'][fi])
    MetaData['scan'].append(qrySet['scan'][fi])
    MetaData['date'].append(qrySet['date'][fi])
    MetaData['roi'].append(roi1)
    MetaData['unwrapped'].append(unwrap)
    MetaData['baselineDyns'].append(baselinedynamics)
    Sdata['avgT'].append(avgT1)
    Sdata['finalT'].append(avgT1[-1])
    Sdata['maxT'].append(maxT1)
    Sdata['t'].append(dyntimes1)
    Sdata['fi'].append(fi)
    Sdata['momR'].append(TwCentralMoment1)
    Sdata['momX'].append(TwXMoment1)
    Sdata['momY'].append(TwYMoment1)
    Sdata['momZ'].append(TwZMoment1)
    Sdata['n5'].append(n5)
    Sdata['n10'].append(n10)
    Sdata['n15'].append(n15)
    Sdata['maxTdata'].append(temporalMax.flatten() )
    MetaData['fi'].append(fi)
    #plt.plot(dyntimes1,maxT1)
    
    if do_plot:
        nslc =T1roi.shape[2]
        (nnr,nnc)=grnumaxis(nslc)
        gsPow=gridspec.GridSpec(nnr,nnc,wspace=0.05,hspace=0.25)

        (d0,d1,d2,junk) = im1.get_header().get_zooms()
        
        dyn = -2
        #sl = floor( (roi1[4]-1+roi1[5])/2.0 )
        fig=plt.figure(figsize=(10,10))
        for sli in range(0,nslc):
            
            j_ax = np.mod(sli,nnc)
            i_ax = floor(sli/nnc)
            ax=fig.add_subplot(gsPow[i_ax,j_ax])
            
            sl = roi1[4]-1+sli
            Tsl = tempdata1[:,:,sl,dyn]
            
            magImg = MRDataAnalysis.rescale( np.abs(complIm1[:,:,sl,0]) )
            greyPix = Tsl < 0.0
            cmin=0.0
            cmax=20.0
            rgbIm = image.cm.hot( MRDataAnalysis.rescale(Tsl,vmin=cmin,vmax=cmax) )
            
            rgbIm[greyPix,3]=0
            #rgbIm[roi1[0]-1:roi1[1] , roi1[2]-1:roi1[3], 0:3]=0
            
            (nM,nP) = Tsl.shape
            extent = [0,d1*nP,d0*nM,0 ]
            
            
            #fig=plt.figure(figsize=(9,9))
                  
            
            if not interactive:
                
                datafile_basename=os.path.basename(file1)
                print('')
                print('Making figure for: %s'% datafile_basename)    
        
                path=os.path.dirname(os.path.abspath(file1)) 
                
                #path="/Users/Vandiver/Data/sonalleve/HifuCav20160810/scan_plots/"           
                #path="/Users/Vandiver/Data/Verasonics/sonalleve_20160709/scan_plots/"
                
                path=path+"/scan_plots/"            
                
                (dataname,junk) = datafile_basename.split(".")         
                
                figName = path+"/"+dataname+".png"
                
                print("Writing: ", figName,flush=True)
                plt.ioff()
        
            
            
            
            ax.imshow(magImg, cmap=image.cm.gray, vmin=0.0, vmax=0.95,  extent=extent, interpolation='none')
            im=ax.imshow(rgbIm, interpolation='none', extent=extent)        
            
            ax.set_xlabel('cm',fontsize=14)
            ax.set_ylabel('cm',fontsize=14)
            ax.tick_params(labelsize=14)      
            
            if j_ax>0:
                ax.yaxis.set_ticks([])
            
            roix = np.array([ roi1[2]-1, roi1[2]-1, roi1[3], roi1[3], roi1[2]-1 ])
            roiy = np.array([ roi1[0]-1, roi1[1], roi1[1], roi1[0]-1, roi1[0]-1 ])
            plt.plot( d1*roix, d0*roiy, color=(0.7,0.6,1.0),linewidth=2.0)
            
            xw=d1*abs(roix[2]-roix[0])
            yw=d0*abs(roiy[1]-roiy[0])
            
            ax.set_xlim([-xw,2*xw]+d1*roix[0])
            ax.set_ylim([-yw,2*yw]+d0*roiy[0])
            ax.text(0.9,0.9,'si %d'%sl, transform=ax.transAxes, horizontalalignment='right', fontsize=16,color='w',fontweight='bold')
            
            
        #end stack for loop
        ax=fig.add_axes([0.9, 0.15, 0.05, 0.6])
        sc=mpl.cm.ScalarMappable(cmap=image.cm.hot)
        sc.set_array(rgbIm)
        cb=plt.colorbar(mappable=sc,orientation='vertical',cax=ax)
        #cb.set_cmap(image.cm.hot)
        tickp = np.arange(0,1.01,1/6)
        tickstr = list(map(lambda s:"%0.f" % s,tickp*(cmax-cmin) + cmin))
        cb.set_ticks(tickp)
        cb.set_ticklabels(tickstr)  
        cb.set_label('$\Delta T$ ($^o$C)')
        
        #plt.draw()
        
        if not interactive:
            fig.savefig(figName)    
            plt.close(fig)
    
    
    
#%%
    
exit    
#    
outpath='/Users/Vandiver/Data/Verasonics/MulitfocusCav'

df=pandas.DataFrame(Sdata)
dm=pandas.DataFrame(MetaData)

combined=dm.merge(df)

#combined.to_csv(outpath+'/cav_scans_batch_DT_unwr2.csv')
#dm.to_csv(outpath+'/scans_batch_DT.csv')
