# -*- coding: utf-8 -*-
"""
Created on Sat Jun 25 13:41:55 2016

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

import matplotlib.transforms as mpl_trans

import scipy.interpolate as snt
import scipy.ndimage.filters as sflt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.ticker import LinearLocator, FormatStrFormatter

import nibabel
import pandas 


np.set_printoptions(precision=4, suppress=True, threshold=1300)

plt.rc('font', family='sans-serif', size=20)


#%%

#load the csv file containing multi-vs-single tests
groupingFile = "/Users/Vandiver/Data/sonalleve/Single_Vs_Multi_scans.csv"

groupingFile = "/Users/Vandiver/Data/Verasonics/sonalleve_20160709/scangroup_multi_2.csv"


gtable = pandas.read_csv(groupingFile)
#%%

dbfile = "/Users/Vandiver/Data/sonalleve/sonalleve.db"
con=sql.connect(dbfile)

#%%

Sfiles =[]
Mfiles = []

Sdata={'file':[],'avgT':[],'maxT':[],'t':[],'maxind':[]}
Mdata={'file':[],'avgT':[],'maxT':[],'t':[],'maxind':[]}

#%%
for gnum in range(0,len(gtable)):
#for gnum in [4]:

    skip=False    
    
    resS = pandas.read_sql_query("select file,path from data where date='"+gtable['date'][gnum]+"' and scan=%d"%(gtable['single'][gnum]), con )
    
    num_baselines = 1    
    
    if len(resS) == 0:
        print( "scan %d (S) from %s not found in db" %(gtable['single'][gnum], gtable['date'][gnum] ))
        skip=True
    elif len(resS) > 1:
        print("scan %d (S) from %s has multiple results, using last"%(gtable['single'][gnum], gtable['date'][gnum] ))
        resS = resS.ix[len(resS)-1]
    else:
        resS = resS.ix[0]
        
    resM = pandas.read_sql_query("select file,path from data where date='"+gtable['date'][gnum]+"' and scan=%d"%(gtable['multi'][gnum]), con )
    
    if len(resM) == 0:
        print( "scan %d (M) from %s not found in db" %(gtable['multi'][gnum], gtable['date'][gnum] ))
        skip=True
    elif len(resM) > 1:
        print("scan %d (S) from %s has multiple results, using last"%(gtable['multi'][gnum], gtable['date'][gnum] ))
        resM = resM.ix[len(resM)-1]
    else:
        resM = resM.ix[0]
        
    #continue
    if skip:
        continue
    
    file1 = resS['path']+"/"+resS['file']
    try:
        
        (tempdata1,complIm1,im1, dyntimes1)= MRDataAnalysis.read_TempScan(file1, basedynes=[1,2],
            MP_interleaved=gtable['interleave'][gnum], phase_unwrap=1, pi_val=-0.3)
    except:
        print (" *** ", resS['file'], " has slice orientation problem")
        skip=True
        pass
    
    file2 = resM['path']+"/"+resM['file']
    try:
        
        (tempdata2,complIm2,im2, dyntimes2)= MRDataAnalysis.read_TempScan(file2, basedynes=[1,2],
            MP_interleaved=gtable['interleave'][gnum], phase_unwrap=1, pi_val=-0.3)
    except:
        print (" *** ", resM['file'], " has slice orientation problem")
        skip=True
        pass
    
    if skip:
        continue
    

    
    roi1=list(con.execute("select start0,end0,start1,end1,start2,end2 from data where file='"+resS['file']+"' " ).fetchone())
    roi2=list(con.execute("select start0,end0,start1,end1,start2,end2 from data where file='"+resM['file']+"' " ).fetchone())

    roi1[0]-=2
    roi1[1]+=2
    roi2[0]-=2
    roi2[1]+=2

#    driftroi=[43,53,58,70,1,5]
#    roi1 = driftroi
#    roi2=driftroi
    T1roi = tempdata1[roi1[0]-1:roi1[1] , roi1[2]-1:roi1[3], roi1[4]-1:roi1[5], : ]
    T2roi = tempdata2[roi2[0]-1:roi2[1] , roi2[2]-1:roi2[3], roi2[4]-1:roi2[5], : ]
    
    avgT1 = np.mean(T1roi,axis=(0,1,2))    
    avgT2 = np.mean(T2roi,axis=(0,1,2))
    
    base1 = np.mean(avgT1[0:num_baselines])
    base2 = np.mean(avgT2[0:num_baselines])
    
   # avgT1 -= base1
   # avgT2 -= base2
    
    maxT1 = np.max(T1roi,axis=(0,1,2))      
    maxT2 = np.max(T2roi,axis=(0,1,2))
    
    ai1 = np.argmax(avgT1)
    ai2 = np.argmax(avgT2)
    
    ai1=-1
    ai2=-1    
    
    if ai1==0:
        ai1=-1
    if ai2==0:
        ai2=-1
        
    Sdata['avgT'].append(avgT1)
    Sdata['maxT'].append(maxT1)
    Sdata['t'].append(dyntimes1)
    Sdata['maxind'].append(ai1)
    
    Mdata['avgT'].append(avgT2)
    Mdata['maxT'].append(maxT2)
    Mdata['t'].append(dyntimes2)
    Mdata['maxind'].append(ai2)
    
    Sfiles.append(file1)
    Mfiles.append(file2)
    
    Sdata['file'].append(file1)
    Mdata['file'].append(file2)
    
    plt.plot( dyntimes1, avgT1, 'b')
    plt.plot( dyntimes2, avgT2, 'r')
    plt.plot( [dyntimes1[ai1]], [avgT1[ai1]], 'b^')
    plt.plot( [dyntimes2[ai2]], [avgT2[ai2]], 'r^')
    
    print ("success")


#%%
process=range(0,len(Sfiles))
#process=[10,11]

#avgDiffTimes = np.zeros([len(Sfiles)])
avgDiffs = np.zeros([len(process)])
avgDiffRates = np.zeros_like(avgDiffs)
amaxT1s = np.zeros_like(avgDiffs)
amaxT2s= np.zeros_like(avgDiffs)
plt.figure(figsize=(10,10))
for i in range(0,len(process)):
    di=process[i]
    tm1=Sdata['maxind'][di]
    tm2=Mdata['maxind'][di]
   
    t1=Sdata['t'][di][tm1]
    t2=Mdata['t'][di][tm2]
    
    
    amaxT1 = Sdata['avgT'][di][tm1]
    amaxT2 = Mdata['avgT'][di][tm2]
    plt.plot(Sdata['t'][di], Sdata['avgT'][di], 'b', alpha=0.5)
    plt.plot(Mdata['t'][di], Mdata['avgT'][di], 'r', alpha=0.5)
    plt.plot(Sdata['t'][di][tm1], Sdata['avgT'][di][tm1], 'b^', alpha=0.3)
    plt.plot(Mdata['t'][di][tm2], Mdata['avgT'][di][tm2], 'r^', alpha=0.3)
    if amaxT2 > amaxT1:
        plt.plot([t1,t2],[amaxT1,amaxT2], '-r'  )
    else:
        plt.plot([t1,t2],[amaxT1,amaxT2], '-b'  )
    plt.xlabel('sec')
    plt.ylabel('$\Delta$T ($^o$C)')

    avgDiffs[i] =  Mdata['avgT'][di][tm2] - Sdata['avgT'][di][tm1]
    avgDiffRates[i] =  Mdata['avgT'][di][tm2]/t2 - Sdata['avgT'][di][tm1]/t1
    amaxT1s[i]=amaxT1
    amaxT2s[i]=amaxT2
    #avgDiffTimes

#%%
#plt.plot(amaxT1s, avgDiffs, 'o')
plt.figure()
plt.hist(avgDiffs,bins=10)
plt.xlabel(u'M-S ($^o$C)')
plt.ylabel('N')

plt.figure()
plt.hist(avgDiffRates,bins=10)
plt.xlabel(u'M-S ($^o$C)')
plt.ylabel('N')


#%%
#file="/Users/Vandiver/Data/sonalleve/S_M_query_list.txt";

#with open(file,mode='w') as out:
#    for i in range(0,len(Sfiles)):
#        out.write(Sfiles[i]+"\n")
#        out.write(Mfiles[i]+"\n")
