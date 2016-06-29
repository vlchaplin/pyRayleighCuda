function [ uopt] = get_transducer_vals(u_pos, f_o, rho, c, control_xyz, control_p )

M = size(control_xyz,2);
N = size(u_pos,2);

%% material, physics
%f_o = 1.2e6; % Hz
w = 2*pi*f_o; % rad/sec

%c = 1540; % m/s
kr = w/c;

%rho
%rho = 1000; %kg per m^3
rho_c_k = rho*c*kr;

%% compute
H = zeros(M,N);
nzeros=0;
for n=1:N
    
    for m=1:M
        
        Rmn = norm(control_xyz(:,m) - u_pos(:,n));
        
        if Rmn > 0
        H(m,n) = (1i)*rho_c_k*exp(-1i*kr*Rmn)/Rmn;
        else
           nzeros=nzeros+1; 
        end
        
    end

    
end

%H = abs(H);

Hstar_t = ctranspose(H);
HHstar_tinv = pinv(H*Hstar_t);

uopt = Hstar_t*HHstar_tinv*(control_p(:));



end

