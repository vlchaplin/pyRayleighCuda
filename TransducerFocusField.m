%mex -IC:\Users\vchaplin\Documents\HiFU\code\BioHeatCpp\BioHeatCpp 'C:\Users\vchaplin\Documents\HiFU\code\RSAcoustics\RSAcoustics\RSTransducerFieldMEX.cpp'


%% physics params


f_o = 1.2e6; % Hz
w = 2*pi*f_o; % rad/sec

c = 1540; % m/s
kr = w/c;

% 
rho = 1000; %kg per m^3
rho_c = rho*c;
rho_c_k = rho*c*kr;

%% Trasnducer element positions
file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
u_pos = get_sonalleve_transducers_xyz(file);

trans_element_radius = 0.0033;
trans_element_area = pi*trans_element_radius^2;
r_foc = 0.14;
z_face = max(u_pos(3,:)) + 0.01;

focal_point = [ 0.0 0 r_foc-0.00 ];

N = size(u_pos,2);

%% Sub-sample template to sub-sample each transducer element (approximation to Huygen's principle)
%  Each element is modelled as a flat disk

nr = 1;
dr = trans_element_radius/nr;
nphi = 1 + floor(2*pi*((1:nr)-1) ) ;
nsubsamp = sum(nphi);

usub_coords_model=zeros(3,nsubsamp);
usub_coords = zeros(3,nsubsamp);
nn=0;
for i=1:nr
   
    r = (i-1)*dr;
    dphi = (2*pi/nphi(i));

    for j=1:nphi(i)
        
        phi = dphi*(j-1);
        nn=nn+1;
        
        usub_coords_model(:,nn) = [ r*cos(phi) r*sin(phi) 0 ];
        
    end
    
end

%% Control points

cdis = 0.0035;
rm = [ [cdis -cdis focal_point(3)]; [0 .005 focal_point(3)];  [-cdis -cdis focal_point(3)];  ];

rm = [ [0 0 0.12 ]; [0 0 0.16]; ];

model_translate = [0.00 0.00 0];

for k=1:2
    
    rm(k,:) = (rm(k,:) + model_translate);
end


%% equilateral triangle in XY plane
nfoci=3;
d = 0.0035;
h=d*sin(pi/3);
rm = [[-d/2, -h/2, 0]; [d/2, -h/2, 0]; [0, h/2, 0]; ];
center = mean(rm,1);
R = rotmatZYZ(0,0,0);
for k=1:nfoci
    rm(k,:) = (rm(k,:) - center)*R + focal_point;
end
%% disk around focus in X-Y plane
nfoci=3;
radius=0.004;
h=radius/2;
rm = zeros(nfoci,3);
thetas = (0:(2*pi/(nfoci)):2*pi) - pi/2  ;
for k=1:nfoci
    rm(k,:) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0 ];
    rm(k,:) = rm(k,:) + focal_point + [ 0.00 0 0 ];
end
%%
%rm = focal_point;
p_control_xyz = rm';

% p_control_xyz = rm_pix;
% p_control_xyz(1,:) = pixel_size*(rm_pix(1,:) - Nx/2  );
% p_control_xyz(2,:) = pixel_size*(rm_pix(2,:) - Ny/2   );
% p_control_xyz(3,:) = pixel_size*(rm_pix(3,:) - 1);

%p_control_xyz = ( [0.00 0 r_foc] )';

M=size(p_control_xyz,2);

p_control=zeros(1,M);
p_control(:)=1e07;

uopt = get_transducer_vals( u_pos, f_o, rho, c, p_control_xyz, p_control );

%uopt(:)=1;
%%


u_amp = uopt';

xrange = [-2 2]*0.01 ;
yrange = [-2 2]*0.01 ;
zrange = r_foc + [-3.5 2.5]*0.01;

Nx=100;
Ny=100;
Nz=100;

xrp = linspace(xrange(1), xrange(2), Nx);
yrp = linspace(yrange(1), yrange(2), Ny);
zrp = linspace(zrange(1), zrange(2), Nz);

