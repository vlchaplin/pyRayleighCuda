function [ p2 ] = RSTransducerField( rho, c, kr, u_pos_shifted, u_amp, p, dx )

size(p)

[Nx, Ny, Nz] = size(p);

N = size(u_amp,2);

[gx, gy, gz] = meshgrid( ((0:Ny-1) + 0.5).*dx(2), ((0:Nx-1) + 0.5).*dx(1), ((0:Nz-1) ).*dx(3));

rho_c_k = 1i*rho*kr*c;
p2=p;

for n=1:N
    
    x=u_pos_shifted(1,n);
    y=u_pos_shifted(2,n);
    z=u_pos_shifted(3,n);
    
    d=sqrt( (x - gx).^2 + (y - gy).^2 + (z - gz).^2 );
    
    thisSource = u_amp(n)*rho_c_k/(2*pi).*exp(-1i*kr.*(d))./d;
        
    p2(:,:,:) = thisSource + p;
    
end

end

