%
%
%  Simulate cavitation in the brain and look at high-pressure zones
%

clear all;

% =========================================================================
% SIMULATION
% =========================================================================



% ========================
% Create the space
% ========================

% create the computational grid
Nz = 256;           % number of grid points in the z (row) direction
Nx = 256;           % number of grid points in the y (column) direction
dx = 70e-6;        % grid point spacing in the x direction [m]
dz = 70e-6;        % grid point spacing in the y direction [m]
kgrid = makeGrid(Nz, dz, Nx, dx);

% initially define the homogenous medium
% values are for humans...couldn't find mice yet
% taken from http://onlinelibrary.wiley.com/doi/10.1002/9780470561478.app1/pdf

% brain:  c = 1550 m/s,  density = 1.03 g/cm^3
% bone :  c = 4080 m/s,  density = 1.9 g/cm^3

c_brain = 1550; %m/s
rho_brain = 1.03e03; %kg/m^3

c_bone = 4080;
rho_bone = 1.9e03;

medium.sound_speed = c_brain*ones(Nz, Nx); 	% [m/s] for brain
medium.density = rho_brain*ones(Nz, Nx);               % kg/m^3

%medium.alpha_coeff = 0.75;  % [dB/(MHz^y cm)]
%medium.alpha_power = 1.5;

c=c_brain;



% =======================
% Load data taken from the mouse CT
% =================
 C = importdata('C:\Users\vchaplin\Downloads\Passive cavitation\CAST-CAST_0366_skull_section.txt', '\t');
 dxCT = 35e-6;
 dzCT = 35e-6;
 %resample to simulation resolution
 resampDims = floor( size(C) .* [ dzCT/dz dxCT/dx ] );
 
 Cresamp = reduceDimensions(C, resampDims);
 
 %insert into simulation grid
 temp = zeros(Nz,Nx);
 temp( floor(Nz/2) - floor(resampDims(1)/2) : floor(Nz/2) + floor(resampDims(1)/2),  floor(Nx/2) - floor(resampDims(2)/2) : floor(Nx/2) + floor(resampDims(2)/2) ) = Cresamp;
 
 % locate the skull points
 ii = find(temp > 7000.0);
 
 %re-scale everything above a certain CT value so that the midpoint of the CT image equals the
 %average density for point
 
 

 medium.sound_speed(ii) = c_bone; 	
 medium.density(ii) = rho_bone;     

 1;
m=1;




% create the time array
[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed);


% =============
% Sensor
% =============

% define a binary sensor mask
% create the time-varying sensor mask. this will be an array of rectangular
% sensors 

% n_dets = 64;
% spacing_x = 30e-3/(n_dets-1); % spacing in the x direction [m]
% sensor_height = dz; % size of the sensor [m]
% sensor_width = dx; % sensor width [m]
% start_x_loc = 5e-3; % begin sensor array at this position [m]
% z_offset_from_bottom = 20*dz;
mask_im = zeros([Nz,Nx]);
% 
% for k=1:n_dets
%     cur_mask = makeRect(Nx,Nz,round((start_x_loc+(k-1)*spacing_x)/dx),Nz-round(z_offset_from_bottom/dz),round(sensor_height/dz),round(sensor_width/dx));
%     u_loc_x(k) = (start_x_loc+(k-1)*spacing_x);
%     u_loc_z(k) = z_offset_from_bottom;
%     mask_im = mask_im + cur_mask;
% end;

idx_sens_z = 40:(Nz - 40);
idx_sens_x = 40:(Nx - 40);
mask_im(idx_sens_z, idx_sens_x) = 1;

imagesc(mask_im,'Xdata',(1:Nz)*dz,'YData',(1:Nx)*dx);axis equal;

sensor.mask = mask_im;

% define the acoustic parameters to record
sensor.record = {'p', 'p_final'};


%===================
%      Source
%===================


% create a source using a bubble signal

% define a single source point
source.p_mask = zeros(Nz, Nx);
source.p_mask(Nz/2,Nx/2) = 1;
% define a time varying bubble oscillation
bubble_source=1;

if bubble_source==1
    
    % load bubble simulation data
    
    load('bubble_pressure')
    pressure(1:7) = zeros([1 7]);
    
    
    % resample to fit the time array and place into grid
    i_end = find(kgrid.t_array<timeaxis(end));
    
    YY = linterp(timeaxis,pressure,kgrid.t_array(1:i_end(end)));
    pressure_resam = [YY zeros([1 length(i_end:(length(kgrid.t_array)-i_end(end)))])];
    
    source.p = 100*pressure_resam;
    
else
    % define a time varying sinusoidal source
    source_freq = 0.25e6;   % [Hz]
    source_mag = 2;         % [Pa]
    source.p = source_mag*sin(2*pi*source_freq*kgrid.t_array(1:round(1/source_freq/dt)));
    source.p(round(1/source_freq/dt)+1:length(kgrid.t_array)) = zeros([1 (length(kgrid.t_array)-length(source.p))]);

end;

source.p = filterTimeSeries(kgrid, medium, source.p);


% 
% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);



Nt = length(kgrid.t_array);

Nsens_z = length(idx_sens_z);
Nsens_x = length(idx_sens_x);

resampDims = [Nz Nx]/4;

totMinP = min( sensor_data.p(:) );
totMaxP = max( sensor_data.p(:) );



pFieldVsTime = reshape( sensor_data.p(:, 1000), Nsens_z, Nsens_x);

colorMaxIdx = length(get(gcf,'Colormap'));

mappedImage = floor((colorMaxIdx-1)*(pFieldVsTime - totMinP) / ( totMaxP - totMinP )) + 1;

fh = image(mappedImage,'cdatamapping','direct');
set(fh,'EraseMode','Normal');

%fh2 = hist( pFieldVsTime(:), totMinP:0.1:totMaxP );

pixelMaxP = zeros(Nsens_z, Nsens_x);


for ti=1:Nt
   
    pFieldVsTime = reshape( sensor_data.p(:, ti), Nsens_z, Nsens_x);
    
    mappedImage = floor((colorMaxIdx-1)*(pFieldVsTime - totMinP) / ( totMaxP - totMinP )) + 1;
    
    set(fh, 'cdata', mappedImage);
    
    
    pause(0.01);
    
    
    
    for i=1:Nsens_z
       for j=1:Nsens_x
        
           if abs(pFieldVsTime(i,j)) > pixelMaxP(i,j)
               pixelMaxP(i,j) = pFieldVsTime(i,j);
           end
        
        end 
        
    end
    
    
    
    
end

figure;

mappedImage = floor((colorMaxIdx-1)*(pixelMaxP - totMinP) / ( totMaxP - totMinP )) + 1;

image(mappedImage,'cdatamapping','direct');

