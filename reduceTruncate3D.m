function [ initI DXmultiplier newdims ] = reduceTruncate3D( I, Nx, Ny, Nz, nnx, nny, nnz )
%reduceTruncate3D Takes the input 3D array 'I' of size [Nx Ny Nz] and
%reduces its resolution. Each voxel of the new array is an average of a
%cube of voxels from the 
%   Each voxel of the new array is an average of several voxels from the
%   original array.  The new array is sized such that an integer number of
%   original voxels are averaged along each dimension (so no need to split voxels).
%   Ex. if Nx = 128 and the requsted nnx = 64, then a span of two voxels in the
%   x-direction (first dimension) will be included in the average together.
%   
%   

if nnx>=Nx
    kNx=1; overshootX=0; nnx=Nx;
else
    kNx = ceil(Nx/nnx); overshootX = mod( nnx - rem(Nx,nnx), nnx ); 
end

if nny>=Ny
    kNy=1; overshootY=0; nny=Ny;
else
    kNy = ceil(Ny/nny); overshootY = mod( nny - rem(Ny,nny), nny );
end

if nnz>=Nz
    kNz=1; overshootZ=0; nnz=Nz;
else 
    kNz = ceil(Nz/nnz); overshootZ = mod( nnz - rem(Nz,nnz), nnz );
end

kNxNyNz = kNx*kNy*kNz;

DXmultiplier = [kNx, kNy, kNz];

xe = nnx - ceil(overshootX/kNx);
ye = nny - ceil(overshootY/kNy);
ze = nnz - ceil(overshootZ/kNz);

initI = zeros(xe,ye,ze);

newdims=[xe ye ze];

for x=1:xe
    
    ox = (((x-1)*kNx) + 1) : (x*kNx);
    Ix = sum( I(ox,:,:), 1);
    
    for y=1:ye
        oy = (((y-1)*kNy) + 1) : (y*kNy);
        
        Ixy = sum(Ix(1,oy,:), 2);
        
        for z=1:ze
            
            oz = (((z-1)*kNz) + 1) : (z*kNz);
            initI(x,y,z) = sum(Ixy(1,1,oz), 3) / kNxNyNz;
            %initI(x,y,z) = sum(I(ox,oy,oz))/kNxNyNz; 
            
        end
    end
end

%%%% need to fill in last part too





end

