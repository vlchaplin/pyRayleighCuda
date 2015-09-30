%interp3




xl = 1:10;
yl = 1:30;
zl = 1:40;

testField = zeros([length(xl) length(yl) length(zl)]);
[Nx Ny Nz] = size(testField);
testField(:,Ny/2,Nz/2+10) = 1;
testField(Nx/2,:,Nz/2) = 5;
testField(Nx/2,Ny/2,:) = 10; 

[mx,my,mz] = ndgrid(xl,yl,zl);

px = permute(mx, [2 1 3]);
py = permute(my, [2 1 3]);
pz = permute(mz, [2 1 3]);
fieldPermuted = permute(testField, [2 1 3]);



% [px,py,pz] = meshgrid(yl,xl,zl);
% fieldPermuted = testField;

figure(5);
clf; hold on;
% p1=patch( isosurface( px, py, pz, fieldPermuted, 1 ) );
% isonormals(px, py, pz, fieldPermuted,p1);
% set(p1, 'Clipping', 'on', 'FaceColor', 0.7*[1,0,0], 'EdgeColor', 'none','FaceAlpha',0.2, ...
%     'FaceLighting', 'flat', ...
%     'AmbientStrength', .5, 'DiffuseStrength', 1, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
%     );
% 
% p2=patch( isosurface( px, py, pz, fieldPermuted, 2 ) );
% isonormals(px, py, pz, fieldPermuted,p2);
% set(p2, 'Clipping', 'on', 'FaceColor', 0.7*[0,1,0], 'EdgeColor', 'none','FaceAlpha',0.5, ...
%     'FaceLighting', 'flat', ...
%     'AmbientStrength', .5, 'DiffuseStrength', 1, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
%     );
% 
% 
% p3=patch( isosurface( px, py, pz, fieldPermuted, 3 ) );
% isonormals(px, py, pz, fieldPermuted,p3);
% set(p3, 'Clipping', 'on', 'FaceColor', 0.7*[0,0,1], 'EdgeColor', 'none','FaceAlpha',1.0, ...
%     'FaceLighting', 'flat', ...
%     'AmbientStrength', .5, 'DiffuseStrength', 1, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
%     );


s=slice(px, py, pz, fieldPermuted, Nx/2, [], [] );
s=slice(px, py, pz, fieldPermuted, [], Ny/2, [] );
s=slice(px, py, pz, fieldPermuted, [], [], Nz/2 );
% %set(s,'EdgeColor','none', 'Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0);
% 

%sf = surf( xl, yl, zeros([Ny Nx]),fieldPermuted(:,:,Nz/2),  'EdgeColor','white'); 

%sf = surf( xl, yl, zeros([Ny Nx]),testField(:,:,Nz/2)',  'EdgeColor','white'); 
sf0 = surf( xl, zl, 5+ zeros([Nz Nx]),squeeze(testField(:,Ny/2,:))',  'EdgeColor','green'); 
sf2 = surf( xl, zl, 5+ zeros([Nz Nx]),squeeze(testField(:,Ny/2,:))',  'EdgeColor','green'); 

rotate(sf2, [1 0 0], 20, [0 0 5]);

xlabel('x');
ylabel('y');
zlabel('z');

axis equal tight;
