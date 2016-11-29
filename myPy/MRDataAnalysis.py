#!/usr/bin/env python

import numpy as np
import nibabel
import math
import re

def rescale(inArray,newmin=0.0,newmax=1.0,vmin=None,vmax=None,trunc=False):
    """
    Rescale input array values to the range [newmin, newmax]
    Keywords & defaults: newmin=0.0, newmin=1.0
        vmin=  The value in input array that will be mapped to newmin. Default=min(inArray)
        vmax=  The value in input array that will be mapped to newmax. Default=max(inArray)
        trunc=  If true, truncate the output range. Values less than newmin will be set to newmin. Likewise for newmax.
    """
    oldmin = np.min(inArray)
    oldmax = np.max(inArray)
    
    if vmin is None:
        vmin = oldmin
    if vmax is None:
        vmax = oldmax
        
    newim = (inArray - vmin)*(newmax - newmin) / (vmax - vmin) + newmin
    
    if trunc:
        newim[newim < newmin] = newmin
        newim[newim > newmax] = newmax
        
    return newim

def LPH_to_RAS():
    """
    return 3x3 matrix to convert LPH to RAS+ coordinates
    """
    return np.array([ [-1,0,0], [0,-1,0], [0,0,1] ])

def Tpom_from_Orientation(patient_orientation_str):
    """
        Return Tpom. Converts Magnet XYZ to Patient LPH
        e.g.,
        'Head First Supine',
        'Feet First Supine',
        'Heat First Prone',...
    """
    if re.match('Head First', patient_orientation_str, re.IGNORECASE):
        Tpp = np.array([ [0,1,0], [-1,0,0], [0,0,-1] ])
    else:
        Tpp = np.array([ [0,1,0], [-1,0,0], [0,0,-1] ])
        
    if re.match('.*Supine', patient_orientation_str, re.IGNORECASE):
        Tpo = np.array([ [1,0,0], [0,1,0], [0,0,1] ])
    elif re.match('.*Prone', patient_orientation_str, re.IGNORECASE):
        Tpo = np.array([ [-1,0,0], [0,-1,0], [0,0,1] ])
    else:
        #no need to deal with right or left decubitus
        Tpo = np.zeros([3,3])
        
    return Tpo.dot(Tpp)
    
def parse_scan_parts(imageset, num_dyns=None, num_parts=1, ordering=0):
    """
    Given an NX x NY x NS x D array of images, this routine 
    parses the ordering of the last dimension into a set of
    3D/4D image stacks, one per image part.
    
    The number of image parts (e.g., 'M','P', etc.)
    is specified by num_parts, and the number of scan dynamics by num_dyns.
    
    num_parts*num_dyns must equal the length of the last dimension, D. 
    
    If ordering==0, the last dimension will be interpreted as sorted by 
    dynamic first, then by image part:
    (dyn0, part0)
    (dyn0, part1)
    (dyn1, part0)
    (dyn1, part1)
    etc.
    
    
    If ordering!=0, the opposite ordering is assumed.
    
    Returns: a tuple of 4D image stacks of length num_parts.
    """
    
    (nx,ny,ns,D) = imageset.shape   

    if num_dyns is None:
        num_dyns = int(D/num_parts)
     
    if D!=(num_dyns*num_parts):
        raise ValueError("num_dyns*num_parts must equal length of last dimension")
    
    result_set = []
    
    for partnum in range(num_parts):
        if ordering:
            dynamics = partnum*num_dyns + np.arange(0,num_dyns,dtype=int)
        else:
            dynamics = np.arange(partnum,num_dyns*num_parts,num_parts,dtype=int)
        
        result_set.append(imageset[:,:,:, dynamics])
    
    return tuple(result_set)
    
        
