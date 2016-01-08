#!/usr/bin/env python

import numpy as np;

from math import *;

#######
# Function: get1DshiftFilter
#   Returns a matrix describing a shift operation on a 1-D function
#   that is discretely represented as an array. The should be used like g = M*f,
#   where f is the original function, M is the matrix returned from here, and g is the rebinned function.
#   Re-binning assumes the new bins are equal to or larger than the original bins. 

def get1DshiftFilter(originalEdges, newEdges):
    
    nn = len(originalEdges)-1
    
    M = np.zeros([nn,nn])
    
    dx1 = originalEdges[1] - originalEdges[0]
    
    for iprime in range(0,nn):
    
        x2c = newEdges[iprime];
        x2d = newEdges[iprime+1];
        
        i_c = floor((x2c - originalEdges[0])/dx1)
        i_d = i_c+1
        
        if (i_c >= 0 and i_c < nn) :
            xa = originalEdges[i_c];
            fiprime_c = 1.0 - (x2c-xa)/(dx1);
            M[iprime, i_c] = fiprime_c;
            
        if (i_d >= 0 and i_d < nn) :
            xb = originalEdges[i_d];
            fiprime_d = (x2d-xb)/(dx1);
            M[iprime, i_d] = fiprime_d;
        
    return M
    

def shiftImageRegular3D(originalIm, edgeX, edgeY, edgeZ, shift ):
    
   # Nx = len(edgeX)-1 
   # Ny = len(edgeY)-1
   # Nz = len(edgeZ)-1
    
    m11 = get1DshiftFilter(edgeX, edgeX+shift[0])
    m22 = get1DshiftFilter(edgeY, edgeY+shift[1])
    m33 = get1DshiftFilter(edgeZ, edgeZ+shift[2])
    
    #Im3 = np.tensordot(m33, val, axes=([1],[2]))
    #Im3 = np.tensordot(m22, Im3, axes=([1],[2]))
    #Im3 = np.tensordot(m11, Im3, axes=([1],[2]))
    
    Im3 = np.tensordot(m11,\
            np.tensordot(m22,\
                np.tensordot(m33, originalIm, axes=([1],[2])),\
            axes=([1],[2])),\
        axes=([1],[2]))
    
    return Im3
    
    