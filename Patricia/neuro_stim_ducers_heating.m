load('neurostim_kwave_output.mat', 'source', 'sensor_data1', 'medium', 'kgrid');


downsamp=0;
freeOut=1;

bone_mask = medium.density > 1300;

%Even though the kwave sim was 2D the temperature calculation code needs to be 3D.
%But with correct boundary conditions the center z-slice will contain the correct temperature map
%corresponding to the 2D case

dz=0.0001;
Nz=6;
[Nx,Ny]=size(medium.density);

alpha = 0.5*ones([Nx,Ny,Nz]);
alpha(bone_mask) = 1.0;

rho = repmat(medium.density, 1,1,Nz);
cs = repmat(medium.sound_speed, 1,1,Nz);

Cp = 3700*ones([Nx Ny Nz]);
ktherm = 0.5;

duty_cycle = 0.5;
I = 1e12* repmat(sensor_data1.p_rms,1,1,Nz) ./ (2.0*rho.*cs);

perfusionrate=0;
TperfusionFluid=22;

Dx = [kgrid.dx kgrid.dy dz];

tstep=0.1;
Nt=20;

T0=22;

[T] = homogenousPerfusedPBHE( T0, alpha, ktherm, rho, Cp, cs, I, Nx, Ny, Nz, Dx, Nx, Ny, Nz, Nt, tstep, downsamp, TperfusionFluid, perfusionrate, freeOut );