dSvox = [xrp(2)-xrp(1), yrp(2)-yrp(1), zrp(2) - zrp(1)];

focal_point_pix = floor( (focal_point - [xrange(1), yrange(1), zrange(1)]) ./ dSvox)+1;

p = complex(zeros(Nx,Ny,Nz));

[gx, gy, gz] = meshgrid( yrp, xrp, zrp );

for n=1:N
    

    x=u_pos(1,n);
    y=u_pos(2,n);
    z=u_pos(3,n);
    
    unormal = focal_point - [x y z];
    
    [un_az,un_alt,un_r]=cart2sph( unormal(1), unormal(2), unormal(3) );
     
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);

    nth_integrand_coeff = (trans_element_area/nsubsamp)*uopt(n)*1i*rho_c_k/(2*pi);
    
    for j=1:nsubsamp
       
        elpos = [x y z]' + Rn'*usub_coords_model(:,j) - dSvox'/2.0;

        d=sqrt( (elpos(1) - gx).^2 + (elpos(2) - gy).^2 + (elpos(3) - gz).^2 );
    
        thisSource = nth_integrand_coeff.*exp(-1i*kr.*(d))./d;
        
        
        p(:,:,:) = thisSource + p;
        
        
    end
    
    
end

%% plot

I=(( p.*conj(p)  ) / (2*rho_c) );

maxI= max(I(:));
newMaxI = 1e7;
I = I.*(newMaxI/maxI);
maxI = newMaxI;
halfmaxI = 0.5*maxI;

% jj=find(I > maxI);
% I(jj)=maxI;

Idb = 10*log10(I/maxI);
Idb =I;
figure(1);
clf;
hold on;
colormap('hot');
s=slice(gx,gy,gz, Idb, [] ,[], r_foc );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Idb, [] ,[], r_foc-0.005 );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Idb, 0 ,[], [] );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Idb, [], 0, [] );
set(s,'EdgeColor','none');

s=slice(gx,gy,gz, Idb, [], h/2 + dSvox(2), [] );
set(s,'EdgeColor','none');

daspect([1 1 1]);
%view([45 45]);

caxis([0.001*maxI maxI]);
%caxis([-20 0]);
%caxis([8.1762e+02 8.1762e+05]);

xticklabs = 100*linspace(xrange(1), xrange(2), 9);
xticks = xticklabs/(100) ;

%yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
yticklabs = 100*linspace(yrange(1), yrange(2), 9);
yticks = yticklabs/(100) ;

zticklabs = 100*linspace(zrange(1), zrange(2), 9);
zticks = zticklabs/(100) ;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',12);

xlabel(' [cm]', 'Fontsize', 12);
ylabel(' [cm]', 'Fontsize', 12);
zlabel(' [cm]', 'Fontsize', 12);

return;
%% Bioheat

freeOut=1;
%Free field acoustic intensity max in W/m^2 
%(i.e., amount of power absorbed if alpha=1.0/m)
newMaxI = 1.0e7;

maxI= max(I(:));
I = I.*(newMaxI/maxI);
maxI = newMaxI;
halfmaxI = 1.0*maxI;


nnx = 80;
nny = 80;
nnz = Nz;
tstep = 0.1;
Nt = 10;
T0=37;
Tb=37;
Cp = 3700;

ktherm = 0.5;
alpha = 2.0;

simDur=Nt*tstep;

% Total Simulation Duration 
totDur = 30.0;  %total time to "sonicate" in seconds

time=0;

perfusionrate = 0.00; %units of 1/seconds.  Temp loss rate will be proportional to perf.rate * (T-Tblood)

%[Iregrid, pixMultiplier, newIdims] = reduceScalarGridFunc( I, [Nx,Ny,Nz], [nnx,nny,nnz]);
[Iregrid, pixMultiplier, newIdims] = reduceTruncate3D( I, Nx, Ny, Nz, nnx, nny, nnz );
[nnx nny nnz]=size(Iregrid);
newDx = dSvox.*pixMultiplier;

