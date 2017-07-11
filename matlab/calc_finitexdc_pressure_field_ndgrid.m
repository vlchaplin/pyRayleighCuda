function [ pn, near_field_mask, gx, gy, gz ] = calc_finitexdc_pressure_field_ndgrid( kr, uamp, uxyz, simXp, simYp, simZp, u_normals, u_template )
% Return the 3D pressure field calculated on the ndgrid defined by simXp, simYp, simZp.
%   kr - wavenumber (1/meters).  So if c is sound speed (m/s) and f0 is frequency in Hz, kr = 2*pi*f0 / c
%   uamp - complex amplituude of each array element.  Element amplitude and delays are defined with uamp. 
%           Delays in radians can be calculated as  delay_rad = 2*pi*delay_seconds/f0
%           
%   uxyz - element position vectors (3xN)
%   u_normals - normal vector of each element
%   u_template - Disk or spherical set of point defining point sources (3xP) of each element. 
%                The template coordinates will be interpreted so that its z-axis will be aligned to each element normal.
%                Pass [] to use a single point source

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
        
        thisSource = cosines.*integral_coeffs(n).*( exp(-1i*kr.*(d)) )./d;
    
        pn = thisSource+pn;
        
    end
    
    near_field_mask( d < 0.01 ) = true;

end

