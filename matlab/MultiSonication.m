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

trans_element_radius = 0.0033;
trans_element_area = pi*trans_element_radius^2;
r_foc = 0.14;
z_face = max(u_pos(3,:)) + 0.01;

focal_point = [ 0.0 0 r_foc ];

N = size(u_pos,2);

%% sub-sample each transducer element (approximation to Huygen's principle)
%  Each element is modelled as a flat disk

nr = 1;
dr = trans_element_radius/nr;
nphi = 1 + floor(2*pi*((1:nr)-1) ) ;
nsubsamp = sum(nphi);

usub_coords_model=zeros(3,nsubsamp);
usub_coords = zeros(3,nsubsamp);
nn=0;
for i=1:nr
   
    r = (i-1)*dr;
    dphi = (2*pi/nphi(i));

    for j=1:nphi(i)
        
        phi = dphi*(j-1);
        nn=nn+1;
        
        usub_coords_model(:,nn) = [ r*cos(phi) r*sin(phi) 0 ];
        
    end
    
end

%% Template control points

%% disk around focus in X-Y plane
nfoci=4;
radius=0.003;
rm = zeros(nfoci,3);
thetas = (0:(2*pi/(nfoci)):2*pi) - pi/4  ;
for k=1:nfoci
    rm(k,:) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0 ];
    rm(k,:) = rm(k,:) + focal_point ;
end




p_control_xyz = rm';
M=size(p_control_xyz,2);

p_control=zeros(1,M);
p_control(:)=1e07;

uopt = get_transducer_vals( u_pos, f_o, rho, c, p_control_xyz, p_control ); 

xrange = [-1 1]*0.01 ;
yrange = [-1 1]*0.01 ;
zrange = r_foc + [-1 1]*0.03;

Nx=31;
Ny=31;
Nz=31;

I0 = zeros([Nx Ny Nz] );

xrp = linspace(xrange(1), xrange(2), Nx);
yrp = linspace(yrange(1), yrange(2), Ny);
zrp = linspace(zrange(1), zrange(2), Nz);

dSvox = [xrp(2)-xrp(1), yrp(2)-yrp(1), zrp(2) - zrp(1)];

focal_point_pix = floor( ([ 0.0 0 r_foc ] - [xrange(1), yrange(1), zrange(1)]) ./ dSvox)+1;

p0 = complex(zeros(Nx,Ny,Nz));

[gx, gy, gz] = meshgrid( yrp, xrp, zrp );

for n=1:N
    

    x=u_pos(1,n);
    y=u_pos(2,n);
    z=u_pos(3,n);
    
    unormal = focal_point - [x y z];
    
    [un_az,un_alt,un_r]=cart2sph( unormal(1), unormal(2), unormal(3) );
     
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);

    nth_integrand_coeff = (trans_element_area/nsubsamp)*uopt(n)*1i*rho_c_k/(2*pi);
    
    for j=1:nsubsamp
       
        elpos = [x y z]' + Rn'*usub_coords_model(:,j) - dSvox'/2.0;

        d=sqrt( (elpos(1) - gx).^2 + (elpos(2) - gy).^2 + (elpos(3) - gz).^2 );
    
        thisSource = nth_integrand_coeff.*exp(-1i*kr.*(d))./d;
        
        p0 = thisSource + p0;
        
    end
    
    
end

I0=(( p0.*conj(p0)  ) / (2*rho_c) );

maxI= max(I0(:));
newMaxI = 1e7;
I0 = I0.*(newMaxI/maxI);
maxI = newMaxI;
halfmaxI = 0.5*maxI;

figure(1);
clf;
hold on;

s=slice(gx,gy,gz, I0, [] ,[], r_foc );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, I0, [] ,[], r_foc-0.005 );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, I0, 0 ,[], [] );
set(s,'EdgeColor','none');

%s=slice(gx,gy,gz, I, [], 0, [] );
%set(s,'EdgeColor','black');

daspect([1 1 1]);
%view([45 45]);

caxis([0.001*maxI maxI]);

return;
%%

