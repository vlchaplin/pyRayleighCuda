

%% Load transducer data
    
%this file has the focal axis along x, so rotate the coords
file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
R = rotmatZYZ(0, pi/2, 0);
    
u_pos = read_sonalleve_xml(file);

pixel_size = 0.002;
N = size(u_pos,2);

for n=1:N
   u_pos(:,n) =  R*u_pos(:,n) ;
end

r_foc = 140e-03; %focal length in meters

trans_element_radius = 0.0033;



% to figure transducer depth, find z which minimizes error on the distance between
% (0,0,r0-z) and each element, and the value r0. z should be the bottom of
% the spherical shell

nnnn=80;
 fv=zeros(1,nnnn);
 zz=(1:nnnn)*(1.0/(nnnn-1)) -0.6;
for i=1:nnnn
    hk = r_foc - zz(i);
    dk = sqrt( u_pos(1,:).^2 + u_pos(2,:).^2 + ( u_pos(3,:) - hk ).^2 );
    fv(i) = sum( (dk - r_foc).^2 );
end
 
terminate=0;
k=0;zk0=-0.6;zk1=0.0;
while ~terminate
    
    hk = r_foc - zk0;
    dk = sqrt( u_pos(1,:).^2 + u_pos(2,:).^2 + ( u_pos(3,:) - hk ).^2 );
    dkp = ( u_pos(3,:) - hk ) ./ dk;
    dkpp = ( 1 - dkp.^2) ./ dk;
    
    f = sum( (dk - r_foc).^2 );
    fp = 2*sum( (dk - r_foc).*dkp );
    fpp = 2*sum( dkp.^2 + (dk-r_foc).*dkpp );
    zk1 = zk0 - fp/fpp;
    
    zk0=zk1;
    if ( abs(fp) < 1e-9 || k>100 ) 
        terminate=true;
    end
    k=k+1;
end
% figure(1);
% plot(zz,fv)
% 
% figure(2);
% clf;
% hold on;
% plot3( u_pos(1,:), u_pos(2,:), u_pos(3,:)+zk0  );
% plot3( [ 0 0], [0 0], [0 r_foc] );
% daspect([1,1,1]);


zk0=0;

%shift so that bottom of transducer sphere is at z=0
u_pos(3,:)=u_pos(3,:)+zk0;
trans_bowl_center = [0 0 0];
trans_focal_point = trans_bowl_center + [0 0 r_foc];

% R = rotmatZYZ(0, pi/6, 0);
% for n=1:N
%    u_pos(:,n) =  R*u_pos(:,n) ;
% end

trans_h=max(u_pos(3,:)) + 1.05*trans_element_radius;

trans_bowl_openang = acos( 1.0 - trans_h/r_foc );
trans_r_foc_pix = round(r_foc / pixel_size);

%diameter of the aperature at face
aperature = 2*r_foc*sin(trans_bowl_openang);

%if desiring realistic physical scale
Nz = ceil( (1.5*r_foc)/pixel_size);
Nx = ceil(aperature/pixel_size);

if mod(Nz,2)==1
    Nz=Nz+1;
end
if mod(Nx,2)==1
    Nx=Nx+1;
end

Ny = Nx;



% u_pos_pix = u_pos;
% u_pos_pix(1,:) = floor( (u_pos(1,:) + 0.5*aperature)/pixel_size ) + 1;
% u_pos_pix(2,:) = floor( (u_pos(2,:) + 0.5*aperature)/pixel_size ) + 1;
% u_pos_pix(3,:) = floor( (u_pos(3,:))/pixel_size ) + 1;

u_pos_pix = u_pos/pixel_size;
u_pos_pix(1,:) = u_pos_pix(1,:) + Nx/2;
u_pos_pix(2,:) = u_pos_pix(2,:) + Ny/2;
u_pos_pix(3,:) = u_pos_pix(3,:) + 1;
 

trans_bowl_center_pix = floor([Nx/2+1 Ny/2+1 1]);

