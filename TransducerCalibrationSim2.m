clear all;

% create the computational grid
Nz = 128;           % number of grid points in the z (row) direction
Ny = Nz;
Nx = Nz;           % number of grid points in the y (column) direction
dx = 800e-6;        % grid point spacing in the x direction [m]
dy = dx;
dz = dx;        % grid point spacing in the y direction [m]


medium.sound_speed = 1500; % m/s sound speed in water
medium.density = 1e03; % kg/m^3 density of water

kgrid = makeGrid(Nx, dx, Ny, dy, Nz, dz);
[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed);

Nt = length(kgrid.t_array);


% first define transduce geometry and place elemental sources in the kgrid
transducer_radius_m = (64e-03);
transducer_height_m = (63.2 - 51.74)*1e-03;

transducer_radius_pix = round( transducer_radius_m / dz );
transducer_height_pix = round( transducer_height_m / dx );

sphere = makeSphericalSection( transducer_radius_pix, transducer_height_pix );

[sx, sy, sz] = size(sphere);

source.p_mask = zeros(Nx,Ny,Nz);

%the transducer centroid touches x=0, and is centered in the y & z
%grid
ixstart = 1;
ixend = ixstart + sx-1;

iystart = floor(Ny/2 - sy/2);
iyend = iystart + sy-1;

izstart = floor(Nz/2 - sz/2);
izend = izstart + sz-1;

%update the source mask with the spherical section
source.p_mask( ixstart:ixend, iystart:iyend, izstart:izend ) = sphere; 


%transducer source parameters
freq = 1.1e6; %Hz
pressure = 3e5; % Pa

%trigger frequencey (freq. between bursts)
trigger_interval = 3e-05; %sec
trigger_freq = 1.0 / trigger_interval;

% define the burst and ramping function (logistic)
% logistic function takes about 10 cycles to ramp from 0->1, so the number
% of actual cycles the transducer takes to ramp up 
ncycles = 5;
rampup_ncyc = 2; %doesn't have to be integer

%trigger_mask = ( 1.0 ./ (1.0 + exp(-5.0 - (10.0/rampup_ncyc)*freq*kgrid.t_array) ) - 1.0 ./ (1.0 + exp(-5.0 - (10.0/rampup_ncyc)*(freq*kgrid.t_array-ncycles))) );
trigger_mask = zeros(1,Nt);

% this loop adds multiple bursts of length 'ncycles' to the input signal
% for each burst a logistic rampup/rampdown envelope is applied
trig_start = 0.0;
endtime = dt*Nt;
while trig_start < endtime
   
    nexttrig =  ( 1.0 ./ (1.0 + exp(-5.0 - (10.0/rampup_ncyc)*freq*(kgrid.t_array-trig_start)) ) - 1.0 ./ (1.0 + exp(-5.0 - (10.0/rampup_ncyc)*(freq*(kgrid.t_array-trig_start)-ncycles))) );
    trigger_mask = trigger_mask + nexttrig;
    
    trig_start = trig_start + trigger_interval;
end
%the starting phase of each burst is not exactly the same in this case...
%might want to change that
source.p = trigger_mask .* (pressure*sin(2*pi*freq*kgrid.t_array) );

source.p = filterTimeSeries(kgrid, medium, source.p);

figure;
plot( freq*kgrid.t_array, source.p );
xlabel('# cycles (freq * time)');
ylabel('Input pressure [Pa]');



sensor.mask = zeros(Nx,Ny,Nz);
sensor.mask(:,:, round(Nz/2) ) = 1;
sensor.record = {'p_max', 'p'};


input_args = {'PlotSim', true, 'DisplayMask', source.p_mask, 'DataCast', 'single', 'PMLInside', false, 'PlotPML', false};

% run the simulation
[sensor_data] = kspaceFirstOrder3D(kgrid, medium, source, sensor, input_args{:} );

%% plot
pmap = reshape(sensor_data.p_max(:), Nx, Ny);

figure;
imagesc(1e03*dx * (1:Nx), 1e03*dy*(1:Ny), transpose(pmap));
xlabel('x [mm]');
ylabel('y [mm]');

save('TransducerCalibSim.mat');

