function [ pn, near_field_mask ] = calc_finitexdc_pressure_profile( kr, uamp, uxyz, pathXYZ, u_normals, u_template )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

N = size(uxyz,2);

nsubsamp = size(u_template,2);

nsubsamp = size(u_template,2);
if nsubsamp == 0
    nsubsamp =1
end

mm = size(pathXYZ,2);

pn = zeros([1 mm]);

near_field_mask = zeros(size(pn));

integral_coeffs = uamp(:).*ones([N 1]);

u_normals_unit = u_normals ./ repmat(sqrt( sum( u_normals.^2, 1) ), [3 1] );

for n=1:N
    
%     [un_az,un_alt,un_r]=cart2sph(u_normals(1,n), u_normals(2,n), u_normals(3,n));
%     
%     Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
%     
%     patchcoords = repmat(uxyz(:,n),1,nsubsamp) + Rn'*u_template;
    if nsubsamp > 1
        [un_az,un_alt,un_r]=cart2sph(u_normals(1,n), u_normals(2,n), u_normals(3,n));
    
        Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
        patchcoords = repmat(uxyz(:,n),1,nsubsamp) + Rn'*u_template;
    else
        patchcoords = uxyz(:,n);
    end
    

      % rayleigh I integral 
    for j=1:nsubsamp
        
        dvec = (repmat(patchcoords(:,j), 1, mm) - pathXYZ);
        d = sqrt( sum( dvec.^2, 1) );
        cosines = (u_normals_unit(:,n)'*dvec)./d;

        thisSource = cosines.*1i.*integral_coeffs(n).*exp(-1i*kr.*(d))./d;
    
        pn = thisSource+pn;
        
    end
   

%     % rayleigh II integral (doesn't seem to be correct yet)
%     for j=1:nsubsamp
%         
%         dvec = (repmat(patchcoords(:,j), 1, mm) - pathXYZ);
%         d = sqrt( sum( dvec.^2, 1) );
%         
%         cosines = (u_normals_unit(:,n)'*dvec)./d;
% 
%         thisSource = cosines.*(2*pathXYZ(3,:) ./ d).*integral_coeffs(n).*(1./d - 1i*kr).*exp(-1i*kr.*(d))./d;
%     
%         pn = thisSource+pn;
%         
%     end
    
    near_field_mask( d < 0.01 ) = true;

end