%[Ton pixMult newDx tdotsrc Iregrid] = homogenousePBHE( T0, alpha, ktherm, rho, Cp, c, I, Nx, Ny, Nz, dSvox, nnx, nny, nnz, Nt, tstep, 1 );
[Ton pixMult newDx tdotsrc] = homogenousPerfusedPBHE( T0, alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );

[Nt nnx nny nnz]=size(Ton);

xrp = linspace(xrange(1), xrange(2), nnx);
yrp = linspace(yrange(1), yrange(2), nny);
zrp = linspace(zrange(1), zrange(2), nnz);
[tx, ty, tz] = meshgrid( yrp, xrp, zrp );


ThermDose = zeros(nnx,nny,nnz);

time = time + simDur;

zslice = round(nnz/2);

%%
time=simDur;
%[Iregrid, pixMultiplier, newIdims] = reduceScalarGridFunc( I, [Nx,Ny,Nz], [nnx,nny,nnz]);
[Iregrid, pixMultiplier, newIdims] = reduceTruncate3D( I, Nx, Ny, Nz, 100, 100, nnz );
% %Iregrid=Iregrid1;
% Tfinal=Tfinal1;
[Ton pixMult newDx tdotsrc] = homogenousePBHE( Tfinal, alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );
%%

% figure(2);
% clf;
% imagesc( tdotsrc(:,:,zslice ) );
TempAvg=[];
timeEnds=[];

while( time < totDur )

    disp(time);
    Rbase = 4.00*ones(Nt,nnx,nny,nnz);
    Rbase(Ton>=43) = 2.0;

    ThermDose = ThermDose + squeeze( sum( Rbase.^(Ton-43), 1 ) )*tstep;

    tempChange = squeeze( Ton(Nt,:,:,: ) ) - T0;
%     
%     figure(3);
%     clf;
%     hold on;
%     colormap('hot');
%     s=slice(tx, ty, tz, tempChange, 0 ,[], [] );
%     set(s,'EdgeColor','none');
% 
%     s=slice(tx, ty, tz, tempChange, [] ,[], focal_point(3) );
%     set(s,'EdgeColor','none');
% 
%     daspect([1 1 1]);
%     view([30 50]);
%     caxis([0 20]);
%     
%     
%     figure(4);
%     clf;
%     hold on;
% 
%     s=slice(tx, ty, tz, ThermDose, 0 ,[], [] );
%     set(s,'EdgeColor','none');
% 
%     s=slice(tx, ty, tz, ThermDose, [] ,[], focal_point(3) );
%     set(s,'EdgeColor','none');
% 
%     daspect([1 1 1]);
%     view([30 50]);
%     caxis([0 240]);

    %[Ton pixMult newDx tdotsrc] = homogenousePBHE( Ton(Nt,:,:,:), alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0 );

    [Ton pixMult newDx tdotsrc] = homogenousPerfusedPBHE( Ton(Nt,:,:,:), alpha, ktherm, rho, Cp, c, Iregrid, nnx, nny, nnz, newDx, nnx, nny, nnz, Nt, tstep, 0, Tb, perfusionrate, freeOut );

    TempAvg(end+1) = mean(Ton(Nt,:));
    timeEnds(end+1) = time;
    time = time + simDur;
end

Tfinal=Ton(Nt,:,:,: );

