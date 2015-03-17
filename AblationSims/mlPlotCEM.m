filename='C:\\Users\\vchaplin\\Documents\\HiFU\\code\\AblationSims\\simdata\\cem_2.5mm_30000ms_I=1600_RT.hdf5'

CEM = h5read(filename,'/CEM');

xp = 100*h5readatt(filename,'/CEM','xp');
yp = 100*h5readatt(filename,'/CEM','yp');
zp = 100*h5readatt(filename,'/CEM','zp');


%% -- 3D CEM contour

cemVal1 = 240;
cemVal2 = 100;
cemVal3 = 20;

figure(1);
clf;
hold on;

xplotr = xp([1 end])';
yplotr = yp([1 end])';
zplotr = zp([1 end])';
%axis([ xplotr yplotr zplotr 0 1 ] );


%[tx, ty, tz] = meshgrid( xp, yp, zp );
[tx, ty, tz] = meshgrid( yp, zp, xp );
%[tx, ty, tz] = ndgrid( zp, xp, yp );

light('Position', [0 12 0], 'Style', 'local');
light('Position', [0 14 2], 'Style', 'local');
light('Position', [0 18 0], 'Style', 'local');

p1=patch( isosurface( tx, ty, tz, CEM, cemVal1 ) );
isonormals(tx, ty, tz, CEM, p1);

% p1=patch( isosurface(  CEM, cemVal1 ) );
% isonormals( CEM, p1);

set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 0.9, 'SpecularExponent', 25, 'BackFaceLighting', 'unlit' ...
    );

% xlabel('x [cm] (Sim Y)')
% ylabel('y [cm] (Sim Z)')
% zlabel('z [cm] (Sim X)')

[path,name,ext]=fileparts(filename)
title(name,'Interpreter','none')
xlabel('Y [cm] ')
ylabel('Z [cm] ')
zlabel('X [cm] ')


p2=patch( isosurface( tx, ty, tz, CEM, cemVal2 ) );
isonormals(tx, ty, tz, CEM,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.5, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


p3=patch( isosurface( tx, ty, tz, CEM, cemVal3 ) );
isonormals(tx, ty, tz, CEM,p3);
set(p3, 'Clipping', 'on', 'FaceColor', [0 0.8 0], 'EdgeColor', 'none','FaceAlpha',0.1, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


legend([p1 p2 p3], {sprintf('%dEM',cemVal1), sprintf('%dEM',cemVal2), sprintf('%dEM',cemVal3)})

%axis equal
axis equal tight

xboxr=[-1 1]; yboxr=xboxr;
xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];

zminverts = 13 + zeros(5);
zmaxverts = 15 + zeros(5);

%permut simulation coords sim X -> z, sim Y -> x, sim Z -> y

plot3( xyboxverts(2,:), zminverts, xyboxverts(1,:), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
plot3( xyboxverts(2,:), zmaxverts, xyboxverts(1,:), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
for i=1:4
    plot3( xyboxverts(2,[i i]), [zminverts(1) zmaxverts(1)], xyboxverts(1,[i i]), 'LineStyle','--','LineWidth',2, 'Color', 'black' );

end


%% -- 3D Temp contour

T = h5read(filename,'/Tfinal');

cemVal1 = 100;
cemVal2 = 65;
cemVal3 = 43;

figure(4);
clf;
hold on;

xplotr = xp([1 end])';
yplotr = yp([1 end])';
zplotr = zp([1 end])';
%axis([ xplotr yplotr zplotr 0 1 ] );


%[tx, ty, tz] = meshgrid( xp, yp, zp );
[tx, ty, tz] = meshgrid( yp, zp, xp );
%[tx, ty, tz] = ndgrid( zp, xp, yp );

light('Position', [0 12 0], 'Style', 'local');
light('Position', [0 14 2], 'Style', 'local');
light('Position', [0 18 0], 'Style', 'local');

p1=patch( isosurface( tx, ty, tz, T, cemVal1 ) );
isonormals(tx, ty, tz, T, p1);

% p1=patch( isosurface(  CEM, cemVal1 ) );
% isonormals( CEM, p1);

set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 0.9, 'SpecularExponent', 25, 'BackFaceLighting', 'unlit' ...
    );

% xlabel('x [cm] (Sim Y)')
% ylabel('y [cm] (Sim Z)')
% zlabel('z [cm] (Sim X)')

[path,name,ext]=fileparts(filename)
title(name,'Interpreter','none')
xlabel('Y [cm] ')
ylabel('Z [cm] ')
zlabel('X [cm] ')


p2=patch( isosurface( tx, ty, tz, T, cemVal2 ) );
isonormals(tx, ty, tz, T,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.5, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


p3=patch( isosurface( tx, ty, tz, T, cemVal3 ) );
isonormals(tx, ty, tz, T,p3);
set(p3, 'Clipping', 'on', 'FaceColor', [0 0.8 0], 'EdgeColor', 'none','FaceAlpha',0.1, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


legend([p1 p2 p3], {sprintf('%d C',cemVal1), sprintf('%d C',cemVal2), sprintf('%d C',cemVal3)})

%axis equal
axis equal tight

xboxr=[-1 1]; yboxr=xboxr;
xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];

zminverts = 13 + zeros(5);
zmaxverts = 15 + zeros(5);

%permut simulation coords sim X -> z, sim Y -> x, sim Z -> y

plot3( xyboxverts(2,:), zminverts, xyboxverts(1,:), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
plot3( xyboxverts(2,:), zmaxverts, xyboxverts(1,:), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
for i=1:4
    plot3( xyboxverts(2,[i i]), [zminverts(1) zmaxverts(1)], xyboxverts(1,[i i]), 'LineStyle','--','LineWidth',2, 'Color', 'black' );

end