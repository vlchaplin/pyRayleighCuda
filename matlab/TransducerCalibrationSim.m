

% ========================
% Create the space
% ========================

clear all;

% create the computational grid
Nz = 140;           % number of grid points in the z (row) direction
Ny = Nz;
Nx = Nz;           % number of grid points in the y (column) direction
dx = 400e-6;        % grid point spacing in the x direction [m]
dy = dx;
dz = dx;        % grid point spacing in the y direction [m]
kgrid = makeGrid(Nx, dx, Ny, dy, Nz, dz);

medium.sound_speed = 1540; % m/s sound speed in water
medium.density = 1e03; % kg/m^3 density of water


% define properties of the input signal
source_strength = 1e5;          % [Pa]
tone_burst_freq = 1.1e6;        % [Hz]
tone_burst_cycles = 20;



% create the time array
[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed);


% create the input signal using toneBurst 
input_signal = toneBurst(1/dt, tone_burst_freq, tone_burst_cycles);


% physical properties of the transducer
transducer.number_elements = round( 0.064 / dx );    % total number of transducer elements
transducer.element_length = transducer.number_elements;     % length of each element [grid points]
transducer.element_width = 1;       % width of each element [grid points]
transducer.element_spacing = 0;     % spacing (kerf width) between the elements [grid points]
transducer.radius = inf;            % radius of curvature of the transducer [m]

transducer_width = transducer.number_elements * transducer.element_width;

transducer.sound_speed = 1540;              % sound speed [m/s]
transducer.focus_distance = transducer.radius;          % focus distance [m]
%transducer.focus_distance = 10e-3;
transducer.steering_angle = 0;              % steering angle [degrees]

% use this to position the transducer in the middle of the computational grid
transducer.position = round([1, Ny/2 - transducer_width/2, Nz/2 - transducer.element_length/2]);

%transducer.position = [1,1,1];

% append input signal used to drive the transducer
transducer.input_signal = input_signal;

%transducer.active_elements = 1;

% create the transducer using the defined settings
transducer = makeTransducer(kgrid, transducer);
%makeSphere
%%

sensor.mask = zeros(Nx,Ny,Nz);
sensor.mask(:,:, Nz/2) = 1;
sensor.record = {'p_final', 'p_max', 'p_rms'};

input_args = {'PlotSim', false, 'PlotScale', [-0.2 0.2],'DataCast', 'single','DisplayMask', source.p_mask, 'PMLInside', false, 'PlotPML', false};

% run the simulation
[sensor_data] = kspaceFirstOrder3D(kgrid, medium, transducer, sensor );

pmap = reshape(sensor_data.p_max(:), Nx, Ny);

