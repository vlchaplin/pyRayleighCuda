function [ pn, near_field_mask ] = calc_finitexdc_pressure_profile( kr, uamp, uxyz, pathXYZ, u_normals, u_template )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

N = size(uxyz,2);

nsubsamp = size(u_template,2);

mm = size(pathXYZ,2);

pn = zeros([1 mm]);

near_field_mask = zeros(size(pn));

integral_coeffs = uamp(:).*1i.*ones([N 1]);

for n=1:N
    
    [un_az,un_alt,un_r]=cart2sph(u_normals(1,n), u_normals(2,n), u_normals(3,n));
    
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
    patchcoords = repmat(uxyz(:,n),1,nsubsamp) + Rn'*u_template;
    

    for j=1:nsubsamp
        
        d = sqrt( sum( (repmat(patchcoords(:,j), 1, mm) - pathXYZ).^2, 1) );

        thisSource = integral_coeffs(n).*exp(-1i*kr.*(d))./d;
    
        pn = thisSource+pn;
        
    end
    
    near_field_mask( d < 0.01 ) = true;

end

