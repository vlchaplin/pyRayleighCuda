#!/usr/bin/env python3

import numpy
import re;
import csv;

from math import sin,asin, cos,acos,pi,floor

def readNDI_csv(filename, nmax=None, startcol=0):
    csvfile=open(filename)
    reader=csv.reader(csvfile)
    text=list(reader)
    csvfile.close()

    if re.search( 'Tools', text[0][0]):
        text.pop(0)

    if nmax is not None:
        text = text[0:nmax]

    err = np.array( list(map( lambda x: x[startcol + 12], text )), dtype='float')
    txyz = np.array( list(map( lambda x: x[startcol + 9:startcol + 12], text )), dtype='float')
    q0xyz = np.array( list(map( lambda x: x[startcol + 5:startcol + 9], text )), dtype='float')

    return (q0xyz, txyz, err)

def mag(vec,axis=-1):
    """
    Return L2-norm of vector along the specified axis.
    """
    return numpy.sqrt(numpy.sum(vec**2,axis=axis))
    
def normalize(vec,axis=-1):
    return numpy.apply_along_axis(lambda x: x / numpy.sqrt(numpy.sum(x**2)), axis, vec.copy() )
    
def new_randomized_spherecap_array(sphereRadius, capDiam, N, elementDiam=0.0, iterations=1000):
    """
    Create a spherical cap of N sources that have randomized locations, 
    and constrained such that elements of width 'elementDiam' do not overlap.
    The resulting cap starts at the origin and opens/extends along the +z axis.

    The optional elementDiam is a number >=0. The default is to treat each source as a point source.

    """

    ucenters = numpy.zeros([N,3]);
    Dsquared =elementDiam**2;
    k=0
    annular_opening = asin(0.5*capDiam/sphereRadius );

    ThetaInterval = numpy.array([0.0, annular_opening])
    PhiInterval = numpy.array([0, 2*pi])
    
    theta_r = ThetaInterval[1]-ThetaInterval[0]
    phi_r = PhiInterval[1]-PhiInterval[0]
    iter=0
    while(k<N and iter<iterations):

        iter+=1
        #take a random point
        theta=numpy.random.ranf()*theta_r + ThetaInterval[0]
        phi=numpy.random.ranf()*phi_r + PhiInterval[0]

        uxyz = sphereRadius*numpy.array([ numpy.cos(phi)*numpy.sin(theta), numpy.sin(phi)*numpy.sin(theta), 1-numpy.cos(theta) ]);

        if k==0:
            ucenters[k] = uxyz;
            k+=1
            continue;

        #Check if the distance from the current uxyz point conflicts with any of the previously added points.
        distancesSq = numpy.sum( (uxyz - ucenters[0:(k-1)])**2, axis=-1)

        conflicts = sum(distancesSq <= Dsquared);

        if conflicts > 0:
            continue;


        #if no conflicts, add this position to the list
        ucenters[k] = uxyz;
        k=k+1;
        
    if iter==iterations:
        raise RuntimeWarning("Max iterations reached before filling array (completed %d / %d)." %(k,N))

    return ucenters

    
def new_stipled_spherecap_array(sphereRadius, capDiam, nn):


    nr=0
    nk=0
    nb=0
    while(nk < nn):
        nr+=1
        nb=nk
        nk = sum( map( lambda j: floor((2*pi)*j), range(0,nr) ) ) + nr

    nr-=1


    maxtheta = asin( (capDiam/2.0)/sphereRadius )

    if nr > 1:
        dth = maxtheta / (nr-1)
        nphi = list(map(lambda x:1+floor( x*2*pi), range(0,nr)))
    else:
        dth=0
        nphi=[1]

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
	

def write_VTK_points(filename, xyz):

    N = len(xyz)
    d = len(xyz[0])
    if d != 3:
        return 1

    f = open(filename,mode='w')
    f.write('# vtk DataFile Version 3.0\n')
    f.write('vtk output\n')
    f.write('ASCII\n')
    f.write('DATASET POLYDATA\n')
    f.write('POINTS %d ' % N)
    f.write('float\n')

    for i in range(0,N):
        for j in range(0,3):
            f.write("%.8f " % xyz[i][j] )
        f.write('\n')

    f.write('\n\n')
    f.write('VERTICES %d %d\n' % ( N,2*N) )

    for i in range(0,N):
        f.write('%d %d\n' % ( 1, i) )

    f.close()

    return 0


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

def cart2sphere(x,y,z):
    """
    (r,theta,phi) = cart2sphere(x,y,z)
    Theta is polar angle. Angles returned in radians
    """

    r = numpy.sqrt( x**2 + y**2 + z**2 )
    theta = numpy.arccos(z/r)
    phi = numpy.arctan2(y,x)

    if type(r)==numpy.ndarray:
        gimbles=numpy.abs(r) < 1e-12
        theta[gimbles]=0.0
    elif abs(r) < 1e-12:
        theta=0.0


    return (r,theta,phi)

def cart2sphere_deg(x,y,z):
    """
    (r,theta,phi) = cart2sphere_deg(x,y,z)
    Theta is polar angle. Angles returned in degrees
    """
    rtod=180.0/np.pi
    (r,theta,phi) = cart2sphere(x,y,z)
    return (r,theta*rtod,phi*rtod)

def rot(matrix,v):
    u=numpy.array(list(map ( lambda vec: matrix.dot(vec), v)))
    return u

