import geom
from math import floor,pi,sin,cos,asin,sqrt
import numpy as np

#CUDA-enabled library
import sys

try:
    sys.path.append('C:\\Users\\Vandiver\\Documents\\HiFU\\code\\CUDA\\RSgpu\\Release')
    import RSgpuPySwig
except ImportError:
    print('RSgpuPySwig module not loaded, so _cuda functions are not available.')

def get_focused_element_vals(kwavenum, xyzVecs, focalPoints, focalPvals, L1renorm=None, L2renorm=None, AlternatePhases=False):

    M = len(focalPvals)
    N = len(xyzVecs)

    H = 1j*np.zeros( [M,N] )

    if AlternatePhases:
        focalPvals = focalPvals.copy()*np.exp(1j*np.arange(0,M)*pi)

    for m in range(0,M):

        Rmnvec = np.array(list(map( lambda x: np.sqrt(sum( x**2 )),  xyzVecs - focalPoints[m] ) ))

        H[m] = 1j*np.exp(-1j*kwavenum*Rmnvec ) / Rmnvec


    Hadj=np.conjugate( H.transpose() )
    HHa_inv=np.linalg.pinv(H.dot(Hadj))

    uopt = (Hadj).dot(HHa_inv).dot(focalPvals)

    if L1renorm is not None:
        uopt = L1renorm*uopt/np.sum(np.abs(uopt))
    elif L2renorm is not None:
        uopt = L2renorm*uopt*sqrt(1.0/np.sum(np.abs(uopt)**2))

    return uopt


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

    uxyz=np.zeros([nn,3],dtype=np.float64)
    n=0
    for i in range(0,nr):
        theta=i*dth
        dphi=2*pi/nphi[i]
        for j in range(0,nphi[i]):
            phi = dphi*j
            uxyz[n,:] = sphereRadius*np.array( [sin(theta)*cos(phi) , sin(theta)*sin(phi), 1-cos(theta)] )
            n+=1



    return [uxyz  , nn]

def subsample_transducer_array( upos, diam, Nmax, unormvecs=None, ROC=None, arrays_to_grow=None ):
    """
    ( newxyz, ns, returnSet ) = subsample_transducer_array(...)

    upos is Nx3
    N = upos.shape[0]

    arrays_to_grow is a list of arrays that all have first dimension length N,
    i.e., there's a value for each input element.  This value is simply copied for the
    expanded set of output elements.

    returnSet contains the list of arrays_to_grow, but expanded.
    returnSet is [] if arrays_to_grow is empty.
    """
    N = len(upos)

    if arrays_to_grow is not None:
        Nvecs=len(arrays_to_grow)
    else:
        Nvecs=0

    if ROC is None:
        #If the transducer's ROC isn't given, then
        #this essentially makes it a flat element
        ROC=1e9*diam


    diskxyz, ns = new_stipled_spherecap_array(ROC,diam,Nmax)

    returnSet=[]
    for vec_i in range(0,Nvecs):
        Arr_i = arrays_to_grow[vec_i]
        newshape_i = list(Arr_i.shape)
        newshape_i[0] = N*ns
        newArr_i = np.zeros(tuple(newshape_i),dtype=Arr_i.dtype.type)
        returnSet.append(newArr_i)

    newxyz = np.zeros([N*ns,3])

    for n in range(0,N):

        if unormvecs is not None:
            (un_r, un_theta, un_phi) = geom.cart2sphere(*unormvecs[n,:])
            Rn = geom.getRotZYZarray( un_phi, un_theta, 0 )

            trfmDisk = diskxyz.dot(Rn) + upos[n]
        else:
            trfmDisk = diskxyz + upos[n]

        for s in range(0,ns):
            newxyz[n*ns + s] = trfmDisk[s]

            for vec_i in range(0,Nvecs):
                returnSet[vec_i][n*ns + s] = arrays_to_grow[vec_i][n]

    return ( newxyz, ns, returnSet )




