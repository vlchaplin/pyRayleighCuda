#!/usr/bin/env python3

from countlines import countlines
import numpy
import re
import geom
import math
import transducers

def read_sonalleve_xml(file=None):
    if file is None:
        file = "C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt"
    
    fobj = open(file)
    
    lines = fobj.readlines()
    
    fobj.close()
    
    return list( map( lambda x : float(re.match('\s+<float>\s*([-+]?(\d+(\.\d*)?|\.\d+))', x).group(1)), lines[1:-1] ) )
    
    
def get_sonalleve_xdc_vecs(file=None, R=geom.getRotZYZarray(0,-math.pi/2.0,0), ret_focus=False ):

    flatlist = read_sonalleve_xml(file)
    
    numell = len(flatlist)/3
    
    v = numpy.reshape( numpy.array( flatlist ), (numell,3) )
    
    #R = geom.getRotZYZarray(0,-math.pi/2.0,0)
    

    
    if R is None:
        R = numpy.eye(3)
    
    if ret_focus:
        focusXYZ = numpy.array([0.14, 0.0, 0.0])  
        focusXYZ = focusXYZ.dot(R)
        return v.dot(R), focusXYZ
    else:
        return v.dot(R)

def get_sonalleve_xdc_normals(file=None, R=geom.getRotZYZarray(0,-math.pi/2.0,0) ):

    uxyz, focusXYZ = get_sonalleve_xdc_vecs(file=file, R=R,ret_focus=True)
    unvecs = numpy.apply_along_axis(lambda x: x / numpy.sqrt(numpy.sum(x**2)), 1, focusXYZ - uxyz )
    return unvecs


def get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals):
    
    return transducers.get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals)
    


def calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray):
    """
    upos is an Nx3 numpy array of transducer positions
    uamp is a N-length 1d array of amplitudes
    """
    return transducers.calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray)