focal_point_pix = trans_bowl_center_pix + [0 0 trans_r_foc_pix];
faceZpix = floor(trans_bowl_center_pix(3) + trans_h/pixel_size);


%compute normal vectors of each transducer element. This uses the
%assumpution that they are on a sphere and pointed towards [0 0 r_foc]
u_face_vectors = u_pos;
for n=1:N
   u_face_vectors(:,n) =  trans_focal_point' - u_pos(:,n) ;
end



sprintf('Grid dims Nx,Ny,Nz = %d, %d, %d', Nx, Ny, Nz)
sprintf('Voxel side = %f mm', 1000*pixel_size)

%% physics params


f_o = 1.2e6; % Hz

w = 2*pi*f_o; % rad/sec

c = 1540; % m/s
kr = w/c;

% 
rho = 1000; %kg per m^3
rho_c = rho*c;
rho_c_k = rho*c*kr;

precon = zeros(Nx,Ny,Nz);

%% Make template to sub-sample each transducer element (approximation to Huygen's principle)
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

figure(3);
clf;
hold on;
plot(usub_coords_model(1,:),usub_coords_model(2,:),'Marker','+', 'LineStyle','none');

%% two spots
%rm_pix = [ focal_point_pix - [0 5 0]; focal_point_pix + [0 5 0];   ] ;

%% irreg. octahedron around focus
% vdist=10;
% object = [ -[0 vdist 0]; [0 vdist 0]; [-vdist 0 0]; [vdist 0 0]; [0 0 -vdist]; [0 0 vdist]; ];
% nverts = size(object,1);
% rm_pix=object;
% R = rotmatZYZ(0, 0, 0);
% for k=1:nverts
%     rm_pix(k,:) = rm_pix(k,:)*R + focal_point_pix + [10 0 0];
% end
%% reg tetrahedron centered at focus
% vdist=10;
% rm_pix = vdist*[ [1 0 -1/sqrt(2)]; [0 1 1/sqrt(2)]; [-1 0 -1/sqrt(2)]; [0 -1 1/sqrt(2)]; ];
% nverts = size(rm_pix,1);
% R = rotmatZYZ(0, 0, 0);
% for k=1:nverts
%     rm_pix(k,:) = rm_pix(k,:)*R + focal_point_pix;
% end
%% square around focus in a plane
% vdist=6;
% rm_pix = vdist*[ [1 0 0]; [0 1 0]; [-1 0 0]; [0 -1 0]; ];
% nverts = size(rm_pix,1);
% R = rotmatZYZ(0, 0, pi/4);
% for k=1:nverts
%     rm_pix(k,:) = rm_pix(k,:)*R + focal_point_pix + [ 0 0 0 ];
% end

%% disk around focus in X-Y plane
nfoci=4;
radius=2;
%radius=0.01/pixel_size;
rm_pix = zeros(nfoci,3);
thetas = 0:(2*pi/(nfoci)):2*pi;
for k=1:nfoci
    rm_pix(k,:) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0 ];
    rm_pix(k,:) = rm_pix(k,:) + focal_point_pix + [ 0 0 0 ];
end

%% rotated disk around focus in X-Y plane
% nfoci=15;
% radius=10;
% rm_pix = zeros(nfoci,3);
% thetas = 0:(2*pi/(nfoci-1)):2*pi;
% R = rotmatZYZ(0, pi/2, 0);
% for k=1:nfoci
%     rm_pix(k,:) = [ radius*cos(thetas(k)), radius*sin(thetas(k)), 0 ]*R;
%     rm_pix(k,:) = rm_pix(k,:) + focal_point_pix + [ 0 0 0 ];
% end

%% continue

%rm_pix = [ focal_point_pix; focal_point_pix - [0 0 0] ];
%rm_pix = [ focal_point_pix + [0 0 0] ]; 
%rm_pix = [ focal_point_pix - [10 0 0]; focal_point_pix+[10 0 0];  ];