centroids = ( [...
    [0.01 0.01 r_foc]; [0.015 0.02 r_foc]; [0.01 0.03 r_foc]; [0.015 0.04 r_foc]; [0.01 0.05 r_foc];...
    [0.02 0.01 r_foc]; [0.025 0.02 r_foc]; [0.02 0.03 r_foc]; [0.025 0.04 r_foc]; [0.02 0.05 r_foc];...
    [0.03 0.01 r_foc]; [0.03 0.03 r_foc]; [0.03 0.05 r_foc];...
    [0.04 0.01 r_foc]; [0.04 0.03 r_foc]; [0.04 0.05 r_foc];...
    [0.05 0.01 r_foc]; [0.05 0.03 r_foc]; [0.05 0.05 r_foc]; ]  )';

centroids_pix = centroids;
nson = size(centroids,2);
for n=1:nson
   centroids_pix(:,n) = floor( centroids(:,n) ./ dSvox' ) +1 ;
end



fieldFOV = [ 0.06 0.06 ( zrange(2)-zrange(1) ) ];

fieldDims = [ floor(fieldFOV(1:2)./(dSvox(1:2)))+1 Nz ];

I = zeros(fieldDims);

ThermDose = zeros(fieldDims);

tstep = 0.1;
Nt = 10;
Cp = 3700;

T0 = zeros([1 fieldDims]);
T0(:) = 37;

ktherm = 0.5;
alpha = 0.5;

dwellTime = 10;
waitTime = 30;
simDur = Nt*tstep;
tTot=0;

for n=1:nson

    I = zeros(fieldDims);
    
    pixstart = centroids_pix(:,n) - floor([Nx Ny Nz]'/2);
    pixend = centroids_pix(:,n) + floor([Nx Ny Nz]'/2);
    
    I( pixstart(1):pixend(1), pixstart(2):pixend(2), : ) = I0;
    
    t=0;
    %Turn on
    while(t < dwellTime)
       
        [Ton] = homogenousePBHE( T0, alpha, ktherm, rho, Cp, c, I, fieldDims(1), fieldDims(2), fieldDims(3), dSvox, 0, 0, 0, Nt, tstep, 0 );
        
        t=t+simDur;
        
        Rbase = 4.00*ones([Nt fieldDims]);
        Rbase(Ton>=43) = 2.0;

        ThermDose = ThermDose + squeeze( sum( Rbase.^(Ton-43), 1 ) )*tstep;

        
        T0 = (Ton(Nt,:,:,:));
    end
    
    tTot = tTot+t;
    
    t=0;
    I(:)=0;
    while(t < waitTime)
       
        [Ton] = homogenousePBHE( T0, alpha, ktherm, rho, Cp, c, I, fieldDims(1), fieldDims(2), fieldDims(3), dSvox, 0, 0, 0, Nt, tstep, 0 );
        
        t=t+simDur;
        
        Rbase = 4.00*ones([Nt fieldDims]);
        Rbase(Ton>=43) = 2.0;

        ThermDose = ThermDose + squeeze( sum( Rbase.^(Ton-43), 1 ) )*tstep;

        
        T0 = (Ton(Nt,:,:,:));
    end

end



%% contours

xrp = linspace(0, fieldFOV(1), fieldDims(1));
yrp = linspace(0, fieldFOV(2), fieldDims(2));
zrp = linspace(zrange(1), zrange(2), fieldDims(3));
[tx, ty, tz] = meshgrid( yrp, xrp, zrp );



figure(3);
clf;
hold on;

xplotr = [0 0.06];
yplotr = xplotr;
axis([ xplotr yplotr .10 .18 0 1 ] );

%light('Position', [0.00 -0.001 0.14]);
light('Position', [0 -3 1]);

cemVal = 240;
p=patch( isosurface( tx, ty, tz, ThermDose, cemVal ) );
isonormals(tx, ty, tz, ThermDose,p);
set(p, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 0.9, 'SpecularExponent', 25, 'BackFaceLighting', 'unlit' ...
    );

p=patch( isosurface( tx, ty, tz, ThermDose, 5 ) );
isonormals(tx, ty, tz, ThermDose,p);
set(p, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.5, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );



view([60 10]);
 
daspect([1 1 1]);

xlabel('X [cm]', 'Fontsize', 12);
ylabel('Y [cm]', 'Fontsize', 12);
zlabel('Axial [cm]', 'Fontsize', 12);
