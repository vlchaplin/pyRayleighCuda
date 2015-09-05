function [ pn, near_field_mask ] = calc_finitexdc_pressure_field_ndgrid( kr, uamp, uxyz, simXp, simYp, simZp, u_normals, u_template )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[gx, gy, gz] = ndgrid( simXp, simYp, simZp );

N = size(uxyz,2);

nsubsamp = size(u_template,2);
if nsubsamp == 0
    nsubsamp =1
end
pn = zeros([length(simXp) length(simYp) length(simZp)]);

near_field_mask = zeros(size(pn));

integral_coeffs = uamp(:).*1i.*ones([N 1]);

for n=1:N
    
    if nsubsamp > 1
        [un_az,un_alt,un_r]=cart2sph(u_normals(1,n), u_normals(2,n), u_normals(3,n));
    
        Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
        patchcoords = repmat(uxyz(:,n),1,nsubsamp) + Rn'*u_template;
    else
        patchcoords = uxyz(:,n);
    end

    for j=1:nsubsamp
        
        d = sqrt( (patchcoords(1,j)-gx).^2 + (patchcoords(2,j)-gy).^2 + (patchcoords(3,j)-gz).^2 );
    
        thisSource = integral_coeffs(n).*exp(-1i*kr.*(d))./d;
    
        pn = thisSource+pn;
        
    end
    
    near_field_mask( d < 0.01 ) = true;

end

