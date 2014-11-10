mex -IC:\Users\vchaplin\Documents\HiFU\code\BioHeatCpp\BioHeatCpp 'C:\Users\vchaplin\Documents\HiFU\code\RSAcoustics\RSAcoustics\RSTransducerFieldMEX.cpp'


%% physics params


f_o = 1.2e6; % Hz
w = 2*pi*f_o; % rad/sec

c = 1540; % m/s
kr = w/c;

% 
rho = 1000; %kg per m^3
rho_c = rho*c;
rho_c_k = rho*c*kr;

%% Trasnducer element positions
file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
u_pos = get_sonalleve_transducers_xyz(file);

r_foc = 0.14;
z_face = max(u_pos(3,:)) + 0.01;

N = size(u_pos,2);

%% Control points

% p_control_xyz = rm_pix;
% p_control_xyz(1,:) = pixel_size*(rm_pix(1,:) - Nx/2  );
% p_control_xyz(2,:) = pixel_size*(rm_pix(2,:) - Ny/2   );
% p_control_xyz(3,:) = pixel_size*(rm_pix(3,:) - 1);

p_control_xyz = ( [[0.00 0 r_foc]; [-0.0 0 r_foc]; ] )';

M=size(p_control_xyz,2);

p_control=zeros(1,M);
p_control(:)=1e09;

uopt = get_transducer_vals( u_pos, f_o, rho, c, p_control_xyz, p_control );

%%

u_amp = uopt';

pixel_size=0.002;
dx = pixel_size*[1 1 1];

focal_point_pix = floor([ 0 0 r_foc ] ./ dx)+1;

Nx=75;
Ny=75;
Nz=floor(2.0*r_foc/dx(3));

p = complex(zeros(Nx,Ny,Nz));

u_pos_shifted=u_pos;
u_pos_shifted(1,:) = u_pos_shifted(1,:) + (Nx/2 - 0.5)*dx(1); 
u_pos_shifted(2,:) = u_pos_shifted(2,:) + (Ny/2 - 0.5)*dx(2);

%RSTransducerFieldMEX( rho, c, kr, u_pos_shifted, u_amp, p, dx );
p2 = RSTransducerField( rho, c, kr, u_pos_shifted, u_amp, p, dx );
p=p2;
[gx, gy, gz] = meshgrid( ((0:Ny-1) - Ny/2 + 0.5).*dx(2), ((0:Nx-1) - Nx/2 + 0.5).*dx(1), ((0:Nz-1) ).*dx(3));

% for n=1:N
%     
% 
%     x=u_pos(1,n);
%     y=u_pos(2,n);
%     z=u_pos(3,n);
%     
%     
% %     [un_az,un_alt,un_r]=cart2sph(u_face_vectors(1,n), u_face_vectors(2,n), u_face_vectors(3,n));
% %     
% %     Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
%     
%     d=sqrt( (x - gx).^2 + (y - gy).^2 + (z - gz).^2 );
%     
%     thisSource = uopt(n)*1i*rho_c_k/(2*pi).*exp(-1i*kr.*(d))./d;
%         
%     p(:,:,:) = thisSource + p;
%     
% end


I=(( p.*conj(p)  ));
maxI= 0.5*max(I(:));

jj=find(I > maxI);
I(jj)=maxI;

figure(1);
clf;
hold on;

s=slice(gx,gy,gz, I, [] ,[], r_foc );
set(s,'EdgeColor','none','Facecolor','interp');

s=slice(gx,gy,gz, I, [], 0, [] );
set(s,'EdgeColor','none', 'Facecolor','interp');

daspect([1 1 1]);
view([70 5]);

