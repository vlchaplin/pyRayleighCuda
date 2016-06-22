

c0 = 1520;
f_0=1.2e6;

w0 = f_0*(2*pi);
kr=w0/c0;

rho=1000;

pxyz = [ [0.0 0.0 0.14] ]';

nfoci=3;
d = 0.0065;
h=d*sin(pi/3);
pxyz = [[-d/2, -h/2, 0.14]; [d/2, -h/2, 0.14]; [0, h/2, 0.14]; ]';

%%
nfoci=3;
sep = 0.01;
pxyz = [ zeros(1,nfoci); ((1:nfoci)-0.5-nfoci/2)*sep; 0.14*ones(1,nfoci);  ];

%%
% nfoci=1;
% radius=0.000;
% pxyz = zeros(3,nfoci);
% thetas = (0:(2*pi/(nfoci)):2*pi) - pi/2  ;
% for k=1:nfoci
%     pxyz(:,k) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0.14 ];
% end
%%
M = size(pxyz,2);
pxyz = pxyz + repmat([0.00 0.00 0]',1,M);


pvalue = 1e7*ones([1 M]);

uxyz = get_sonalleve_transducers_xyz();
uamp = get_transducer_vals( uxyz,f_0,rho,c0,pxyz,pvalue);
%uamp = get_transducer_vals( uxyz,f_0,rho,c0, p_control_xyz, p_control);
%%
%uopt = get_transducer_vals( u_pos, f_o, rho, c, p_control_xyz, p_control );


simXp = 1e-3*(-20.0:0.25:20.0);
simYp = simXp;
simZp = 1e-3*(120:1.0:160.0);

N = 256;
unormals = repmat([0.0 0.0 0.14]', 1, N) - uxyz;

[ pn, near_field_mask, gx, gy, gz ] = calc_finitexdc_pressure_field_ndgrid( kr, uamp, uxyz, simXp, simYp, simZp, unormals, [] );


% re-normalize pn or intensity
p_peak = 1e6; %pascals 
pn = pn .* (p_peak / (max(abs(pn(:)))) );


%Inten = conj(pn).*pn /(2*rho*c0);
Inten = abs(pn);


Inten = Inten / max(Inten(:));

tx = 100*permute(gx,[2 1 3]);
ty = 100*permute(gy,[2 1 3]);
tz = 100*permute(gz,[2 1 3]);
pmIn = permute(Inten,[2 1 3]);




%%
figure(1);
clf;
hold on;


cmap=colormap('copper');
ncolors = size(cmap,1);

uampang = angle(uamp);
uangidx = ceil(ncolors*(uampang + pi )/(2*pi));

phis=pi*(0:0.2:1.8); mmm=length(phis);
disktemplate = 0.0033*[ cos(phis); sin(phis); phis*0 ];
patches = zeros(1,N);
for n=1:N
   
    [un_az,un_alt,un_r]=cart2sph(unormals(1,n), unormals(2,n), unormals(3,n));
    
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
    patchcoords = repmat(uxyz(:,n),1,mmm) + Rn'*disktemplate;
    
    cval=cmap(uangidx(n),:);
    

    patches(n)=patch( 100*patchcoords(1,:), 100*patchcoords(2,:), 100*patchcoords(3,:), cval, 'FaceAlpha',1.0);
    
end

xlabel('X [cm]', 'Fontsize', 24);
ylabel('Y [cm]', 'Fontsize', 24);
zlabel('Z [cm]', 'Fontsize', 24);
set(gca, 'FontSize',24);
daspect([1 1 1]);
axis tight;

%%
figure(1);
%clf;
hold on;
xlabel('X [cm]', 'Fontsize', 24);
ylabel('Y [cm]', 'Fontsize', 24);
zlabel('Z [cm]', 'Fontsize', 24);
set(gca, 'FontSize',24);
daspect([1 1 1]);

%light('Position', [0 1 15], 'Style', 'local');

%colormap( flipud( colormap('hot')) );
colormap( 'hot' );
%focSurf=slice( tx, ty, tz, pmIn, [], [], [12.0 13.0 14.0 15.0 16.0] );
focSurf=slice( tx, ty, tz, pmIn, [], [], [14.0] );
set(focSurf,'EdgeColor','none', 'Facecolor','flat','FaceLighting', 'gouraud','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
%focSurf.Parent = trans;

% focSurf2=slice( tx, ty, tz, pmIn, [], 0.0, []);
% set(focSurf2,'EdgeColor','none', 'Facecolor','flat','FaceLighting', 'gouraud','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);

caxis([-0.05 1.0]);

%%

cval=10.0^(-1/10.0);
p1=patch( isosurface( tx, ty, tz, pmIn, cval ) );
isonormals(tx, ty, tz, pmIn, p1);
set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 55, 'BackFaceLighting', 'unlit' ...
    );

cval = 10.0^(-3.0/10.0);
p2=patch( isosurface( tx, ty, tz, pmIn, cval ) );
isonormals(tx, ty, tz, pmIn,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 'yellow', 'EdgeColor', 'none','FaceAlpha',0.5, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

cval=10.0^(-6.0/10.0);
p3=patch( isosurface( tx, ty, tz, pmIn, cval ) );
isonormals(tx, ty, tz, pmIn,p3);
set(p3, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .7, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

%plot3([0 0], [0 0], [0 15], 'k--', 'LineWidth',1.0);

%legend([p1 p2 p3], {'-1 dB', '-3 dB', '-6 dB'})



%%

xp = (-6.0:0.01:6.0);
yp = (-6.0:0.01:6.0);
zp = (4.0:0.05:16.0);
[ yzPplane,nf,ndx,ndy,ndz  ] = calc_finitexdc_pressure_field_ndgrid( kr, uamp, uxyz, [0.0],1e-2*yp, 1e-2*zp, unormals, [] );

yzPplane = squeeze( permute(yzPplane,[2 1 3]) );

%%

colormap( flipud( colormap('gray')) );
caxis([-0.1 1.0]);
Iyz = conj(yzPplane).*yzPplane;
Iyz= Iyz/max(Iyz(:));
yzSurf=surf( zp,yp, zeros(size(Iyz)), Iyz);
set(yzSurf, 'EdgeColor', 'none');
yzSurf.Parent = hgtransform('Matrix', makehgtform('translate',[0 0 0],'zrotate',pi/2,'yrotate',-pi/2));


