% contains variable xy_plane_max_pressure, dt,dx,dy,dz
load('xy_plane_max_pressure.mat');

onePlaneMat = xy_plane_max_pressure;

%grid resolution of pressure data (in meters)
Dx = [dx dy dz];

[Ny, Nx]=size(onePlaneMat);

%imagesc(onePlaneMat);

%x-position of +y focal axis (the rotational axis)
x0 = round(Nx/2);
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

ok = find(mxo(:) <= nnx );

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

approx_focus = [80 Ny/2 80];

s=slice(gx,gy,gz, rotatedField, 1 ,[], [] );
set(s,'EdgeColor','none');

 s=slice(gx,gy,gz, rotatedField, Nx ,[], [] );
 set(s,'EdgeColor','none');

s=slice(gx,gy,gz, rotatedField, [] ,Ny/2, [] );
set(s,'EdgeColor','none');

% s=slice(gx,gy,gz, rotatedField, approx_focus(1) ,[], [] );
% set(s,'EdgeColor','none');

s=slice(gx,gy,gz, rotatedField, [] ,[], Nz/2 );
set(s,'EdgeColor','none');

xlabel(' x', 'Fontsize', 12);
ylabel(' y', 'Fontsize', 12);
zlabel(' z', 'Fontsize', 12);

daspect([1 1 1]);
view([45 10]);

%% heating simulation

%normalize the pressure field to peak at 1.0... for easy re-calibration
rotatedField = rotatedField / max(rotatedField(:) );

Cp = 3700; %heat capacity (J/kg*C)
rho = 1000; % density (kg/m^3)
c = 1500; % sound speed m/s

normalizedI = rotatedField.*conj(rotatedField)/(2.0*rho*c);


%simulated time between MRI acquisitions (time interval at which the
%controller is updated)

acq_interval = 4.0; %seconds


%Upper limit of finite-difference computational grid size. Can't make it to large because
%of memory constrains.  4D grid = Nt*nnx*nny*nnz size. After
% homogenousPBHE() is run once, the grid size is trunctated to a more
% convenient value an updated.
%
nnx = 90;
nny = 40;
nnz = 90;
tstep = 0.1; 

%number of time steps per numerical 
Nt = floor(acq_interval/tstep)+1;
sprintf('# Time steps = %d', Nt)

T0=37; %initial ambient temperature of the object in C


%run once
[T pixMult newDx tdotsrc] = homogenousePBHE( T0,1.0, rho, Cp, I, Nx, Ny, Nz, Dx, nnx, nny, nnz, Nt, tstep );

%uPDATE grid size.  Nt doesn't change
[Nt, nnx, nny,nnz] = size(T);

%%

xx = newDx(1)*((1:nnx)-nnx/2);
yy = newDx(2)*((1:nny));
zz = newDx(3)*((1:nnz)-nnz/2);
[gx, gy, gz] = meshgrid( yy, xx, zz );

figure (2);
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
