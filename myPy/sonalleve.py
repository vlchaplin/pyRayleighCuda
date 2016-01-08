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
    
    
def get_sonalleve_xdc_vecs(file=None):

    flatlist = read_sonalleve_xml(file)
    
    numell = len(flatlist)/3
    
    v = numpy.reshape( numpy.array( flatlist ), (numell,3) )
    
    R = geom.getRotZYZarray(0,-math.pi/2.0,0)
    
    return v.dot(R)

def get_sonalleve_xdc_normals(file=None):

    uxyz = get_sonalleve_xdc_vecs(file=file)
    unvecs = numpy.apply_along_axis(lambda x: x / numpy.sqrt(numpy.sum(x**2)), 1, [0.0,0.0,0.14] - uxyz )
    return unvecs


def get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals):
    
    return transducers.get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals)
    


def calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray):
    """
    upos is an Nx3 numpy array of transducer positions
    uamp is a N-length 1d array of amplitudes
    """
    return transducers.calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray)




