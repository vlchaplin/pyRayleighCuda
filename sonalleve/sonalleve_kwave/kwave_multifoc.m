
%% kwave_multifoc.m
% This script creates a 2D simulation of a spherically-focused transducer
% with multiple elements. It shows you how to apply delays to multiple
% elements.
%
% The transducer geometry is arbitrary and is in the script generated below.

% The function 'get_transducer_vals' computes complex element amplitudes,
% from which you compute phase delays and then use sonication frequency to derive a time delay.
% 


%% define compute grid
Nz = 1024; %ctM          % number of grid points in the z (row) direction
Nx = 1024; %ctN           % number of grid points in the x (column) direction

Nz = 512; %ctM          % number of grid points in the z (row) direction
Nx = 512;

dz = 0.05e-3;
dx = 0.05e-3;

% Nz=412;
% Nx=412;
% 
% dx=.4e-3;
% dz=.4e-3;

simzp = (1:Nz)*dz;
simxp = (1:Nx)*dx - Nx*dx/2.0;


%% create the computational grid


%sonication axis will be in the z direction

kgrid = makeGrid(Nz, dz, Nx, dx);

% initially define the homogenous medium
% values are for humans...couldn't find mice yet
% taken from http://onlinelibrary.wiley.com/doi/10.1002/9780470561478.app1/pdf

% brain:  c = 1550 m/s,  density = 1.03 g/cm^3
% bone :  c = 4080 m/s,  density = 1.9 g/cm^3

c_brain = 1550; %m/s
rho_brain = 1.03e03; %kg/m^3

c_water = 1540;
rho_water = 1e03;

c_skull_max = 4080;
rho_skull_max = 1.9e3;

clear 'medium';

medium.sound_speed = c_water*ones(Nz, Nx); 	% [m/s] 
medium.density = rho_water*ones(Nz, Nx);               % kg/m^3

%change in impedance (membrane)
medium.sound_speed(Nz/2,:) = 1600;
medium.density(Nz/2,:) = 4100;

medium.BonA=10.0;

medium.alpha_power = 2;
medium.alpha_coeff = 0.5;% absorption coefficient [dB/(MHz^2 cm)]
medium.alpha_mode = 'no_dispersion';

%c_skull_max = c_water;
%rho_skull_max=rho_water;

 %% time grid defined (necessary to determine phase quantization on transducer elements)

[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed, [], 20e-6);

Nt=length(kgrid.t_array);

%% Transducer physical dims (pixel positions TBD below)

f0 = 1200e3;
w0 = 2*pi*f0;

trans_r_foc = 0.02;
trans_diam = trans_r_foc;

%trans_diam = 0.09;

trans_openang = asin( 0.5*trans_diam/trans_r_foc );
trans_depth = trans_r_foc*(1 - cos(trans_openang));

trans_section_length=trans_r_foc*2*trans_openang;

Nell=30;
elldiam=6.6e-3/5;
ellarc = trans_r_foc*asin(elldiam/trans_r_foc);

%in the setup coordinates, x (axis 1) is the transverse dimension and
% z (axis 3) is the sonication/hifu direction (transducer at z=0 and
% pointing up along +z).
uxyz2d = zeros([3 Nell]);
thetas=zeros([1 Nell]);

for n=1:Nell
    center_theta_n= -trans_openang + (n-0.5)*(2*trans_openang)/Nell;
    thetas(n)=center_theta_n;
    uxyz2d(:,n) = trans_r_foc*[sin(center_theta_n) 0.0 1-cos(center_theta_n)];
end

