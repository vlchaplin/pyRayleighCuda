%mex -IC:\Users\vchaplin\Documents\HiFU\code\BioHeatCpp\BioHeatCpp 'C:\Users\vchaplin\Documents\HiFU\code\RSAcoustics\RSAcoustics\RSTransducerFieldMEX.cpp'


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

%% Sub-sample template to sub-sample each transducer element (approximation to Huygen's principle)
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

%% Control points

cdis = 0.0035;
rm = [ [cdis -cdis focal_point(3)]; [0 .005 focal_point(3)];  [-cdis -cdis focal_point(3)];  ];

model_translate = [0.00 0.005 0];

for k=1:3
    
    rm(k,:) = (rm(k,:) + model_translate);
end


%% equilateral triangle in XY plane
nfoci=3;
triangle_height=0.01;
triangle_halfside = triangle_height/tan(pi/3);
modelframe_center = [0 triangle_halfside*tan(pi/6) 0];

rm = [ [ triangle_halfside 0 0]; [0 triangle_height 0]; [ -triangle_halfside 0 0]];

%R = rotmatZYZ(0, 0, pi/3);
R = rotmatZYZ(0, 0, 0);
for k=1:nfoci
    
    rm(k,:) = (rm(k,:) - modelframe_center)*R + focal_point + 0*[ 0 modelframe_center(2)-triangle_height 0 ];
end
%% disk around focus in X-Y plane
nfoci=4;
radius=0.005;
rm = zeros(nfoci,3);
thetas = (0:(2*pi/(nfoci)):2*pi) - pi/2  ;
for k=1:nfoci
    rm(k,:) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0 ];
    rm(k,:) = rm(k,:) + focal_point + [ 0.00 0 0 ];
end
%%
%rm = focal_point;
p_control_xyz = rm';

% p_control_xyz = rm_pix;
% p_control_xyz(1,:) = pixel_size*(rm_pix(1,:) - Nx/2  );
% p_control_xyz(2,:) = pixel_size*(rm_pix(2,:) - Ny/2   );
% p_control_xyz(3,:) = pixel_size*(rm_pix(3,:) - 1);

%p_control_xyz = ( [0.00 0 r_foc] )';

M=size(p_control_xyz,2);

p_control=zeros(1,M);
p_control(:)=1e07;

uopt = get_transducer_vals( u_pos, f_o, rho, c, p_control_xyz, p_control );

%uopt(:)=1;
%%


u_amp = uopt';

xrange = [-1 1]*0.02 ;
yrange = [-1 1]*0.02 ;
zrange = r_foc + [-1 1]*0.03;

Nx=128;
Ny=128;
Nz=50;

xrp = linspace(xrange(1), xrange(2), Nx);
yrp = linspace(yrange(1), yrange(2), Ny);
zrp = linspace(zrange(1), zrange(2), Nz);

dSvox = [xrp(2)-xrp(1), yrp(2)-yrp(1), zrp(2) - zrp(1)];

focal_point_pix = floor( ([ 0.0 0 r_foc ] - [xrange(1), yrange(1), zrange(1)]) ./ dSvox)+1;

p = complex(zeros(Nx,Ny,Nz));

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
        
        p(:,:,:) = thisSource + p;
        
    end
    
    
end

%% plot

I=(( p.*conj(p)  ) / (2*rho_c) );

maxI= max(I(:));
newMaxI = 1e7;
I = I.*(newMaxI/maxI);
maxI = newMaxI;
halfmaxI = 0.5*maxI;

% jj=find(I > maxI);
% I(jj)=maxI;

figure(1);
clf;
hold on;

s=slice(gx,gy,gz, I, [] ,[], r_foc );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, I, [] ,[], r_foc-0.005 );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, I, 0 ,[], [] );
set(s,'EdgeColor','none');

%s=slice(gx,gy,gz, I, [], 0, [] );
%set(s,'EdgeColor','black');

daspect([1 1 1]);
%view([45 45]);

caxis([0.001*maxI maxI]);

%caxis([8.1762e+02 8.1762e+05]);

xticklabs = 100*linspace(xrange(1), xrange(2), 9);
xticks = xticklabs/(100) ;

%yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
yticklabs = 100*linspace(yrange(1), yrange(2), 9);
yticks = yticklabs/(100) ;

zticklabs = 100*linspace(zrange(1), zrange(2), 9);
zticks = zticklabs/(100) ;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',12);

xlabel(' [cm]', 'Fontsize', 12);
ylabel(' [cm]', 'Fontsize', 12);
zlabel(' [cm]', 'Fontsize', 12);

return;
%% Bioheat

freeOut=1;
%Free field acoustic intensity max in W/m^2 
%(i.e., amount of power absorbed if alpha=1.0/m)
newMaxI = 5e7;

maxI= max(I(:));
I = I.*(newMaxI/maxI);
maxI = newMaxI;
halfmaxI = 1.0*maxI;