def rotate_mesh_volume(Rotmat, mxx, myy, mzz, rotxx=None, rotyy=None, rotzz=None, translate=[0.0,0.0,0.0], squeeze=True):
    """
    Input meshgrid vertices. Returns (rotx, roty, rotz) mesh
    mxx,myy can be 3D or 2D arrays. If 2D, then mzz must be a scalar. If 3D, mzz must have the same shape.

    If squeeze=True, then when any dimension of the mesh is=1 (effectively a 2D mesh in 3D space), the resulting mesh have numpy.squeeze applied.

    e.g.,
        2D case:
        mx,my=np.meshgrid(x,y)
        z=0.0
        rx,ry,rz = rotate_mesh_volume(mx,my,z)

        3D case:
        mx,my,mz=np.meshgrid(x,y,z)
        rx,ry,rz = rotate_mesh_volume(mx,my,mz)

    translate = 3-element array or list to apply after rotation
    """
    if rotxx is None:
        rotxx = numpy.zeros_like(mxx)
    if rotyy is None:
        rotyy = numpy.zeros_like(mxx)
    if rotzz is None:
        rotzz = numpy.zeros_like(mxx)

    if not( type(mzz)==list or type(mzz)==numpy.ndarray) :
        mzz=[mzz]


    nv=len(mxx.flat)

    if mxx.ndim == 2 or (len(mzz)==1 and mxx.shape[0] != 1):

        for i in range(nv):
            rotxx.flat[i], rotyy.flat[i], rotzz.flat[i] = Rotmat.dot( [ mxx.flat[i], myy.flat[i], mzz[0] ] ) + translate

    else:
        for i in range(nv):
            rotxx.flat[i], rotyy.flat[i], rotzz.flat[i] = Rotmat.dot( [ mxx.flat[i], myy.flat[i], mzz.flat[i] ] ) + translate

    if squeeze:
        return tuple(map(numpy.squeeze, (rotxx,rotyy,rotzz) ))
    else:
        return (rotxx,rotyy,rotzz)



def ring(d,n, z=0.0, rot=0):
    """
        d - diameter
        n - number of points equi-spaced on the ring perimeter
    """
    dphi = 2.0*pi/n;
    phis = numpy.arange(0.0,2*pi,dphi) + rot
    vecs = numpy.zeros([n,3]);
    r=d/2;

    vecs[:,0] = r*numpy.cos(phis);
    vecs[:,1] = r*numpy.sin(phis);
    vecs[:,2] = z;

    return (vecs, r)

def equilateral_tri(d, z=0.0):
    h=d*sin(pi/3);
    return (numpy.array([[-d/2, -h/2, z], [d/2, -h/2, z], [0, h/2, z] ]), h)

def cross(d, z=0.0):
    return numpy.array([[0,0,z], [d, 0, z], [0, d, z], [-d, 0, z], [0, -d, z] ])


def inSphere(x,y,z,r=0.005):
    """
    Determine wether point (x,y,z) lies in the ellipsoid specified by r= and centered on the origin.
    Returns boolean
    """
    return numpy.sqrt(x**2 + y**2 + z**2)<=r

def inEllipse(x,y,z,a=0.005,b=0.005,c=0.005):
    """
    Determine wether point (x,y,z) lies in the ellipsoid specified by (a=,b=,c=) and centered on the origin.
    Returns boolean
    """
    return numpy.sqrt((x/a)**2 + (y/b)**2 + (z/c)**2)<=1.0

def inCuboid(x,y,z,xw,yw,zw):
    """
    Determine wether point (x,y,z) lies in the cuboid with sides of width xw,yw,zw and centered on the origin.
    Returns boolean
    """

    #return ( x>=-xw/2.0 and x<=xw/2.0 and y>=-yw/2.0 and y<=yw/2.0 and  z>=-zw/2.0 and z<=zw/2.0 )
    return numpy.logical_and( x>=-xw/2.0, x<=xw/2.0, numpy.logical_and( y>=-yw/2.0, y<=yw/2.0 , numpy.logical_and( z>=-zw/2.0, z<=zw/2.0 ) ) )

def inCuboidBounds(x,y,z,xr=None,yr=None,zr=None):
    """
    Determine wether point (x,y,z) lies in the cuboid with sides of width xw,yw,zw and centered on the origin.
    Returns boolean
    """

    if xr is not None:
        xsel = numpy.logical_and( x>=xr[0], x<=xr[1] )
    else:
        xsel = True

    if yr is not None:
        ysel = numpy.logical_and( y>=yr[0], y<=yr[1] )
    else:
        ysel = True

    if zr is not None:
        zsel = numpy.logical_and( z>=zr[0], z<=zr[1] )
    else:
        zsel = True

    #return ( x>=-xw/2.0 and x<=xw/2.0 and y>=-yw/2.0 and y<=yw/2.0 and  z>=-zw/2.0 and z<=zw/2.0 )
    return numpy.logical_and( xsel, numpy.logical_and(ysel , zsel) )

def roiGen(focalPattern, isContainedFunc, gxp, gyp, gzp):
    """
    focalPattern is an (m x 3) array
    """
    nf = len(focalPattern)
    mask=numpy.zeros_like(gxp,dtype=bool)
    for i in range(0,nf):
        mask= numpy.logical_or( mask, isContainedFunc(gxp - focalPattern[i][0], gyp - focalPattern[i][1], gzp - focalPattern[i][2]) )
    return mask
