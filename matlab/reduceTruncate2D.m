function [ initI DXmultiplier newdims ] = reduceTruncate2D( I, Nx, Ny, nnx, nny)
%reduceTruncate2D Takes the input 2D array 'I' of size [Nx Ny] and
%reduces its resolution.  
%   Each pixel of the new array is an average of several pixels from the
%   original array.  The new array is sized such that an integer number of
%   original pixels are averaged along each dimension (so no need to split voxels).
%   Ex. if Nx = 128 and the requsted nnx = 64, then a span of two voxels in the
%   x-direction (first dimension) will be included in the average together.
%   
%   


kNx = ceil(Nx/nnx); overshootX = mod( nnx - rem(Nx,nnx), nnx ); %mod handles when rem()=0
kNy = ceil(Ny/nny); overshootY = mod( nny - rem(Ny,nny), nny );
kNxNy = kNx*kNy;

DXmultiplier = [kNx, kNy];

xe = nnx - ceil(overshootX/kNx);
ye = nny - ceil(overshootY/kNy);

initI = zeros(xe,ye);

newdims=[xe ye];

for x=1:xe
    
    ox = (((x-1)*kNx) + 1) : (x*kNx);
    Ix = sum( I(ox,:), 1);
    
    for y=1:ye
        oy = (((y-1)*kNy) + 1) : (y*kNy);
        
        Ixy = sum(Ix(oy), 2);
        
        initI(x,y) = Ixy / kNxNy;

    end
end

%%%% need to fill in last part too





end