%%
figure(6);
clf;
hold on;
subplot(121);
colormap('hot');
imagesc(  xrp*1e2, yrp*1e2, tempChange(:,:,focal_point_pix(3))', [0 30] );
%imagesc( xrp*1e3, yrp*1e3, tempChange(:,:,focal_point_pix(3)), [0 20] );

%axis equal tight;
%axis([-50 50 -50 50]);
set(gca, 'YDir', 'normal','FontSize',24);
xlabel('x [cm]','FontSize',24);
ylabel('y [cm]','FontSize',24);
cbar=colorbar('Location', 'southoutside');
cbar.Label.String = '\Delta T (^oC)';
cbar.FontSize = 24;

subplot(122);
colormap('hot');
imagesc( yrp*1e2, zrp*1e2, squeeze(tempChange(27,:,:))', [0 30] );
%imagesc( xrp*1e3, yrp*1e3, tempChange(:,:,focal_point_pix(3)), [0 20] );
axis equal tight;
set(gca, 'YDir', 'normal', 'FontSize',24);
%axis([-50 50 -50 50]);
xlabel('y [cm]','FontSize',24);
ylabel('z [cm]','FontSize',24);
cbar=colorbar('Location', 'eastoutside');
cbar.Label.String = '\Delta T (^oC)';
cbar.FontSize = 24;

%% layers
figure(8);
clf;
hold on;

[rgx,rgy,rgz]=ndgrid(xrp*1e2,yrp*1e2,zrp*1e2);

rgx=permute(rgx,[2 1 3]);
rgy=permute(rgy,[2 1 3]);
rgz=permute(rgz,[2 1 3]);
colormap( 'hot' );
focSurf=slice( rgx, rgy, rgz, tempChange, [], [], [14.0] );
set(focSurf,'EdgeColor','none', 'Facecolor','flat','FaceLighting', 'gouraud','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);


axis equal tight;

set(gca, 'FontSize',24);
xlabel('cm','FontSize',24);
ylabel('cm','FontSize',24);
zlabel('z [cm]','FontSize',24);

caxis([0 30]);

%% 3D roi contour
% figure(2);
% clf;
% hold on;

%def inEllipse(x,y,z,a=0.005,b=0.005,c=0.005):
%return np.sqrt((x/a)**2 + (y/b)**2 + (z/c)**2)<=1.0
a_cm=.5;b_cm=.5;c_cm=1.0;

roiSurfX = (-2*a_cm:0.05:2*a_cm);
roiSurfY = (-2*b_cm:0.05:2*b_cm); 
roiSurfZ = (-2*c_cm:0.05:2*c_cm); 
[roiGridX, roiGridY, roiGridZ] = ndgrid(roiSurfX,roiSurfY,roiSurfZ);
roiPatchGen = zeros(size(roiGridX));
roiPatchGen( (roiGridX/a_cm).^2 + (roiGridY/b_cm).^2 + (roiGridZ/c_cm).^2 <= 1.0 ) = 1;
roiOffPatchGen = zeros(size(roiGridX));
roiOffPatchGen( (roiGridX/1.0).^2 + (roiGridY/1.0).^2 + (roiGridZ/2.0).^2 <= 1.0 ) = 1;

roiGridX=permute(roiGridX,[2 1 3]); 
roiGridY=permute(roiGridY,[2 1 3]);
roiGridZ=permute(roiGridZ,[2 1 3]);
roiPatchGen = permute(roiOffPatchGen ,[2 1 3]);
roiOnPatch=patch( isosurface( roiGridX, roiGridY, roiGridZ, roiPatchGen, 0.99 ) );
isonormals(roiGridX, roiGridY, roiGridZ, roiPatchGen,  roiOnPatch);
set(roiOnPatch, 'FaceColor', 0.6*[1,1.0,1.0], 'EdgeColor', 'none','FaceAlpha',0.3, ...
    'FaceLighting', 'flat');
roiOnPatch.Parent = hgtransform('Matrix', makehgtform('translate',1e2*p_control_xyz(:,1)));

roiPatches={roiOnPatch};
for m=2:M
    roiPatches{end+1} = copyobj(roiOnPatch, gca() );
    roiPatches{m}.Parent = hgtransform('Matrix', makehgtform('translate',1e2*p_control_xyz(:,m)));
end

%% -- 3D temp contour

cemVal = 240;

figure(1);
clf;
hold on;

% xplotr = [-0.011 0.011];
% yplotr = xplotr;
% axis([ xplotr yplotr .12 .16 0 1 ] );

%light('Position', [0.00 -0.001 0.14]);
light('Position', [0 -2 -1]);

pA=patch( isosurface( rgx, rgy, rgz, tempChange, 30.0 ) );
isonormals(rgx, rgy, tz, tempChange,pA);
set(pA, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'DisplayName', '30.0',...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 0.9, 'SpecularExponent', 25, 'BackFaceLighting', 'unlit' ...
    );

pB=patch( isosurface( rgx, rgy, rgz, tempChange, 10 ) );
isonormals(rgx, rgy, rgz, tempChange,pB);
set(pB, 'Clipping', 'on', 'FaceColor', 'blue',...
    'DisplayName', '10.0',...
    'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

% xboxr=[-0.01 0.01]; yboxr=xboxr;
% xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];
% plot3( xyboxverts(1,:), xyboxverts(2,:), 0.15 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
% plot3( xyboxverts(1,:), xyboxverts(2,:), 0.13 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
% for i=1:4
%     plot3( xyboxverts(1,[i i]), xyboxverts(2,[i i]), [0.13 0.15], 'LineStyle','--','LineWidth',2, 'Color', 'black' );
% 
% end

legend([pA pB]);

view([60 10]);


%lighting gouraud

%grid on;
%set(gca, 'GridLineStyle', 


% xticklabs = (-1:1:1);
% xticks = xticklabs/(100);
% 
% %yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
% yticklabs = xticklabs;
% yticks = yticklabs/(100) ;
% 
% zticklabs = 100*r_foc + (-2:1:2);
% zticks = zticklabs/(100) ;
% 
% set(gca,'XTick', xticks);
% set(gca,'XTickLabel', xticklabs);
% set(gca,'YTick', yticks);
% set(gca,'YTickLabel', yticklabs);
% set(gca,'ZTick', zticks);
% set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',26);

xlabel('X [cm]', 'Fontsize', 26);
ylabel('Y [cm]', 'Fontsize', 26);
zlabel('Axial [cm]', 'Fontsize', 26);



axis equal tight;
daspect([1 1 1]);




%% -- 3D CEM contour

cemVal = 240;

figure(1);
clf;
hold on;

xplotr = [-0.011 0.011];
yplotr = xplotr;
axis([ xplotr yplotr .12 .16 0 1 ] );

%light('Position', [0.00 -0.001 0.14]);
light('Position', [0 -2 -1]);

pA=patch( isosurface( tx, ty, tz, ThermDose, 240 ) );
isonormals(tx, ty, tz, ThermDose,pA);
set(pA, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 0.9, 'SpecularExponent', 25, 'BackFaceLighting', 'unlit' ...
    );

pB=patch( isosurface( tx, ty, tz, ThermDose, 30 ) );
isonormals(tx, ty, tz, ThermDose,pB);
set(pB, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.5, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

xboxr=[-0.01 0.01]; yboxr=xboxr;
xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];
plot3( xyboxverts(1,:), xyboxverts(2,:), 0.15 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
plot3( xyboxverts(1,:), xyboxverts(2,:), 0.13 + zeros(5), 'LineStyle','--','LineWidth',2, 'Color', 'black' );
for i=1:4
    plot3( xyboxverts(1,[i i]), xyboxverts(2,[i i]), [0.13 0.15], 'LineStyle','--','LineWidth',2, 'Color', 'black' );

end

leg=legend([pA pB], {'CEM 240', 'CEM 30'});

view([60 10]);
%axis off;

%lighting gouraud

%grid on;
%set(gca, 'GridLineStyle', 


xticklabs = (-1:1:1);
xticks = xticklabs/(100);

%yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
yticklabs = xticklabs;
yticks = yticklabs/(100) ;

zticklabs = 100*r_foc + (-2:1:2);
zticks = zticklabs/(100) ;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',26);

xlabel('X [cm]', 'Fontsize', 26);
ylabel('Y [cm]', 'Fontsize', 26);
zlabel('Axial [cm]', 'Fontsize', 26);



axis equal tight;
daspect([1 1 1]);









