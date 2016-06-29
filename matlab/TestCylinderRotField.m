

%load('TransducerCalibSim.mat')

[Nx, Ny]=size(pmap);

Nz = Ny; % for x-axis rotation
%Nz = Nx; % for y-axis rotation
xp = 1:Nx;
yp = 1:Ny;
zp = 1:Nz; 

[tgx, tgy, tgz] = meshgrid( yp, xp, zp );

field = zeros(Nx,Ny,Nz);

phi = 0.1*pi;

sx = xp;
sy = xp*cos(phi);
sz = xp*sin(phi);

[xo, yo, vals]=cylindricalFieldFromSliceXY(sx,sy,sz,pmap', phi, 'x');


figure(1);
clf;
%imagesc(pmap, [0 1e6]);
hold on;
plot(xo, yo, 'r+');
plot(sx, sy, '-');

% 
 fig=figure(2);
 clf;
 imagesc(vals, [0 1e6]);
% hold on;
% 
% hsp = surface(xpp,ypp,zpp+z);
%         rotate(hsp,[1,0,0],40, [0.0, 0.0, z]);
%         xd = get(hsp,'XData');
%         yd = get(hsp,'YData');
%         zd = get(hsp,'ZData');
%         delete(hsp);
%         s=slice( tgx,tgy,tgz, TtimeSlice, xd, yd, zd );
%         set(s,'EdgeColor','none', 'FaceAlpha', 0.6);
% 