def calc_pressure_profile(kwavenum, upos, uamp, vecs, unormals=None, alpha=None):

    nv = len(vecs)

    P = 1j*np.zeros([nv]);

    #gx,gy,gz = np.meshgrid(xarray, yarray, zarray, sparse=False, indexing='ij')

    calcdist= lambda rr: np.sqrt((vecs[:,0]-rr[0])**2 + (vecs[:,1]-rr[1])**2 + (vecs[:,2]-rr[2])**2)
    calcdot = lambda un: vecs[:,0]*un[0] + vecs[:,1]*un[1] + vecs[:,2]*un[2]

    if unormals is not None:
        unormals = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, unormals.copy() )

    N = len(uamp)
    cosines = 1.0
    attenuator = 1.0
    for n in range(0,N):
        Rn = calcdist(upos[n])

        if unormals is not None:
            cosines = calcdot(unormals[n])
        if alpha is not None:
            attenuator = np.exp(-alpha*Rn)
            
        P += attenuator*cosines*uamp[n]*1j*np.exp(-1j*kwavenum*Rn ) / Rn


    return P

# upos is an Nx3 np array of transducer positions
# uamp is a N-length 1d array of amplitudes


def calc_pressure_field(kwavenum, upos, uamp, xarray, yarray, zarray, unormals=None, alpha=None):
    """
    Return Rayleigh-Sommerfield calculation over the ndgrid formed from the Cartesian product space of {xarray x yarray x zarray}
    Returned field is complex, with dimensions Nx, Ny, Nz.
    """
    nx = len(xarray)
    ny = len(yarray)
    nz = len(zarray)

    P = 1j*np.zeros([nx,ny,nz]);

    gx,gy,gz = np.meshgrid(xarray, yarray, zarray, sparse=False, indexing='ij')

    calcdist= lambda rr: np.sqrt((gx-rr[0])**2 + (gy-rr[1])**2 + (gz-rr[2])**2)
    calcdot = lambda un: gx*un[0] + gy*un[1] + gz*un[2]

    if unormals is not None:
        unormals = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, unormals.copy() )

    N = len(uamp)
    cosines = 1
    attenuator=1.0
    for n in range(0,N):
        Rn = calcdist(upos[n])
        if unormals is not None:
            cosines = calcdot(unormals[n])

        if alpha is not None:
            attenuator = np.exp(-alpha*Rn)
            
        P += attenuator*cosines*uamp[n]*1j*np.exp(-1j*kwavenum*Rn ) / Rn


    return P


def calc_pressure_field_cuda(kwavenum, upos, unormals, uamp, xarray, yarray, zarray, gpublocks=0,subsampN=None, subsampDiam=None, ROC=None, alpha=0.0):
    """
    Same as calc_pressure_field() but use the CUDA-enabled version compiled in the RSgpuPySwig libary.

    Computed pressure P[i,j,k] corresponds to that at position x,y,z={xarray[i], yarray[j], zarray[k]}

    upos is [N x 3]
    unormals is [N x 3]
    Returned field is complex, with dimensions Nx, Ny, Nz.
    """

    try:
        RSgpuPySwig
    except NameError:
        print('RSgpuPySwig module not loaded, so _cuda functions are not available.')
        return

    nx = len(xarray)
    ny = len(yarray)
    nz = len(zarray)

    N = len(uamp)

    Pre = np.zeros([nx,ny,nz]);
    Pim = np.zeros([nx,ny,nz]);

    coeffs = np.ones([N])
    ure = np.real(uamp)
    uim = np.imag(uamp)

    unormals = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, unormals.copy() )

    if subsampN is not None and subsampDiam is not None:

        ( vxyz, ns, (ure,uim,unormals,coeffs) )=subsample_transducer_array(upos, subsampDiam, subsampN,
                                                                 unormvecs=unormals, ROC=ROC, arrays_to_grow=[ure,uim,unormals,coeffs])
        upos=vxyz
        coeffs/=ns

    #print( upos.shape, unormals.shape, coeffs.shape, ure.shape, uim.shape)

    RSgpuPySwig.RSgpuCalcField(kwavenum, alpha, Pre, Pim, xarray, yarray, zarray, ure, uim, coeffs, upos[:,0], upos[:,1], upos[:,2], unormals[:,0], unormals[:,1], unormals[:,2], gpublocks)

    return Pre + 1j*Pim


