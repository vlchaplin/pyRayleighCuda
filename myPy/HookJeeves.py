#!/usr/bin/env python

import numpy as np

def calcL2norm(arr):
    return np.sqrt( np.sum( arr**2 ) )


def defaultKeyEqual(xa,xb, tol=1e-7):
    #z = distanceND(xa,xb)
    return  (calcL2norm(xa - xb) / calcL2norm(xa + xb) ) < tol 

def make_default_evaldict():
    """
    Returns a dict with the proper keys to be used in looking previous postions.
    i.e.,
    return dict(InList=[],ResultList=[],KeyEqualFunc=HookJeeves.defaultKeyEqual)
    
    The 'KeyEqualFunc' field can be changed to reference a function which compares two n-dimensional vectors and returns True or False if they are equal.
    By default this will be the function defaultKeyEqual, which uses simple Euclidean distance. 

    """
    return dict(InList=[],ResultList=[],KeyEqualFunc=defaultKeyEqual)

def search_evaldict(xt,evaldict):
    idx=None
    for i in range(0,len(evaldict['InList'])):
        xe = evaldict['InList'][i]
        if evaldict['KeyEqualFunc'](xt,xe):
            idx=i
            break
    return idx
    
    
def vecs_equal(x0, x1, tolerance=1e-08):
   return ( 2.0*np.sum( np.abs( (x0 - x1) / (x0 + x1) ) )  < tolerance )


"""
 x0 - position around which to explore (n-dim parameter vec)
 dx - perturbation vector
"""
def explore( x0, dx, F, N=None, F0=None ):
    if N is None:
        N = len(x0)
    
    x1 = x0.copy()
    
    #In some case F(x0) will have been calculated already, so no need to recalculate
    if F0 is not None:
        Fbest = F0
    else:
        Fbest=F(x0)
    
    failCount=0
    
    for j in range(0,N):
        print("explore{%d}" %j)
        #try upward perturbation
        x1[j] += dx[j]
        Fj = F(x1)
        if Fj < Fbest:
            print(" #retain upward")
            #retain and go to next j iteration
            Fbest = Fj
            continue
        
        #otherwise try downward perturbation
        x1[j] -= 2*dx[j]
        Fj = F(x1)
        if Fj < Fbest:
            print(" #retain downward")
            #retain and go to next j iteration
            Fbest = Fj
            continue
        
        print("  #discard")
        #otherwise discard
        x1[j] += dx[j]
        failCount+=1
    
    if failCount==0:
        return (x1, 0, Fbest)
    else:
        return (x1, failCount==N,None)


def pattern_move_step( x0, x1, accel=2.0 ):
   return x0 + accel*(x1 - x0)

def wrap_with_eval_dict(F,x,evaldict,**kwargs):
    idx=search_evaldict(x,evaldict)
    if idx is None:
        ret=F(x,**kwargs)
        
        evaldict['InList'].append(x.copy())
        evaldict['ResultList'].append(ret)
        return ret
    else:
        #print("Found in evaldict")
        return evaldict['ResultList'][idx]

def minimize( Fobj, x0init, dxinit, aInit, dxTolerance, MAX=100, evaldict=None, **kwargs ):
    """
    x0init and dxinit must be numpy arrays.  dxTolerance can be a list.
    
    Inputs:
    F - objective function taking a parameter vector of length n
    x0init - initial guess of the minimizer. Vector of length n. Must be a numpy array, not a list.
    dxinit - initial step size to use
    aInit - acceleration factor in pattern move. Typical value is 2.0
    dxTolerance - success interval criteria for each parameter. Vector of length n
    """
    N=len(x0init)
    x0 = x0init
    dx = dxinit
    accel=aInit
   
    F0=None
    count=0
    exploreWithinPatternMove_FAIL_MAX=5
    exploreWithinPatternMove_FAIL_cnt=0
    
    if evaldict is not None:
        F = lambda x: wrap_with_eval_dict(Fobj,x,evaldict,**kwargs)
    else:
        F = lambda x: Fobj(x,**kwargs)
        
   
    #START/RESTART
    while(1):
        if count > MAX:
            return(x0, 1)
        
        print("#RESTART ", count, flush=True)
        count+=1
        x1, failedFlag, Ftry = explore(x0, dx, F, N=N, F0=F0)
        if failedFlag:
            
            dx = dx/2.0
            print ("#CONTRACTION, dx -> ", dx)
            if np.any(dx < dxTolerance):
                #go to EXIT
                return(x0, 0)
            else:
                #goto START/RESTART
                continue
        else:
            dx = dxinit
            
            #obtain F(x1)
            if Ftry is not None:
                F1 = Ftry
            else:
                F1 = F(x1)
            #go to PATTERN MOVE
        
        #PATTERN MOVE
        exploreWithinPatternMove_FAIL_cnt=0
        while(1):
            print("#PATTERN MOVE ", exploreWithinPatternMove_FAIL_cnt)
            
            if exploreWithinPatternMove_FAIL_cnt > exploreWithinPatternMove_FAIL_MAX:
                #A special circumstance in which x2==x0 AND the explore fails , causing repeated pattern move + fail...
                print("Taking random step")
                x2 = x1 + dx*(1 - np.random.randint(0,high=9,size=x0.shape)/4.0)
                F2 = F(x2)
                Ftry = None
            else:
                x2 = pattern_move_step(x0,x1,accel=accel)
                x2, failedFlag, Ftry = explore(x2,dx,F,N=N)
            
            
            #obtain F(x2)
            if Ftry is not None:
                    F2 = Ftry
            else:
                F2 = F(x2)
            print(x0,x1,x2, " : ", F0,F1,F2, failedFlag)
            if F2 > F1:
                x0 = x1
                F0 = F1
                #goto START/RESTART
                break
            else:
                x0 = x1
                x1 = x2
                F0 = F1
                F1 = F2
                #goto PATTERN MOVE
                exploreWithinPatternMove_FAIL_cnt+=1
                
                continue
            
    return (x0, -1)