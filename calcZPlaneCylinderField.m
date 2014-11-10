% returns the 2D matrix (aka image) evaluated as if it were a cylindrically symmetric function and 
% rotated into the third dimension (out of the screen) by an angle phi. 
% The matrix represents the cylindrically symmetric function evaluated in
% the X-Y plane (rows are in the x+ direction, columns in y). The axis of
% symmetry is assumed to be from the center lines of the image/matrix.
%
% The rotation axis is either along x or y,
% depending on rot_axis. If rot_axis = 'x', the rotation axis is assumed to
% be row M/2 and parellel to 'x'.
function [ xo, yo, values ] = calcZPlaneCylinderField( z, mat, rot_axis )

[M, N] = size(mat);

sx = 1:M;
sy = 1:N;

if rot_axis=='x' 

    phis = atan(z ./ sy );
    
    %xo = x;
    yo = floor((y-N/2)*cosphi - (z-M/2)*sinphi + sinphi*N/2)+1;
    %zo = floor((y-N/2)*sinphi + (z-M/2)*sinphi)+1;
    
    ok=find(yo <= N & yo > 0 );
    
    xo=x(ok);
    yo=yo(ok);
    
    values = zeros( length(x), length(x) );
    values(ok,ok) = mat(xo,yo);
    
    size(ok)
    
    
   % values = [M N];
    
%     if yo > N || zo > M 
%         value = 0;
%     else
%         
%     end
end



end