% in RELATIVE COORDINATES wrt TRANSDUCER (centered x,y,z=0 and pointing up)
foci=[ [0.004 0.0 trans_r_foc]' [-0.004 0.0 trans_r_foc]' ];
%foci=[ [0.02 0.0 trans_r_foc]'];

%compute complex array encoding 'uamp'
uamp = get_transducer_vals( uxyz2d, f0, mean(medium.density(:)), mean(medium.sound_speed(:)), foci, ones([1 size(foci,2)]) ); 
%normalize
uamp = uamp/sum(abs(uamp));

tth=linspace(-ellarc/2.0,ellarc/2.0,100)/trans_r_foc;
template2d = trans_r_foc*[sin(tth); zeros(size(tth)); 1-cos(tth);];

%compute relative delays and amplitudes
relative_amps = abs(uamp);
relative_delays_sec = (angle(uamp) + pi) /(2*pi*f0);
relative_delays_sec = dt*round(relative_delays_sec/dt);


%% Transducer element placement and source pressure defined

%center of the TRANSDUCER in SIMULATION COORDINATES (meters)
xdc_center_sim=[0.001 0.000];

%conversion from transducer body coordinates to simulation pixel
transducer2simpix = @(vec) [[floor((vec(3,:) + xdc_center_sim(1) - simzp(1))./dz)+1]; [floor( (vec(1,:) + xdc_center_sim(2)- simxp(1))./dx)+1 ]; ]

originPix=transducer2simpix([0. 0. 0.]');
ellcentersPix=transducer2simpix(uxyz2d)

[gz, gx] = meshgrid( simzp, simxp );
[ngz, ngx] = meshgrid( (1:Nz), (1:Nx) );

source.p_mask = zeros(Nz, Nx);

transducerLookup = zeros([Nz,Nx],'int32');

%this finds the pixels related adjacent to each element center
figure(1);
clf;
hold on;
for n=1:Nell
    Rn = rotmatZYZ(0.0, thetas(n), 0.0);
    
    ellextentpix = transducer2simpix(Rn*template2d  + repmat(uxyz2d(:,n),[1 size(template2d,2)]) ); 
    
    unii=sub2ind([Nz, Nx], ellextentpix(1,:), ellextentpix(2,:));
    source.p_mask(unii)=1;
    source.p_mask(ellcentersPix(1,n) , ellcentersPix(2,n))=1;
    
    %define a lookup to map active pixels to a transducer element number
    transducerLookup(unii) = n;
    transducerLookup(ellcentersPix(1,n) , ellcentersPix(2,n))=n;
end

activePixInds = find(source.p_mask);
numActiveSimPixels = length(activePixInds);

%source.p = zeros([numActiveSimPixels Nt]);

%will have size = [numActiveSimPixels Nt]


%total pressure across face (MPa) 
tot_source_pressure = 10e6;

src_pix_delays = relative_delays_sec(transducerLookup(activePixInds));
src_pix_MPa = relative_amps(transducerLookup(activePixInds));
src_pix_MPa = src_pix_MPa*(tot_source_pressure/numActiveSimPixels) / sum(src_pix_MPa(:));

source.p = repmat(src_pix_MPa, [1 Nt]) .* cos(2*pi*f0* (repmat(kgrid.t_array, [numActiveSimPixels 1]) + repmat(src_pix_delays, [1 Nt]))  );
%source.p = (tot_source_pressure/numActiveSimPixels) * cos(2*pi*f0*kgrid.t_array);

filtered_signal = filterTimeSeries(kgrid, medium, cos(2*pi*f0*kgrid.t_array));

%imagesc(source.p_mask)

source_press=zeros(size(source.p_mask));
source_press(activePixInds) = src_pix_MPa;
%% This just does a quick preview of the field using Rayleigh Sommerfeld 
figure(1);
clf;

uampTest=relative_amps .* exp(1j*2*pi*f0*relative_delays_sec);
un = repmat([0. 0. trans_r_foc]',[1 Nell]) - uxyz2d;
%the rayleigh sommerfeld part:
pp=calc_finitexdc_pressure_field_ndgrid( 2*pi*f0/mean(medium.sound_speed(:)), uampTest, uxyz2d, simxp, [0.0], simzp, un, [] );

imagesc(abs(squeeze(pp)')./max(abs(pp(:))), [0.0 0.01] );

 %% =============
% Sensor
% =============

mask_im = zeros([Nz,Nx]);


idx_sens_z = 1:Nz;
idx_sens_x = 1:Nx;

mask_im(idx_sens_z, idx_sens_x) = 1;

sensor_nz = length(idx_sens_z);
sensor_nx = length(idx_sens_x);

sensor.mask = mask_im;


%sensor.mask(:)=0;
%sensor.mask(382,333)=1;

%% sensor

% define the acoustic parameters to record
sensor.record = {'p_final', 'p_max', 'p_rms'};

%sensor.record = {'p'}; %<--- you will probably want to record the actual
%time series

input_args = {'PlotSim', true, 'DisplayMask', sensor.mask, 'DataCast', 'single', 'PMLInside', false, 'PlotPML', false,'PlotScale','auto','RecordMovie',true};

sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:} );

%save('h115_250kHz_skull_corrected.mat');
%% plot

p_rms = reshape(sensor_data.p_rms(:), sensor_nz, sensor_nx);

mask_im = logical(mask_im);

figure(2);
clf;
imagesc(p_rms);
%% This is some plotting stuff I used a long time ago, might not work now:

% convert pressure to Ispta
I=(p_rms);
I(:) = I(:)./(2*medium.sound_speed(mask_im).*medium.density(mask_im));

maxI = max(I(:));

%rescale Intensity for the sake of plotting 
%maxScale = max(max(I( tx_focal_point_pix(1)+(-10:10), tx_focal_point_pix(2)+(-10:10) )))
maxScale = max(I(:));
minI = min(I(:));
I = I/maxScale;

fieldImage = zeros([Nz Nx]);
fieldImage(logical(mask_im)) = I;
%fieldImage = fieldImage ./(2*medium.sound_speed(mask_im).*medium.density(mask_im));

%fieldImage = (1e6)^2*(1e-4)*fieldImage./(2*medium.sound_speed.*medium.density)

 figure(3);
 clf;
 hold on;
 
 %fieldImageRGB=ind2rgb(round(fieldImage*1024), jet(1024));
densityIm = medium.density /  max(medium.density(:));
 
 %densityImRGB=ind2rgb(round(1024*medium.density /  max(medium.density(:))) , gray(1024) );
 
 
 
 colormap('jet');
 fimh=imagesc(dx*(1:Nx)*1000, dz*(1:Nz)*1000, fieldImage, [0 1]);
 
 %caxis([0.001*maxI maxI]);
 
 %dimh=imagesc(dx*(1:Nx)*1000, dz*(1:Nz)*1000, medium.density);
 dimh=imagesc(dx*(1:Nx)*1000, dz*(1:Nz)*1000, repmat(0.6*densityIm, [1 1 3]));
 
 imagesc(dx*(1:Nx)*1000, dz*(1:Nz)*1000, repmat(source.p_mask, [1 1 3]), 'AlphaData', ( source.p_mask), 'AlphaDataMapping','none' );
 
 % colormap('gray');
 
 set(gca, 'Ydir', 'reverse');
 %imagesc(I)
 h = colorbar;
 ylabel(h,  'Relative Intensity');
 %caxis([0.001, 1]);
 axis equal;
 

xlabel('X [mm]', 'Fontsize', 12);
ylabel('Y [mm]', 'Fontsize', 12);


%%
figure(4);
%clf;
pathrows = 1 : tx_focal_point_pix(1) + 100;
pathz=pathrows*dz*1000;

impedanceProfile = medium.density( pathrows, tx_focal_point_pix(2)) .*  medium.sound_speed( pathrows, tx_focal_point_pix(2));

pfinProfile = sensor_data.p_final( pathrows, tx_focal_point_pix(2) );
p2finProfile = pfinProfile.^2;
Iprofile = p2finProfile./ impedanceProfile;

InormProfile = Iprofile/max(Iprofile);

func = pfinProfile;

subplot(121);
hold on;
cnoskull = [0.0 0.0 0.6];
c2 = [0.7 0.0 0.0];
rgb=cnoskull;
plot( pathz, pfinProfile, 'LineWidth', 1.5, 'Color', rgb )
%plot( pathzNoSkull, funcNoSkull, 'g' )
plot( pathz, skull_mask( pathrows, tx_focal_point_pix(2) ), 'k--' )

xlabel('mm')
ylabel('Pressure [MPa]')

subplot(122);

hold on;
plot( pathz, InormProfile, 'LineWidth', 1.5, 'Color', rgb )
plot( pathz, skull_mask( pathrows, tx_focal_point_pix(2) ), 'k--' )

xlabel('mm')
ylabel('Relative Intensity')