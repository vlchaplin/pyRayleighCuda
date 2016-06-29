
file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
uxyz = get_sonalleve_transducers_xyz(file);
N = size(uxyz,2);
%% make the geometric focus be at 0,0,0
xdc_center = [0.0 0.0 -0.14]';
uxyz = uxyz - repmat(xdc_center,1,N);

f0 = 1.2e6;

%% Focal spot pattern
% Triangle
d = 3.5;
h = d*sin(pi/3);
z=0;
p_control_xyz = 1e-03*[[-d/2, -h/2, z]; [d/2, -h/2, z]; [0, h/2, z]; ]';

M = size(p_control_xyz,2);
p_control = 1e7*ones([1,M]);


%% grid and medium

simxr = [-0.065 0.065];
simyr = [-0.062 0.062];
%simxr = simyr;
simzr = [0 0.16];

dx = 0.0005;
dy = 0.0005;
dz = 0.0005;

simXp = simxr(1):dx:simxr(2);
simYp = simyr(1):dy:simyr(2);
simZp = simzr(1):dz:simzr(2);

simNx = length(simXp);
simNy = length(simYp);
simNz = length(simZp);

simxr(2) = simXp(end);
simyr(2) = simYp(end);
simzr(2) = simZp(end);


upix = floor((uxyz - repmat([simxr(1) simyr(1) simzr(1)]',1,N)) ./ ( repmat([dx dy dz]',1,N)))+1;
p_control_pix = floor((p_control_xyz - repmat([simxr(1) simyr(1) simzr(1)]',1,M)) ./ ( repmat([dx dy dz]',1,M)))+1;

c_water = 1540;
rho_water = 1000;
medium.sound_speed = ones([simNx simNy simNz])*c_water; % m/s sound speed in water
medium.density = ones([simNx simNy simNz])*rho_water; % kg/m^3 density of water

kgrid = makeGrid(simNx, dx, simNy, dy, simNz, dz);
[kgrid.t_array, dt] = makeTime(kgrid, medium.sound_speed,[],350e-06);

pamp = 0.5;
source.p = (pamp*sin(2*pi*f0*kgrid.t_array) );
source.p = filterTimeSeries(kgrid, medium, source.p);
 