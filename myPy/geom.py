#!/usr/bin/env python3

import numpy
from math import sin,cos,pi


def translate3vecs(inputVecs, delta, overwrite=False):
    """
    vectors is an Nx3 numpy array.  There are N vectors with 3 cartesion components
    delta is a 3-element array

    return is vectors + data
    """
    N=len(inputVecs)
    if overwrite:
        newvecs = inputVecs
    else:
        newvecs = numpy.zeros([N,3])
    
    for n in range(0,N):
        newvecs[n] = inputVecs[n] + delta
        
    return newvecs

def getRotZYZarray(az, ayp, azpp, translationColumn=None):
    
    if translationColumn is not None:
        R = numpy.zeros([4,4])
        R[:,3] = translationColumn
    else:
        R = numpy.zeros([3,3])
    
    c1 = cos(az)
    s1 = sin(az)
    c2 = cos(ayp)
    s2 = sin(ayp)
    c3 = cos(azpp)
    s3 = sin(azpp)
    
    R[0,:] = [ c1*c2*c3 - s1*s3 , s1*c2*c3 + c1*s3 , -s2*c3]
    R[1,:] = [-c1*c2*s3 - s1*c3 ,-s1*c2*s3 + c1*c3,   s2*s3]
    R[2,:] = [            c1*s2 ,           s1*s2 ,      c2]
    
    return R


def rot(matrix,v):
    u=numpy.array(list(map ( lambda vec: matrix.dot(vec), v)))
    return u
    
    
def equilateral_tri(d, z=0.0):
    h=d*sin(pi/3);
    return (numpy.array([[-d/2, -h/2, z], [d/2, -h/2, z], [0, h/2, z] ]), h)

def cross(d, z=0.0):
    return numpy.array([[0,0,z], [d, 0, z], [0, d, z], [-d, 0, z], [0, -d, z] ])

