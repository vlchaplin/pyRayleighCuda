% contains variable xy_plane_max_pressure, dt,dx,dy,dz
load('xy_plane_max_pressure.mat');

onePlaneMat = xy_plane_max_pressure;
[Ny, Nx]=size(onePlaneMat);

x0init = round( sum( sum(onePlaneMat,1).*(1:Nx) ) / sum(onePlaneMat(:)) );
y0init = 160;%152;
subCols = x0init + (-40:40);
subRows = (Ny - length(subCols) + 1):Ny;
subRows = y0init:Ny;
onePlaneMat = onePlaneMat(subRows, subCols  );

%onePlaneMat=reduceTruncate2D( onePlaneMat, Ny, Nx, 40, 40 );

%grid resolution of pressure data (in meters)
Dx = [dx dy dz];

[Ny, Nx]=size(onePlaneMat);

%imagesc(onePlaneMat);

%x-position of +y focal axis (the rotational axis)

%x0 = round(Nx/2);

x0 = round( sum( sum(onePlaneMat,1).*(1:Nx) ) / sum(onePlaneMat(:)) );
%z-position of rotational axis
z0 = x0;

Nz = Nx;

rotatedField = zeros(Nx,Ny,Nz);

yvals = 1:Ny;
xvals = ((x0+1):Nx) - x0;
%xvals = (1:x0);
zvals = xvals;

nnx = length(xvals);
nnz = nnx;

[mx, mz] = meshgrid(xvals,zvals);

phis = atan(mz ./ mx );

cosphis = cos(-phis);
sinphis = sin(-phis);

mxo = round( mx.*cosphis - mz.*sinphis ) ;
mzo = round( mx.*sinphis + mz.*cosphis ) ;

ok = find( (mxo(:) <= nnx) & (mx(:) <= x0) & (mz(:) <= z0) );

mxo = mxo + x0;
mzo = mzo + z0;

nok = length(ok);

for y=1:Ny
    
    q = onePlaneMat(y,mxo(ok));
    
   % r = repmat(q, [1 1 nok]);
    
    ylist = repmat(y,[nok 1]);
   
    l = sub2ind([ Nx Ny Nz ],  mx(ok) + x0, ylist, mz(ok) + z0 );
    rotatedField(l) =  q;
    
    l = sub2ind([ Nx Ny Nz ],  x0 - mx(ok) + 1, ylist, mz(ok) + z0 );
    rotatedField(l) =  q;
    
    l = sub2ind([ Nx Ny Nz ],  x0 - mx(ok) + 1, ylist, z0 - mz(ok) + 1 );
    rotatedField(l) =  q;
     
     l = sub2ind([ Nx Ny Nz ], mx(ok) + x0, ylist, z0 - mz(ok) + 1 );
     rotatedField(l) =  q;
    
end

[gx, gy, gz] = meshgrid( 1:Ny, 1:Nx, 1:Nz );

figure (1);
clf;
hold on;

%approx_focus = [80 Ny/2 80];

s=slice(gx,gy,gz, rotatedField, 1 ,[], [] );
set(s,'EdgeColor','none');

 s=slice(gx,gy,gz, rotatedField, Nx ,[], [] );
 set(s,'EdgeColor','none');

s=slice(gx,gy,gz, rotatedField, [] ,Ny/2, [] );
set(s,'EdgeColor','none');

% s=slice(gx,gy,gz, rotatedField, approx_focus(1) ,[], [] );
% set(s,'EdgeColor','none');

s=slice(gx,gy,gz, rotatedField, [] ,[], round(Nz/2) );
set(s,'EdgeColor','none');

xlabel(' x', 'Fontsize', 12);
ylabel(' y', 'Fontsize', 12);
zlabel(' z', 'Fontsize', 12);

daspect([1 1 1]);
view([45 10]);

%% PID

ppi.nom = 6; %deg C
ppi.pgain = 0.001; 
ppi.igain = 0.00001;
ppi.dgain = 0.005;
ppi.cmin = 0;
ppi.cmax = 0.5; 


%% heating simulation

%normalize the pressure field to peak at 1.0... for easy re-calibration
normalizedPfield = rotatedField / max(rotatedField(:) );

Cp = 3700; %heat capacity J/(kg*C)
rho = 1000; % density (kg/m^3)
c = 1500; % sound speed m/s

alpha = 1.0; %acoustic absorption (1/m)
ktherm = 0.5;

% agarose...
%Cp = 2000;

vin2pascals = 24.4237e3; %Pa / mV for 1.1 MHz H101 transducer
Vin=0.01;
Vin_mV = 1000*Vin;
pnp_pascals = 24.4237e3 * Vin_mV;

Iunscaled = normalizedPfield .* conj(normalizedPfield) * (1.0 / (2.0*rho*c));

I = Iunscaled;


%simulated time between MRI acquisitions (time interval at which the
%controller is updated)

acq_interval = 2.0; %seconds.

total_time = 600; %seconds

