filename='C:\Users\vchaplin\Documents\HiFU\hydrophone_H101\140723.155413.HydrophoneH101.txt';

[ vmin vpp dx dy dz ] = read_bibo_file( filename );

[nx ny nz] = size(vpp);

%x-y-z converted from pixel number to millimeters

udx = (dx*1e-07*1e03);
udy = (dy*1e-07*1e03);
udz = (dz*1e-06*1e03);
x = (1:nx)*udx;
y = (1:ny)*udy;
z = ((1:nz))*udz;  


%take vmin data and convert to pressure using the calibration data
%For 1.1MHz 

p = abs(vmin)*600/80;

[gx, gy, gz] = meshgrid(y,x,z);


%matlab is stupid wrt to column major stuff
s=surf(x,y, zeros(ny,nx)  );

rotate(s,[1,0,0],90);


xd = get(s,'XData');
yd = get(s,'YData');
zd = get(s,'ZData');

delete(s);

%h = slice(gx,gy,gz,vpp,xd,yd,zd);
%set(h,'FaceColor','interp','EdgeColor','none','DiffuseStrength',.8);
close all;
figure(2);
hold on;
slice(gx,gy,gz, p, [] , nx* udx,[]);
slice(gx,gy,gz, p, [] , nx/2*udx,[]);
slice(gx,gy,gz, p, [] ,udx, []);
slice(gx,gy,gz, p, [] ,[], udz);

slice(gx,gy,gz, p, 1*udy ,[],[]);

%axis equal;
daspect([1 1 1]);

%remember x-y are swapped
set(gca, 'FontSize',14);
xlabel('y [mm]', 'Fontsize', 18);
ylabel('x [mm]', 'Fontsize', 18);
zlabel('-z [mm]', 'Fontsize',18);