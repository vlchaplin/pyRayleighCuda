% Nx = 128;
% Ny = 256;


p_map = zeros(Nx, Ny);

%acoustic source positions
%pixel_size = 0.00025;

r_foc = 25.4e-3*2.5;
c = 1540; % m/s
f_o = 1.5e6; % Hz
w = 2*pi*f_o; % rad/sec

kr = w/c;

rho = 1000; %kg per m^3
rho_c_k = rho*c*kr;


%k-wave simulation stuff
medium.sound_speed = c; 	
medium.density = rho;
 
%source pmask
source.p_mask = zeros(Nx,Ny);

kgrid = makeGrid(Nx, pixel_size, Ny, pixel_size);
[kgrid.t_array, dt] = makeTime(kgrid, c);

normalized_mag = abs(uopt) / sum(abs(uopt(:) ));

%normalized_mag = ones(N,1);

sensor.record = { 'p_final'};
sensor.mask = ones(Nx,Ny);
%sensor.mask(Nx/2,Ny/2) = 1;
input_args = {'PlotSim', false, 'DisplayMask', 'off', 'DataCast', 'single', 'PMLInside', false, 'PlotPML', false};

p_fields = zeros(N,Nx,Ny);

for n=1:N
   
    theta = half_open_angle*(n - N/2)/N;
    di = focal_rad_in_pixels*sin(theta);
    dj = focal_rad_in_pixels*(1 - cos(theta));
    
    x = (di + center_point(1))*pixel_size;
    y = (dj + center_point(2))*pixel_size;
    
    i = floor(di + center_point(1));
    j = floor(dj + center_point(2));
    
    
    
    source.p_mask(i,j) = 1;
    
    source.p = normalized_mag(n)*sin(w*kgrid.t_array);
    source.p = filterTimeSeries(kgrid, medium, source.p);
    
    
    % run the simulation
    sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});
    
    %psum =  sum(sensor_data.p,2)  / kgrid.Nt;
    %psum = max(sensor_data.p');
    %psum = sensor_data.p(:,1000);
    
    p_map(:,:) = p_map(:,:) + sensor_data.p_final(:,:);
    
    p_fields(n,:,:) = sensor_data.p_final(:,:);
    
    sprintf('done n=%d',n)
    
   figure(1);
   I=log(( p_map.*p_map )+1);
   maxI= max(I(:));
   imagesc( transpose(I), [0 maxI*0.5] );
   axis equal;
   hold on;
   plot( i, j, '+w');
    
    source.p_mask(i,j) = 0;
end






nmags = abs(uopt) / sum(abs(uopt(:) ));
%nmags(:)=1;
p_map2 = zeros(Nx,Ny);
for n=1:N

   p_map2 = p_map2(:,:) +  squeeze(p_fields(n,:,:))*(nmags(n));
end

figure(2);
   I=(( p_map2.*p_map2  ));
   maxI= max(I(:));
   imagesc( transpose(I), [0 maxI*0.025] );
   axis equal;
   hold on;
