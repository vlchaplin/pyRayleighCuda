file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
uxyz = get_sonalleve_transducers_xyz(file)

N=256;

ROC = 0.14;
trans_element_radius = 0.003;

unormals = repmat([0.0 0.0 ROC]',1,N) - uxyz

phis=pi*(0:0.2:1.8); mmm=length(phis);
disktemplate = trans_element_radius*[ cos(phis); sin(phis); phis*0 ];
patchcoords = zeros(3,mmm);
patches = zeros(1,N);

figure(1);
clf;
hold on;

for n=1:N
   
    
    [un_az,un_alt,un_r]=cart2sph(unormals(1,n), unormals(2,n), unormals(3,n));
    
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
    patchcoords = repmat(uxyz(:,n),1,mmm) + Rn'*disktemplate;
    cval=[0.0 1 0.5];
    if n==1 || n==2
        %cval=[1 0 0];
    end
    patches(n)=patch( patchcoords(1,:), patchcoords(2,:), patchcoords(3,:), cval, 'FaceAlpha',1.0);
    
end

da = 0.0035;
db = 0.0035;
rmax = 0.02;
ecc = da/db;
tmax0 = 60.0;

omega0 = (rmax^2)*ecc*pi/tmax0;
dwell_time0=0.5;
t0 = 0:dwell_time0:tmax0;

ksi = sqrt((4*pi*omega0/(ecc*da*da))*t0);

x0 = da*(ksi/(2*pi)).*cos(ksi);
y0 = db*(ksi/(2*pi)).*sin(ksi);
z0 = ROC*ones(size(x0));
plot3(x0,y0,z0, 'k-', 'LineWidth', 1.0)

axis equal
axis off

