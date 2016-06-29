function [ usub_coords_model,nn ] = stipled_spherecap( sphereRadius, capdiam, nn, randomize )
%stipled_spherecap Generate set of points on the spherical cap
%   sphereRadius - radius of curvature
%   capdiam - diameter of opening
%   nn - max number of points

    if ~exist('randomize','var')
       randomize=0;
    end

    nk=0; nr=0; nkb=0;
    while nk <= nn
        nr = nr+1;
        nk = nr + sum( floor( 2*pi*( 0:nr-1 ) ));
    end
    nr=nr-1;
    
    maxtheta = asin( (capdiam/2.0) / sphereRadius );
    if nr > 1
        dth = maxtheta / (nr-1);
    else
        dth=0;
    end
    nphi = 1 + floor( 2*pi*( 0:nr-1 ) );
    
    nn = sum(nphi);
    nk=0;
    
    usub_coords_model = zeros([3 nn]);
    
    
    for i=1:nr
        theta_i = (i-1)*dth;
        dphi = (2*pi/nphi(i));
        
        if randomize
           rdtheta = dth*rand([1 nphi(i)]);
           rdphi = dphi*rand([1 nphi(i)]);
        else
           rdtheta = zeros([1 nphi(i)]);
           rdphi = rdtheta;
        end
        
        for j=1:nphi(i)
            phi = dphi*(j-1) + rdphi(j);
            theta = theta_i + rdtheta(j);
        	nk=nk+1;
     
            usub_coords_model(:,nk) = sphereRadius*[sin(theta)*cos(phi) , sin(theta)*sin(phi), 1-cos(theta)];
        end
    end
end

