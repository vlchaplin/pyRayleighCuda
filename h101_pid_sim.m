
%% compile the C++ code (only need to do once or if there are any changes made to it)
%mex -outdir /home/poormame/Documents/bioheat/code/mex "/home/poormame/Documents/bioheat/code/BioHeatCpp/BioHeatCpp/PBHE_Perfused_mex.cpp"



%return 'nn' number of vectors that define the surface of the h-101
%transducer

% the transducer is modelled as a set of point sources

geometric_focal_length = 0.064;
transducer_opening_diameter = 0.0626;
[uxyz,nn] = stipled_spherecap(geometric_focal_length, transducer_opening_diameter, 200);


%% acoustic tissue properties
rho = 1000;  %density in kg/m^3
cs = 1540; %speed of sound in m/s
f0 = 1.1e6; %HIFU frequency in Hz
w0 = 2*pi*f0;
k0 = w0/cs; %wave number

%% set up space-time grid
dt = 0.1  %time-step of the finite-difference solver (in seconds)
dx = 2e-3; dy = dx; dz = dx;  %voxel size (in meters)

% FOV of the simulation (in meters)
xp = -0.02:dx:0.02;
yp = xp;
zp = 0.03:dz:0.09;

Nx = length(xp);
Ny = length(yp);
Nz = length(zp);
Nt = 10;

%% calculate acoustic pressure field using Rayleigh-Sommerfield theory

%make grid.  ndgrid will force us to permute afterwards.  but meshgrid
%would make it impossible to have different size dimensions
[gx, gy, gz] = ndgrid( xp, yp, zp );


pressure = zeros([Nx, Ny, Nz]);
for n=1:nn

    %compute distances from the nth point of the transducer to every grid
    %vertex
    d = sqrt( ( uxyz(1,n) - gx ).^2 + ( uxyz(2,n) - gy ).^2 + ( uxyz(3,n) - gz ).^2 );
    
    %acoustic pressure due to this part of the transducer
    thisSource = 1i*(rho*cs*k0/(2*pi))*exp(-1i*k0.*d)./d;
    
    pressure = thisSource + pressure;
end

vin2pascals = 24.4237e3; %Pa / mV for 1.1 MHz H101 transducer
Vin=0.01;
Vin_mV = 1000*Vin;
pnp_pascals = 24.4237e3 * Vin_mV;

% compute inensity as if the peak pressure at the focus were 1 Pa.  This
% allows us to use re-calibration later
normalizedPfield = pressure / max( pressure(:) );

%calculate intensity
Iunscaled = normalizedPfield .* conj(normalizedPfield) * (1.0 / (2.0*rho*cs));

% this might need to be commented if the output seems rotated by 90 degrees
Pm = [2 1 3];
mgx = permute(gx, Pm);
mgy = permute(gy, Pm);
mgz = permute(gz, Pm);
Iunscaled = permute(Iunscaled,[2 1 3]);

%% plot
figure(1);

plot3(100*uxyz(1,:), 100*uxyz(2,:), 100*uxyz(3,:),  '*' )

hold on;
s=slice(100*mgx,100*mgy,100*mgz, Iunscaled, [] ,[], 6.4 );
set(s,'EdgeColor','none','Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0);

s=slice(100*mgx,100*mgy,100*mgz, Iunscaled, [] ,0.0, [] );
set(s,'EdgeColor','none','Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0);


 %s=slice(gx,gy,gz, I, [], p_control_xyz(2)*100, [] );
 %set(s,'EdgeColor','none', 'Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0);

%plot3( ucenters_cm(1,:), ucenters_cm(2,:), ucenters_cm(3,:), '*');
daspect([1 1 1]);

xlabel('X [cm]', 'Fontsize', 14);
ylabel('Y [cm]', 'Fontsize', 14);
zlabel('Z [cm]', 'Fontsize', 14);

set(gca, 'FontSize',14);


%% define ROI for temperature monitoring

zslice = find(zp(2:end) >=0.064 & zp(1:end-1) < 0.064 );
roi_x = round(Nx/2)+1 + (-1:1);
roi_y = roi_x;
roi_z = zslice;

%% Thermal tissue properties
Cp = 3700; %heat capacity J/(kg*C)... water = 3700 

alpha = 0.5; %acoustic absorption (1/m)
ktherm = 0.5;

perfusionrate = 0.0;

%temperature of the perfusing fluid
TperfusionFluid = 37;

%% do the simulation

nnx = Nx; nny = Ny; nnz = Nz;

spatialResolution = [dx dy dz];

%run once with down-sampling
downsamp=1;

%freeOut is the boundary condition for heat-flow.  Setting to zero means heat does NOT freely-flow out  
freeOut=0;

T0 = 37;

[T pixMult newDx tdotsrc Iregrid] = homogenousPerfusedPBHE( T0, alpha, ktherm, rho, Cp, cs, Iunscaled, Nx, Ny, Nz, spatialResolution, nnx, nny, nnz, Nt, dt, downsamp, TperfusionFluid, perfusionrate, freeOut );

%Convert the unscaled intensity map to the re-gridded version
[Nt, nnx, nny,nnz] = size(T);
IunscaledRegrid = Iregrid;

roi_mask = zeros(nnx,nny);
roi_mask(roi_x(1)-1, roi_y) = 1;
roi_mask(roi_x(end)+1, roi_y) = 1;
roi_mask(roi_x, roi_y(1)-1) = 1;
roi_mask(roi_x, roi_y(end)+1) = 1;

totalTime = 200; %seconds

Vin = 0.15;

%set-up T0 for the initial run of the loop
T(Nt,:,:,:) = T0;

tvals=[];
TempVals=[];
Volts=[];

downsamp=0;
time=0;
while(time < totalTime)
    
    if (time > 100)
        Vin = 0;
    end
    
    %re-normalize the hifu intensity for this voltage setting
    Vin_mV = 1000*Vin;
    pnp_pascals = 24.4237e3 * Vin_mV;
    Iregrid = IunscaledRegrid * ((pnp_pascals^2) );
    
 
    [T pixMult newDx tdotsrc] = homogenousPerfusedPBHE( T(Nt,:,:,:), alpha, ktherm, rho, Cp, cs, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, dt, downsamp, TperfusionFluid, perfusionrate, freeOut );

    
    Tslice = squeeze( T(Nt,:,:, zslice ) ) - T0;
    roiTavg = sum(sum( Tslice(roi_x,roi_y), 1), 2) / ( length(roi_x)*length(roi_y) );
    
    
    time = time + dt*Nt;
    
    tvals(end+1) = time;
    TempVals(end+1) = roiTavg;
    Volts(end+1)=Vin;
  
end


%     figure(2);
%     clf;
%    
%     hi=imagesc( Tslice, [cmin_temp cmax_temp]);
%     
%     set(hi, 'AlphaData', 1-roi_mask, 'AlphaDataMapping','none');
    %imagesc(tdotsrc(:,:,round(nnz/2)), [0 0.02]);
    drawnow;
    
    figure(3);
    clf;
    subplot(211);
    plot( tvals, TempVals );
    subplot(212);
    plot( tvals, Volts, 'g');
    
  