%Upper limit of finite-difference computational grid size. Can't make it to large because
%of memory constrains.  4D grid = Nt*nnx*nny*nnz size. After
% homogenousPBHE() is run once, the grid size is trunctated to a more
% convenient value an updated.
%
nnx = 80;
nny = 80;
nnz = 80;
tstep = 0.1; %will be slightly changed if not a factor of acq_interval


%number of time steps per interval 
Nt = round(acq_interval/tstep);
tstep = acq_interval/Nt;

sprintf('# Time steps = %d', Nt)

T0=21; %initial ambient temperature of the object in C

time=0;




%run once with down-sampling
downsamp=1;
[T pixMult newDx tdotsrc Iregrid] = homogenousePBHE( T0, alpha, ktherm, rho, Cp, I, Nx, Ny, Nz, Dx, nnx, nny, nnz, Nt, tstep, downsamp );
%uPDATE grid size.  Nt doesn't change
[Nt, nnx, nny,nnz] = size(T);

%Iunscaled = Iregrid / max(Iregrid(:) );
Iunscaled = Iregrid;

zslice = round(nnz/2);

roi_x = 20:22;
roi_y = 2:20;
roi_z = zslice;

Tslice = squeeze( T(Nt,:,:, zslice ) ) - T0;

roiTavg = sum(sum( Tslice(roi_x,roi_y), 1), 2) / ( length(roi_x)*length(roi_y) );

roi_mask = zeros(nnx,nny);

roi_mask(roi_x(1), roi_y) = 1;
roi_mask(roi_x(end), roi_y) = 1;
roi_mask(roi_x, roi_y(1)) = 1;
roi_mask(roi_x, roi_y(end)) = 1;

time = time + tstep*Nt;

figure(3);
clf;
imagesc(tdotsrc(:,:,zslice), [0 0.1]);

%imagesc( squeeze( T(1,:,:,round(nnz/2) ) ), [37 38] );

    drawnow;
    
    cmin_temp = 0;
    cmax_temp = 10;
    
    
%turn off with down-sampling
downsamp=0;

clear('tvals'); clear('TempVals'); clear('Volts');

tvals(1) = time;
TempVals(1) = roiTavg;
Volts(1)=Vin;

while(time < total_time)
    
    [Vin, ppi] = piupdateMegan(Vin,roiTavg,ppi);
    %Vin=0.05;
    
    Vin_mV = 1000*Vin;
    pnp_pascals = 24.4237e3 * Vin_mV;
    Iregrid = Iunscaled * ((pnp_pascals^2) );
    
    %run again using the previous final T map as the initial condition. In
    %thise case 
    [T pixMult newDx tdotsrc] = homogenousePBHE( T(Nt,:,:,:), alpha, ktherm, rho, Cp, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, downsamp );
    
    Tslice = squeeze( T(Nt,:,:, zslice ) ) - T0;
    roiTavg = sum(sum( Tslice(roi_x,roi_y), 1), 2) / ( length(roi_x)*length(roi_y) );
    
    
    time = time + tstep*Nt;
    
    tvals(end+1) = time;
    TempVals(end+1) = roiTavg;
    Volts(end+1)=Vin;
    
    figure(2);
    clf;
   
    
    hi=imagesc( Tslice, [cmin_temp cmax_temp]);
    
    set(hi, 'AlphaData', 1-roi_mask, 'AlphaDataMapping','none');
    %imagesc(tdotsrc(:,:,round(nnz/2)), [0 0.02]);
    drawnow;
    
    figure(3);
    clf;
    plot( tvals, TempVals );
    figure(4);
    clf;
    plot( tvals, Volts, 'g');
    
    
end

figure(2);
    clf;
    
    Tslice = squeeze( T(Nt,:,:, zslice ) ) - T0;
    
    hi=imagesc( Tslice, [cmin_temp cmax_temp] );
    set(hi, 'AlphaData', 1-roi_mask, 'AlphaDataMapping','none');
    %imagesc(tdotsrc(:,:,round(nnz/2)) , [0 0.02]);
    drawnow;

%%

break;

xx = newDx(1)*((1:nnx)-nnx/2);
yy = newDx(2)*((1:nny));
zz = newDx(3)*((1:nnz)-nnz/2);
[gx, gy, gz] = meshgrid( yy, xx, zz );

figure (3);
clf;
hold on;

Tslice = squeeze( T(Nt,:,:,:) );

s=slice(gx,gy,gz, Tslice, yy(1) ,[], [] );
set(s,'EdgeColor','none');

 s=slice(gx,gy,gz, Tslice, yy(nny) ,[], [] );
 set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Tslice, [] , yy(round(nny/2)), [] );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Tslice, [] ,[], zz(round(nnz/2)) );
set(s,'EdgeColor','none');

xlabel(' x', 'Fontsize', 12);
ylabel(' y', 'Fontsize', 12);
zlabel(' z', 'Fontsize', 12);
daspect([1 1 1]);
caxis([37 50]);