%rm_pix=round(rm_pix');
rm_pix=rm_pix';
M = size(rm_pix,2);

p_hot = zeros(1,M);

p_hot(:) = 1e06;

p_control_xyz = rm_pix;
p_control_xyz(1,:) = pixel_size*(rm_pix(1,:) - Nx/2  );
p_control_xyz(2,:) = pixel_size*(rm_pix(2,:) - Ny/2   );
p_control_xyz(3,:) = pixel_size*(rm_pix(3,:) - 1);

uopt = get_sonalleve_transducer_vals( f_o, 1000, 1540, p_control_xyz, p_hot );

%% calc intensity field

%have to swap x-y
[gx, gy, gz] = meshgrid(1:Ny, 1:Nx, 1:Nz);

%uopt(:)=1;
%uopt(1)=0.99;
%uopt=abs(uopt);

precon2 = precon;

for n=1:N
    
    ix = u_pos_pix(1,n);
    iy = u_pos_pix(2,n);
    iz = u_pos_pix(3,n);
    
    x=pixel_size*(ix);
    y=pixel_size*(iy);
    z=pixel_size*(iz);
    
    
    [un_az,un_alt,un_r]=cart2sph(u_face_vectors(1,n), u_face_vectors(2,n), u_face_vectors(3,n));
    
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
    for j=1:nsubsamp
       
        usub_coords(:,j) = [x y z]' + Rn'*usub_coords_model(:,j);
        d=sqrt((usub_coords(1,j) - (gx.*pixel_size) ).^2 + (usub_coords(2,j) - (gy.*pixel_size)).^2 + (usub_coords(3,j) - (gz.*pixel_size) ).^2);

        thisSource = uopt(n)*1i*rho_c_k/(2*pi).*exp(-1i*kr.*(d))./d;
        
        precon(:,:,:) = thisSource + precon;
        
    end
    
end

precon(:,:,1:(faceZpix+10))=0;

I=(( precon.*conj(precon) ) / (2*rho*c) );
maxI= max(I(:));
minI= min(I(:));

newMaxI = 1e6^2/ (2*rho*c);
I = minI + (I-minI).*( (newMaxI-minI) / (maxI-minI) );
maxI= max(I(:));

%jj=find(I > maxI);
%I(jj)=maxI;

%% s

figure(1);
clf;
hold on;

for n=1:N
    
    ix = u_pos_pix(1,n);
    iy = u_pos_pix(2,n);
    iz = u_pos_pix(3,n);
    
    x=pixel_size*(ix);
    y=pixel_size*(iy);
    z=pixel_size*(iz);
    
    
    [un_az,un_alt,un_r]=cart2sph(u_face_vectors(1,n), u_face_vectors(2,n), u_face_vectors(3,n));
    
    Rn = rotmatZYZ(un_az, pi/2-un_alt, 0);
    
    for j=1:nsubsamp
        usub_coords(:,j) = ([x y z]' + Rn'*usub_coords_model(:,j))/pixel_size;
    end
    
    plot3( usub_coords(1,:), usub_coords(2,:), usub_coords(3,:), 'Marker','.', 'Color', 'Green', 'LineStyle','none' );
    
    plot3( ix,iy,iz, 'Color', 'red', 'Marker', 'o','MarkerSize', 2*trans_element_radius/pixel_size );

    
end

%xticklabs = round(((-Nx/2.0)*100*pixel_size ) : 2 : ((Nx/2.0)*100*pixel_size));
xticklabs = (-6:2:6);
xticks = xticklabs/(100*pixel_size) + Nx/2.0;

%yticklabs = round(((-Ny/2.0)*100*pixel_size ) : 2 : ((Ny/2.0)*100*pixel_size));
yticklabs = -6:2:6;
yticks = yticklabs/(100*pixel_size) + Ny/2.0;

zticklabs = round( 0 : 2 : ((Nz)*100*pixel_size) );
zticks = zticklabs/(100*pixel_size) ;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',12);

xlabel('X, MR Z (HF) [cm]', 'Fontsize', 12);
ylabel('Y, MR Y (LR) [cm]', 'Fontsize', 12);
zlabel('Z, MR X (vert.) [cm]', 'Fontsize', 12);

%close(1);

%slice(gx,gy,gz, I, [] , Nx* pixel_size, []);
%slice(gx,gy,gz, I, [] , Nx/2*pixel_size, []);

%slice(gx,gy,gz, I, [] ,[], Nz/2 );

s=slice(gx,gy,gz, I, [] ,[], focal_point_pix(3)+0.5 );
set(s,'EdgeColor','none','Facecolor','interp');

%s=slice(gx,gy,gz, I, [] ,[], faceZpix );
%set(s,'EdgeColor','none', 'Facecolor','interp');

% s=slice(gx,gy,gz, I, Nx/2+1 ,[], [] );
% set(s,'EdgeColor','none','Facecolor','interp');

s=slice(gx,gy,gz, I, [], Ny/2+1, [] );
set(s,'EdgeColor','none', 'Facecolor','interp');

% for m=1:M
%    plot3( rm_pix(1,:), rm_pix(2,:), rm_pix(3,:),'LineStyle','-','Color', 'Red', 'Marker', '*','MarkerSize',10);
% end

caxis([0.001*maxI maxI]);

daspect([1 1 1]);
view([70 5]);

figure(2);
clf;
hold on;

hxmin = min(I(:));
hxmax = max(I(:));
nbins = 1000;
hxstep = ((hxmax-hxmin)/(nbins-1));
edges = hxmin:hxstep:hxmax;
ihist=histc( I(:), edges);
cdf = cumsum( ihist/sum(ihist) );

kk=find(cdf>0.999);
cval=edges(kk(1));


p=patch( isosurface( gx,gy,gz,I, cval ) );
isonormals(gx,gy,gz,I,p);
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
camlight
lighting gouraud


daspect([1 1 1]);
view([70 5]);


plot3( [trans_bowl_center_pix(1) trans_bowl_center_pix(1)], ...
    [trans_bowl_center_pix(2) trans_bowl_center_pix(2)], ...
    [trans_bowl_center_pix(3) Nz], 'Color', 'black' );

for m=1:M
   plot3( rm_pix(1,:), rm_pix(2,:), rm_pix(3,:),'LineStyle','--','Color', 'Red', 'Marker', '.','MarkerSize',10);
end

for n=1:N
    
    ix = u_pos_pix(1,n);
    iy = u_pos_pix(2,n);
    iz = u_pos_pix(3,n);
      
    plot3( ix,iy,iz, 'Color', 'black', 'Marker', 'o','MarkerSize', 2*trans_element_radius/pixel_size );
    
end

%input to sonalleve
amplitude=abs(uopt);
phase = 180.0/pi .* angle(uopt);
phase = floor(mod(phase + 360, 360));


%amp scaling

normalizedamp = min(amplitude) + (amplitude-min(amplitude))/(max(amplitude)-min(amplitude));
ncedges=0:0.01:1.0;
normampcumdist = cumsum(histc(normalizedamp, ncedges )) / length(normalizedamp);
figure(6);
plot(ncedges, normampcumdist);

LQ=0.1; UQ=0.90;
lqi = find( normampcumdist > LQ  );
uqi = find( normampcumdist >= UQ  );

minscaledampchannel = floor(4095*ncedges(lqi(1)) );
maxscaledampchannel = ceil(4095*ncedges(uqi(1)) );


% minscaledampchannel=0;
% maxscaledampchannel=4095;
%maxscaledampchannel = minscaledampchannel + 10^( 1+ floor(log10(max(amplitude)/min(amplitude))) );

whiteColorAmpval=0;
blackColorAmpval=4095;

%whiteColorAmpval=(minscaledampchannel+maxscaledampchannel)/2 - 10^( 2+ floor(log10(max(amplitude)/min(amplitude))) );
%blackColorAmpval=(minscaledampchannel+maxscaledampchannel)/2 + 10^( 2+ floor(log10(max(amplitude)/min(amplitude))) );


scaledamp = minscaledampchannel+floor(( (amplitude-min(amplitude))*(maxscaledampchannel-minscaledampchannel)/(max(amplitude)-min(amplitude))) );

maxgray=1.0;
mingray=0.0;
%grayscaledamp = 1 - ( mingray + ((scaledamp - whiteColorAmpval)*(maxgray-mingray)/(4095)) );

grayscaledamp = 1 - ( mingray + ( (scaledamp-whiteColorAmpval)*(maxgray-mingray)/(blackColorAmpval-whiteColorAmpval)) );

jj=find(grayscaledamp < 0);
grayscaledamp(jj)=0.0;

jj=find(grayscaledamp > 1);
grayscaledamp(jj)=1.0;

ampstr ='''SetAmplitude'', [1, ';
phstr = '''SetPhase'', [1, ';
for n=1:N
    
    if (mod(n,8) == 0) && n < N
        ampstr = sprintf('%s...\n   ', ampstr );
        phstr = sprintf('%s...\n   ', phstr );
    end
    ampstr = sprintf('%s%d', ampstr, scaledamp(n) );
    phstr = sprintf('%s%d', phstr, phase(n) );
    
    if n < N
        ampstr = sprintf('%s,', ampstr );
        phstr = sprintf('%s,', phstr );
    else
        ampstr = sprintf('%s]', ampstr );
        phstr = sprintf('%s]', phstr );
    end
    

    
end

figure(4);
clf;
hold on;

axis([0 Nx 0 Ny 0 Nz 0 1]);
daspect([1 1 1]);
view([70 5]);

set(gca,'XTick', xticks);
set(gca,'XTickLabel', -1*xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca,'ZTick', zticks);
set(gca,'ZTickLabel', zticklabs);
set(gca, 'FontSize',12);

xlabel('Z (HF) [cm]', 'Fontsize', 12);
ylabel('Y [cm]', 'Fontsize', 12);
zlabel('X (vert.) [cm]', 'Fontsize', 12);

for n=1:N
    
    ix = u_pos_pix(1,n);
    iy = u_pos_pix(2,n);
    iz = u_pos_pix(3,n);
      
    plot3( ix,iy,iz, 'Color', 'black', 'MarkerFaceColor', grayscaledamp(n)*[1,1,1], 'Marker', 'o','MarkerSize', 20 );
    
end

% 
%  fa=fopen('Ari_example_amplitudes.txt','w');
%  fprintf(fa, '%d\n', scaledamp);
%  fclose(fa);
%  
%  fa=fopen('Ari_example_phases.txt','w');
%  fprintf(fa, '%d\n', phase);
%  fclose(fa);

%ampstr = sprintf('%d, ',scaledamp);
%phstr = sprintf('%d, ',phase);

return

%% Bioheat

NNz = 60;
ZpixStart=(Nz-NNz+1);
Ipart = 5*I(:,:,ZpixStart:Nz );

Dx = pixel_size*[1 1 1];
nnx = 80;
nny = 80;
nnz = 10;
tstep = 0.25;
Nt = 1000;
T0=37;
Cp = 3700;
[Ton pixMult newDx tdotsrc] = homogenousePBHE( T0,1.0, 0.5, rho, Cp, Ipart, Nx, Ny, NNz, Dx, nnx, nny, nnz, Nt, tstep, 1 );

Ioff = zeros(Nx,Ny,NNz);

Ntoff = 3;
[Toff pixMult newDx tdotsrc] = homogenousePBHE( Ton(Nt,:,:,:), 1.0, 0.5, rho, Cp, Ioff, Nx, Ny, NNz, Dx, nnx, nny, nnz, Ntoff, tstep, 1 );

%T = Toff;


[Nton nnx nny nnz] = size(Ton);

Nframes = Nton + Ntoff;

T = zeros(Nframes,nnx,nny,nnz);
T(1:Nton,:,:,:) = Ton;
T((Nton+1):(Nframes),:,:,:) = Toff;
clear('Ton');clear('Toff');

Nt=Nframes;
%% plot results

focalZprime_pix = fix((trans_r_foc_pix-ZpixStart)/pixMult(3))-1;


%T = 100*T;

% figure(6);
% clf;
% imagesc(tdotsrc(:,:,focalZprime_pix));
% colorbar;

% figure(7);
% clf;
% hold off;
% 
% clear('mov'); clear('roiT');
% ti=0;
% for t=1:50:Nt
%     figure(7);
%     imagesc( squeeze(T(t,:,:, focalZprime_pix)), [37 43] );
%     colorbar;
%     ti=ti+1;
%     mov(ti) = getframe(gcf);
%     
% %     figure(2);
% %     roiT(ti) = sum(sum( T(t, roix, roiy, roiz), 3 )) / roiSize;
% %     
% %     plot( t, roiT(ti), 'Marker', '+', 'LineStyle', 'none');
%     
%end

%%
figure(3);
clf;
hold off;

%Nframes = size(T,1);

xp = ((1:nnx)-nnx/2-1)*newDx(1);
yp = ((1:nny)-nny/2-1)*newDx(2);
zp = ((1:nnz)-1)*newDx(3) + ZpixStart*Dx(3);

[tgx, tgy, tgz] = meshgrid( yp, xp, zp );

axis([min(tgx(:)) max(tgx(:)) min(tgy(:)) max(tgy(:)) 0 max(tgz(:)) 0 1]);

ti=0;

visPlaneHeights = [0.07 0.14];

nm=40;
xpp=linspace(-0.07,0.07,nm);
ypp=linspace(-0.07,0.07,nm)
zpp=zeros(nm);

clear('mov');
for t=2:50:Nframes

    figure(3);
    clf;
    hold on;
    TtimeSlice = squeeze(T(t, :,:,:));
    
     daspect([1 1 1]);
     view([45 10]);
     
    
    s=slice(tgx,tgy,tgz, TtimeSlice, [], 0.0, [] );
    set(s,'EdgeColor','black');
    
    s=slice(tgx,tgy,tgz, TtimeSlice, xp(2), [], [] );
    set(s,'EdgeColor','black');
    
    s=slice(tgx,tgy,tgz, TtimeSlice, [], yp(nny-1), [] );
    set(s,'EdgeColor','black');
    
    s=slice(tgx,tgy,tgz, TtimeSlice, [], [], r_foc );
    set(s,'EdgeColor','none');

%     for z=visPlaneHeights
%         break;
%         hsp = surface(xpp,ypp,zpp+z);
%         rotate(hsp,[1,0,0],40, [0.0, 0.0, z]);
%         xd = get(hsp,'XData');
%         yd = get(hsp,'YData');
%         zd = get(hsp,'ZData');
%         delete(hsp);
%         s=slice( tgx,tgy,tgz, TtimeSlice, xd, yd, zd );
%         set(s,'EdgeColor','none', 'FaceAlpha', 0.6);
%         
%         
%         
% %         hsp = surface(xpp,-ypp,zpp+z);
% %         rotate(hsp,[0,1,0],0, [0.0, 0.0, z]);
% %         xd = get(hsp,'XData');
% %         yd = get(hsp,'YData');
% %         zd = get(hsp,'ZData');
% %         delete(hsp);
% %         s=slice( tgx,tgy,tgz, TtimeSlice, xd, yd, zd );
% %         set(s,'EdgeColor','none', 'FaceAlpha', 0.6);
%         
%     end

    
    caxis([37 50]);
    
    drawnow;
    ti=ti+1;
    mov(ti) = getframe(gcf);
    drawnow;
end

caxis([37 50]);


vidwrite = VideoWriter('test.mp4', 'MPEG-4');
open(vidwrite);

for t=1:ti
    writeVideo(vidwrite,mov(t));
end
close(vidwrite);

