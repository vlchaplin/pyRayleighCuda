#!/usr/bin/env python

import numpy as np

 """
 xo - position around which to explore (n-dim parameter vec)
 
 """
 def explore( x0, dx, F, N=None ):
    if N is None:
        N = len(x0)
        
    
    x1 = x0.copy()
    
    Fbest=F(x0)
    
    for j in range(0,N):
        
        #try upward perturbation
        x1[j] += dx[j]
        Fj = F(x1)
        if Fj <= Fbest:
            Fbest = Fj
            continue
        
        #try downward perturbation
        x1[j] -= 2*dx[j]
        Fj = F(x1)
        if Fj <= Fbest:
            Fbest = Fj
            continue
        
        