def calc_pressure_profile_cuda(kwavenum, upos, unormals, uamp, xvalues, yvalues, zvalues, gpublocks=0,subsampN=None, subsampDiam=None, ROC=None, alpha=0.0):
    """
    Same as calc_pressure_profile() but use the CUDA-enabled version compiled in the RSgpuPySwig libary.

    Computed pressure P[i] corresponds to that at position x,y,z={xvalues[i], yvalues[i], zvalues[i]}

    upos is [N x 3]
    unormals is [N x 3]

    xvalues, yvalues, zvalues should be same length

    Returned field is complex
    """

    try:
        RSgpuPySwig
    except NameError:
        print('RSgpuPySwig module not loaded, so _cuda functions are not available.')
        return

    nx = len(xvalues)
    ny = len(yvalues)
    nz = len(zvalues)

    N = len(uamp)

    if (nx != ny) or (nx != nz) or (ny != nz):
        return -1

    Pre = np.zeros([nx]);
    Pim = np.zeros([nx]);

    coeffs = np.ones([N])
    ure = np.real(uamp)
    uim = np.imag(uamp)

    unormals = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, unormals.copy() )

    if subsampN is not None and subsampDiam is not None:

        ( vxyz, ns, (ure,uim,unormals,coeffs) )=subsample_transducer_array(upos, subsampDiam, subsampN,
                                                                 unormvecs=unormals, ROC=ROC, arrays_to_grow=[ure,uim,unormals,coeffs])
        upos=vxyz
        coeffs/=ns

    #print( upos.shape, unormals.shape, coeffs.shape, ure.shape, uim.shape)

    RSgpuPySwig.RSgpuCalcOnPoints1D(kwavenum, alpha, Pre, Pim, xvalues, yvalues, zvalues, ure, uim, coeffs, upos[:,0], upos[:,1], upos[:,2], unormals[:,0], unormals[:,1], unormals[:,2], gpublocks)


    return Pre + 1j*Pim


def calc_pressure_mesh3D_cuda(kwavenum, upos, unormals, uamp, mxxx, myyy, mzzz, gpublocks=0,subsampN=None, subsampDiam=None, ROC=None, alpha=0.0):
    """
    Same method used in calc_pressure_profile_cuda, except input coorinates are in equally-shaped 3D arrays, similar to those returned by meshgrid.
    The returned pressure has the same shape.  Computed pressure P[i,j,k] corresponds to that at position x,y,z={mxxx[i,j,k], myyy[i,j,k], mzzz[i,j,k]}

    upos is [N x 3] array of transducer element positions
    unormals is [N x 3]  array of transducer element normal vectors

    Example: if xp,yp,zp are 1D arrays, the format of mxxx,myyy,mzzz is like

        mxxx, myyy, mzzz = np.meshgrid(xp,yp,zp, indexing='ij')
        P = calc_pressure_mesh3D_cuda(k0, u, un, mxxx,myyy,mzzz,...)

    The returned pressure has dimensions len(xp) x len(yp) x len(zp)

    The above example is equivalent to:

        P = calc_pressure_field_cuda(k0, u, un, xp, yp, zp, ...)

    The _mesh3D_ routine is useful in the possible case of non-cartesian grids, not generated
    by meshgrid.

    Returned field is complex
    """

    try:
        RSgpuPySwig
    except NameError:
        print('RSgpuPySwig module not loaded, so _cuda functions are not available.')
        return

    nx = np.product(mxxx.shape)
    ny = np.product(myyy.shape)
    nz = np.product(mzzz.shape)

    N = len(uamp)

    if (nx != ny) or (nx != nz) or (ny != nz):
        return -1

    Pre = np.zeros(mxxx.shape);
    Pim = np.zeros(mxxx.shape);

    coeffs = np.ones([N])
    ure = np.real(uamp)
    uim = np.imag(uamp)

    unormals = np.apply_along_axis(lambda x: x / np.sqrt(np.sum(x**2)), 1, unormals.copy() )

    if subsampN is not None and subsampDiam is not None:

        ( vxyz, ns, (ure,uim,unormals,coeffs) )=subsample_transducer_array(upos, subsampDiam, subsampN,
                                                                 unormvecs=unormals, ROC=ROC, arrays_to_grow=[ure,uim,unormals,coeffs])
        upos=vxyz
        coeffs/=ns

    #print( upos.shape, unormals.shape, coeffs.shape, ure.shape, uim.shape)

    RSgpuPySwig.RSgpuCalcOnPoints(kwavenum, alpha, Pre, Pim, mxxx.flatten(), myyy.flatten(), mzzz.flatten(), ure, uim, coeffs, upos[:,0], upos[:,1], upos[:,2], unormals[:,0], unormals[:,1], unormals[:,2], gpublocks)


    return Pre + 1j*Pim
