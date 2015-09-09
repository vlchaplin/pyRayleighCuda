#!/usr/bin/env python

import numpy as np

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
        if Fj <= Fbest:
            print(" #retain upward")
            #retain and go to next j iteration
            Fbest = Fj
            continue
        
        #otherwise try downward perturbation
        x1[j] -= 2*dx[j]
        Fj = F(x1)
        if Fj <= Fbest:
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



def minimize( F, x0init, dxinit, aInit, dxTolerance, MAX=100 ):
    N=len(x0init)
    x0 = x0init
    dx = dxinit
    accel=aInit
   
    F0=None
    restartCount=0
   
    #START/RESTART
    while(1):
        if restartCount > MAX:
            return(x0, 1)
        
        print("#RESTART ", restartCount, flush=True)
        restartCount+=1
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
        while(1):
            print("#PATTERN MOVE ", restartCount)
            x2 = pattern_move_step(x0,x1,accel=accel)
            x2, failedFlag, Ftry = explore(x2,dx,F,N=N)
            
            #obtain F(x2)
            if Ftry is not None:
                    F2 = Ftry
            else:
                F2 = F(x2)
            
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
                continue
            
    return (x0, -1)