def read_TempScan(parrec_file,B0_T=3.0,num_baselines=1, basedynes=None,TE_ms=16, MP_interleaved=True, phase_unwrap=None, pi_val=-1.0, diff=False ):
    """
    phase_unwrap:
            None- do nothing (default).
            1 - Add 2pi where the phase change between dynamic t and baseline is < pi_val*pi
            2 - Add 2pi where the difference between dynamic t and t-1 is < pi_val*pi
                    
    pi_val: If phase_unwrap = 1, a good value is -0.2
            If phase_unwrap = 2, a good value is -1.0
            If phase_unwrap is None, no affect.
    """
    imgObj=nibabel.load(parrec_file,scaling='fp')
    imgData=imgObj.get_data()
    
    header=imgObj.get_header()
    numdyns = header.general_info['max_dynamics']
    
    Taffine=imgObj.header.get_affine()
    invTempAffine=np.linalg.inv(Taffine)
    
    #Only Mag & Phase (M,P) images saved
    imginfo={}
    imginfo["ty"] = np.array(list(map( lambda rec: rec[4], imgObj.header.image_defs )))
    imginfo["sl"] = np.array(list(map( lambda rec: rec[0], imgObj.header.image_defs )))
    imginfo["dyn"] = np.array(list(map( lambda rec: rec[2], imgObj.header.image_defs )))
    
    #if ( imginfo["ty"][0] != imginfo["ty"][1] ): 
    if MP_interleaved:
        Mag_inds = np.arange(0,2*numdyns,2)
        Phs_inds = np.arange(1,2*numdyns,2)
    else:
        Mag_inds = np.arange(0,numdyns)
        Phs_inds = np.arange(numdyns,2*numdyns)    
    
    ##add check for interleaving
    complexImgSeries = imgData[:,:,:,Mag_inds]* np.exp(1j * imgData[:,:,:,Phs_inds])
    
    #TE_ms = 16
    #B0_T = 3.0
    ang2temp = 1.0 / (42.576*0.01*B0_T*TE_ms*1e-3*2*math.pi)
    
    if basedynes is None:
        if num_baselines==1:
            baseline=complexImgSeries[:,:,:,0] 
        else:
            baseline=np.mean( complexImgSeries[:,:,:,0:num_baselines], axis=3 ) 
    else:
        baseline=np.mean( complexImgSeries[:,:,:,basedynes], axis=3 ) 
    
    tempSeries = np.zeros(complexImgSeries.shape)
    if diff:
        for dn in range(1,numdyns):
            tempSeries[:,:,:,dn] = np.angle( complexImgSeries[:,:,:,dn-1] * np.conj(complexImgSeries[:,:,:,dn]) )
    else:
        for dn in range(0,numdyns):
            tempSeries[:,:,:,dn] = np.angle( baseline * np.conj(complexImgSeries[:,:,:,dn]) )
    #orig=tempSeries[72,70,7,:].copy()
    
    #phase correct
    num_cor_vox=0
    max_cor_vox=0
    max_cor_dyn=0
    if phase_unwrap==1:
        for dn in range(1,numdyns):
            mask= (tempSeries[:,:,:,dn] ) < (pi_val*math.pi)
            tempSeries[mask,dn] += 2*math.pi
            num_cor_vox=np.sum(mask)
            if num_cor_vox>max_cor_vox:
                max_cor_vox=num_cor_vox
                max_cor_dyn=dn
    
    elif phase_unwrap==2:
        for dn in range(1,numdyns):
            mask= (tempSeries[:,:,:,dn] - tempSeries[:,:,:,dn-1]) < (pi_val*math.pi)
            tempSeries[mask,dn] += 2*math.pi
            num_cor_vox=np.sum(mask)
            if num_cor_vox>max_cor_vox:
                max_cor_vox=num_cor_vox
                max_cor_dyn=dn
    
    if max_cor_dyn>0:
        print("Largest number of phase-corrected voxels: %d [dyn %d]"%(max_cor_vox,max_cor_dyn))
    
    tempSeries*=ang2temp
        
    #nnM,nnP,nnS,nd=tempSeries.shape
    #tempSeries.shape
    
    tableStartTimes = imgObj.header.image_defs['dyn_scan_begin_time']
    
    
    ndyn = imgObj.header.general_info['max_dynamics']
    nslc = tempSeries.shape[2]
    
    dynTimes = np.sort(tableStartTimes)[range(0,2*ndyn*nslc, 2*nslc)]
    
    return (tempSeries, complexImgSeries, imgObj, dynTimes )
    