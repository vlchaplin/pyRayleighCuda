% Create a spherically focused single element transducer and simulate
% sinusoidal output

% Create the computational grid

clear all;


% =========================================================================
% SIMULATION
% =========================================================================

%% grid and medium characteristics

% create the computational grid
Nx = 512;           % number of grid points in the x (row) direction
Ny = 512;           % number of grid points in the y (column) direction
%Nz = 128;
dx = 0.2e-3;    	% grid point spacing in the x direction [m]
dy = dx;            % grid point spacing in the y direction [m]
%dz = dx;
kgrid = makeGrid(Nx, dx, Ny, dy);

% define the properties of the propagation medium
medium.sound_speed = 1481*ones(Nx,Ny);% [m/s]
medium.sound_speed(70:169,:)= 1560;   % speed through 1st phantom
medium.sound_speed(170:179,:)=2240;    % speed through skull Table 4.3a Duck paper pg 82, .5MHz
medium.sound_speed(180:279,:)=1560;   %speed through 2nd phantom]
medium.sound_speed_ref = 1481;
medium.density = 1000*ones(Nx,Ny);     %denisty in kg/m^3
medium.density(170:179,:)= 1610;      %density of skull Duck pg 140, table 5.2 cranium
medium.density(70:169,:) = 1040;
medium.density(180:279,:) = 1040;
% create the time array
[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed);
Nt = length(kgrid.t_array);

%% sources

% create a concave source
%radius = round(50.8e-3/dx); % radius in mm
radius = 254;
%height = round(9.7e-3/dx);
%height = round(0.03e-3/dx*25.4);
my_angle = 33;
ss = makeCircle(Nx,Ny,0,0,radius,my_angle*pi/180);
%size(ss)*dx/25.4e-3

% add it to a mask of the correct size
source.p_mask = zeros(Nx, Ny);
[a,b] = size(ss);
sphere_offset = 0;
source.p_mask((1:a),(1:b)) = ss;
source.p_mask = imrotate(source.p_mask,-(90-my_angle/2),'crop')
xaxis = (-Nx/2*dx:dx:dx*(Nx/2-1))*1e3;
yaxis = (-Ny/2*dy:dy:dy*(Ny/2-1))*1e3;
imagesc(source.p_mask,'XData',xaxis,'YData',yaxis);axis equal;

% define a time varying sinusoidal source
source_freq = 0.5e6;       % [Hz]
source_mag = .5;           % [Pa]
source.p = source_mag*sin(2*pi*source_freq*kgrid.t_array);

% filter the source to remove any high frequencies not supported by the grid
source.p = filterTimeSeries(kgrid, medium, source.p);

%% create sensor

% create a sensor mask covering the entire computational domain
sensor.mask = ones(Nx, Ny);

% set the record mode capture the final wave-field and the statistics at
% each sensor point 
sensor.record = {'p_final', 'p_max', 'p_rms'};


%% run simulation



% run the first simulation
%source.p_mask = source1;
%input_args = {'PMLSize', 10, 'DataCast', 'gpuArray-single', 'PlotSim', true};
input_args = {'PMLSize', 10, 'DataCast', 'single', 'PlotSim', true, 'DisplayMask', source.p_mask};
sensor_data1 = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});


% reshape the sensor data
sensor_data1.p_max = reshape(sensor_data1.p_max, Nx, Ny);
sensor_data1.p_rms = reshape(sensor_data1.p_rms, Nx, Ny);

%% show result

xaxis = (-Nx/2*dx:dx:dx*(Nx/2-1))*1e3;
yaxis = (-Ny/2*dy:dy:dy*(Ny/2-1))*1e3;
imagesc(sensor_data1.p_rms,'XData',xaxis,'YData',yaxis);axis equal;

save('neurostim_kwave_output.mat', 'source', 'sensor_data1', 'medium', 'kgrid');