nnx = 80;
nny = 80;
nnz = Nz;
tstep = 0.1;
Nt = 10;
T0=37;
Tb=37;
Cp = 3700;

ktherm = 0.5;
alpha = 0.5;

simDur=Nt*tstep;

% Total Simulation Duration 
totDur = 10;  %total time to "sonicate" in seconds

time=0;

perfusionrate = 0.01; %units of 1/seconds.  Temp loss rate will be proportional to perf.rate * (T-Tblood)

%[Iregrid, pixMultiplier, newIdims] = reduceScalarGridFunc( I, [Nx,Ny,Nz], [nnx,nny,nnz]);
[Iregrid, pixMultiplier, newIdims] = reduceTruncate3D( I, Nx, Ny, Nz, nnx, nny, nnz );
[nnx nny nnz]=size(Iregrid);
newDx = dSvox.*pixMultiplier;

%[Ton pixMult newDx tdotsrc Iregrid] = homogenousePBHE( T0, alpha, ktherm, rho, Cp, c, I, Nx, Ny, Nz, dSvox, nnx, nny, nnz, Nt, tstep, 1 );
[Ton pixMult newDx tdotsrc] = homogenousPerfusedPBHE( T0, alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );

[Nt nnx nny nnz]=size(Ton);

xrp = linspace(xrange(1), xrange(2), nnx);
yrp = linspace(yrange(1), yrange(2), nny);
zrp = linspace(zrange(1), zrange(2), nnz);
[tx, ty, tz] = meshgrid( yrp, xrp, zrp );


ThermDose = zeros(nnx,nny,nnz);

time = time + simDur;

zslice = round(nnz/2);

%%
time=simDur;
%[Iregrid, pixMultiplier, newIdims] = reduceScalarGridFunc( I, [Nx,Ny,Nz], [nnx,nny,nnz]);
[Iregrid, pixMultiplier, newIdims] = reduceTruncate3D( I, Nx, Ny, Nz, 100, 100, nnz );
% %Iregrid=Iregrid1;
% Tfinal=Tfinal1;
[Ton pixMult newDx tdotsrc] = homogenousePBHE( Tfinal, alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );
%%

figure(2);
clf;
imagesc( tdotsrc(:,:,zslice ) );

while( time < totDur )

    Rbase = 4.00*ones(Nt,nnx,nny,nnz);
    Rbase(Ton>=43) = 2.0;

    ThermDose = ThermDose + squeeze( sum( Rbase.^(Ton-43), 1 ) )*tstep;

    tempChange = squeeze( Ton(Nt,:,:,: ) ) - T0;
    
    figure(3);
    clf;
    hold on;

    s=slice(tx, ty, tz, tempChange, 0 ,[], [] );
    set(s,'EdgeColor','none');

    s=slice(tx, ty, tz, tempChange, [] ,[], r_foc );
    set(s,'EdgeColor','none');

    daspect([1 1 1]);
    view([30 50]);
    caxis([0 30]);
    
    
    figure(4);
    clf;
    hold on;

    s=slice(tx, ty, tz, ThermDose, 0 ,[], [] );
    set(s,'EdgeColor','none');

    s=slice(tx, ty, tz, ThermDose, [] ,[], r_foc );
    set(s,'EdgeColor','none');

    daspect([1 1 1]);
    view([30 50]);
    caxis([0 240]);

    %[Ton pixMult newDx tdotsrc] = homogenousePBHE( Ton(Nt,:,:,:), alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0 );

    [Ton pixMult newDx tdotsrc] = homogenousPerfusedPBHE( Ton(Nt,:,:,:), alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );

    
    
    time = time + simDur;
end

Tfinal=Ton(Nt,:,:,: );



%% -- 3D CEM contour

cemVal = 240;

figure(1);
clf;
hold on;

xplotr = [-0.011 0.011];
yplotr = xplotr;
axis([ xplotr yplotr .12 .16 0 1 ] );

%light('Position', [0.00 -0.001 0.14]);
light('Position', [0 -2 -1]);

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

xboxr=[-0.01 0.01]; yboxr=xboxr;
xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];
plot3( xyboxverts(1,:), xyboxverts(2,:), 0.15 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
plot3( xyboxverts(1,:), xyboxverts(2,:), 0.13 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
for i=1:4
    plot3( xyboxverts(1,[i i]), xyboxverts(2,[i i]), [0.13 0.15], 'LineStyle','--','LineWidth',2, 'Color', 'black' );

end



view([60 10]);


%lighting gouraud

%grid on;
%set(gca, 'GridLineStyle', 
daspect([1 1 1]);


xticklabs = (-1:0.5:1);
xticks = xticklabs/(100);

%yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
yticklabs = xticklabs;
yticks = yticklabs/(100) ;

zticklabs = 100*r_foc + (-2:0.5:2);
zticks = zticklabs/(100) ;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',12);

xlabel('X [cm]', 'Fontsize', 12);
ylabel('Y [cm]', 'Fontsize', 12);
zlabel('Axial [cm]', 'Fontsize', 12);












