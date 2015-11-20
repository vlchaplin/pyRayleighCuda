function [ pn, near_field_mask, gx, gy, gz ] = calc_finitexdc_pressure_field_ndgrid( kr, uamp, uxyz, simXp, simYp, simZp, u_normals, u_template )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[gx, gy, gz] = ndgrid( simXp, simYp, simZp );

N = size(uxyz,2);

nsubsamp = size(u_template,2);
if nsubsamp == 0
    nsubsamp =1;
end
pn = zeros([length(simXp) length(simYp) length(simZp)]);

near_field_mask = zeros(size(pn));

integral_coeffs = uamp(:).*1i.*ones([N 1]);

u_normals_unit = u_normals ./ repmat(sqrt( sum( u_normals.^2, 1) ), [3 1] );

for n=1:N
    
    if nsubsamp > 1
        [un_az,un_alt,un_r]=cart2sph(u_normals(1,n), u_normals(2,n), u_normals(3,n));
    
        Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
        patchcoords = repmat(uxyz(:,n),1,nsubsamp) + Rn'*u_template;
    else
        patchcoords = uxyz(:,n);
    end

    for j=1:nsubsamp
        
        dvx = patchcoords(1,j)-gx;
        dvy = patchcoords(2,j)-gy;
        dvz = patchcoords(3,j)-gz;
        d = sqrt( (dvx).^2 + (dvy).^2 + (dvz).^2 );
    
        cosines = (u_normals_unit(1,n).*dvx + u_normals_unit(2,n).*dvy + u_normals_unit(3,n).*dvz)./d;
        
        thisSource = cosines.*integral_coeffs(n).*exp(-1i*kr.*(d))./d;
    
        pn = thisSource+pn;
        
    end
    
    near_field_mask( d < 0.01 ) = true;

end

