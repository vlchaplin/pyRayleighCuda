#!/usr/bin/env python3

import geom
from math import floor,pi,sin,cos,asin
import numpy

def get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals):
    
    M = len(focalPvals)
    N = len(xyzVecs)
    
    H = 1j*numpy.zeros( [M,N] )
    
    for m in range(0,M):
        
        Rmnvec = numpy.array(list(map( lambda x: numpy.sqrt(sum( x**2 )),  xyzVecs - focalPoints[m] ) ))
        
        H[m] = 1j*numpy.exp(-1j*kwavenum*Rmnvec ) / Rmnvec
        
   
    Hadj=numpy.conjugate( H.transpose() ) 
    HHa_inv=numpy.linalg.pinv(H.dot(Hadj))
    
    uopt = (Hadj).dot(HHa_inv).dot(focalPvals)
    
    return uopt


def new_stipled_spherecap_array(sphereRadius, capDiam, nn):

    
    nr=0
    nk=0
    nb=0
    while(nk < nn):
        nr+=1
        nb=nk
        nk = sum( map( lambda j: floor((2*pi)*j), range(0,nr) ) ) + nr
        

    nn=nb    
    maxtheta = asin( (capDiam/2.0)/sphereRadius )
    dth = maxtheta / (nr-1)
    nphi = list(map(lambda x:1+floor( x*2*pi), range(0,nr))) 
    
    nn=sum(nphi)
    
    uxyz=numpy.zeros([nn,3],dtype=numpy.float64)
    n=0
    for i in range(0,nr):
        theta=i*dth
        dphi=2*pi/nphi[i]
        for j in range(0,nphi[i]):
            phi = dphi*j
            uxyz[n,:] = sphereRadius*numpy.array( [sin(theta)*cos(phi) , sin(theta)*sin(phi), 1-cos(theta)] )
            n+=1
            
        
        
    return [uxyz  , nn]



def calc_pressure_profile(kwavenum, upos, uamp, vecs):
    
    nv = len(vecs)
    
    P = 1j*numpy.zeros([nv]);
    
    #gx,gy,gz = numpy.meshgrid(xarray, yarray, zarray, sparse=False, indexing='ij')

    calcdist= lambda rr: numpy.sqrt((vecs[:,0]-rr[0])**2 + (vecs[:,1]-rr[1])**2 + (vecs[:,2]-rr[2])**2)

    N = len(uamp)
    for n in range(0,N):
        Rn = calcdist(upos[n])
        P += uamp[n]*1j*numpy.exp(-1j*kwavenum*Rn ) / Rn
        
   
    return P

# upos is an Nx3 numpy array of transducer positions
# uamp is a N-length 1d array of amplitudes


def calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray):
    
    nx = len(xarray)
    ny = len(yarray)
    nz = len(zarray)
    
    P = 1j*numpy.zeros([nx,ny,nz]);
    
    gx,gy,gz = numpy.meshgrid(xarray, yarray, zarray, sparse=False, indexing='ij')

    calcdist= lambda rr: numpy.sqrt((gx-rr[0])**2 + (gy-rr[1])**2 + (gz-rr[2])**2)

    N = len(uamp)
    for n in range(0,N):
        Rn = calcdist(upos[n])
        
        P += uamp[n]*1j*numpy.exp(-1j*kwavenum*Rn ) / Rn
        
           
    return P