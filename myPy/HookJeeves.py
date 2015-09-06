#!/usr/bin/env python

import numpy as np

def vecs_equal(x0, x1, tolerance=1e-08):
   return ( 2.0*np.sum( np.abs( (x0 - x1) / (x0 + x1) ) )  < tolerance )


"""
 x0 - position around which to explore (n-dim parameter vec)
 dx - perturbation vector
"""
def explore( x0, dx, F, N=None ):
   if N is None:
      N = len(x0)
      
   x1 = x0.copy()
   
   Fbest=F(x0)
   
   failCount=0
   
   for j in range(0,N):
      
      #try upward perturbation
      x1[j] += dx[j]
      Fj = F(x1)
      if Fj <= Fbest:
          #retain and go to next j iteration
          Fbest = Fj
          continue
      
      #otherwise try downward perturbation
      x1[j] -= 2*dx[j]
      Fj = F(x1)
      if Fj <= Fbest:
          #retain and go to next j iteration
          Fbest = Fj
          continue
      
      #otherwise discard
      x1[j] += dx[j]
      failCount+=1
      
   return (x1, failCount==N)


def pattern_move( x0, x1, accel=2.0 ):
   return x0 + accel*(x1 - x0)



def full_search( x0init, dxinit, aInit, dxTolerance, F ):
   N=len(x0init)
   x0=x0init
   dx = dxinit
   
   #START/RESTART
   x1, failedFlag = explore(x0init,dx,F,N=N)
   if failedFlag:
      dx = dx/2.0
      if dx < dxTolerance:
         #go to EXIT
      else:
         #go to START RESTART