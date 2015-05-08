%% rotmatZYZ
% Returns the Euler rotation matrix for a right-handed positive roation (z-y-z convention).
% For a 1x3 vector u, and R=rotmatZYZ(a1,a2,a3), u*R gives u right-hand rotated by a1
% about the Z-axis, then a2 about the (newly rotated) y axis, then a3 about
% the final z axis
%
%  u represents a vector of cartesian coordinates with respect to
% the original x-y-z axes. Then v=u*R are the coordinates of the rotated
% vector also w.r.t. the original axes.
function [ rotmat ] = rotmatZYZ( zrot, zyrot, zyzrot )

    c1 = cos(zrot); s1 = sin(zrot);
    c2 = cos(zyrot); s2 = sin(zyrot);
    c3 = cos(zyzrot); s3 = sin(zyzrot);
    
    %this defines each row
    rotmat = [ [ c1*c2*c3 - s1*s3 , s1*c2*c3 + c1*s3,-s2*c3 ]; ...
               [-c1*c2*s3 - s1*c3 ,-s1*c2*s3 + c1*c3, s2*s3 ]; ...
               [ c1*s2 , s1*s2, c2 ]; ];
    
    



end

