function [ arrayN, pixMult, dimsN ] = reduceScalarGridFunc( arrayM, dimsM, dimsN )
%reduceScalarGridFunc Convert arrayM of size dimsM to arrayN of size dimsN
%   The new array values will be averaged and interpolated from the input
%   arrayM.  
%   dimsN must be <= dimsM

ii = find(dimsN > dimsM);
if length(ii) > 0
    dimsN(ii) = dimsM(ii);
end

pixMult = dimsM ./ dimsN;
%voxelSizeN = pixMult .* voxelSizeM;
ndims = length(dimsM);

voxelSizeM = ones([1 ndims]);
voxelSizeN = voxelSizeM;

intermediateDims = dimsM;
prevIntegrand = arrayM;

for d=1:ndims

    
    intermediateDims(d) = dimsN(d);
    reassignmentFraction = zeros( dimsN(d), dimsM(d) );
    
    xnedges = voxelSizeN(d)*(0:dimsN(d));
    xmedges = voxelSizeM(d)*(0:dimsM(d));
    
    dm = voxelSizeM(d);
    dn = voxelSizeN(d);
    
    reassignmentFraction(1,1) = 1;
    
    for n=1:dimsN(d)
       
       deltaN = xnedges(n+1) - xmedges;
       
       mm = find(deltaN >= 0 & deltaN < dn);
       
       reassignmentFraction(n,mm-1) = 1;
       
       
       if (xmedges(mm(1)) - xnedges(n)) <= dm
           reassignmentFraction(n,mm(1)-1) = ( xmedges(mm(1)) - xnedges(n) )  / dm;
           if n>1
            reassignmentFraction(n-1,mm(1)-1) = 1 - reassignmentFraction(n,mm(1)-1);
           end
       end
               
    end
    
    arrayN = zeros(intermediateDims);
    
    
    for n=1:dimsN(d)
        
        lhs_inds = array_slice_indices( intermediateDims, n, d);
        sumn=0;
        for m=1:dimsM(d)

             sumn = sumn + reassignmentFraction(n,m)*array_slice( prevIntegrand, m, d );
        end
        
        arrayN(lhs_inds) = sumn(:)';
        
    end
    prevIntegrand = arrayN;
    
    
    
end





end

