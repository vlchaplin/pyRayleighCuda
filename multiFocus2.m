
% clear;
% clear all;
% close all;
% clc;

Nx = 256;
Ny = 512;



p_control = zeros(Nx, Ny);
p2 = zeros(Nx, Ny);

[giX, giY] = meshgrid(1:Nx, 1:Ny);
giX=giX';
giY=giY';

%acoustic source positions
pixel_size = 0.00025;

r_foc = 25.4e-3*2.5;
c = 1540; % m/s
f_o = 1.5e6; % Hz
w = 2*pi*f_o; % rad/sec

kr = w/c;

rho = 1000; %kg per m^3
rho_c = rho*c;
rho_c_k = rho*c*kr;

focal_rad_in_pixels = round(r_foc / pixel_size);
center_point = [Nx/2 10];

half_open_angle = pi/3.0;
N = round( 2.0*focal_rad_in_pixels*half_open_angle);
N = round(N / 6);
face_diameter_pixels = 2.0*focal_rad_in_pixels*(1 - cos(half_open_angle));

focal_point_pix = center_point + [0 focal_rad_in_pixels];

u_pos = zeros(N,2);
u_pos_ij = zeros(N,2);

for n=1:N
   
    theta = half_open_angle*(n - N/2)/N;
    di = focal_rad_in_pixels*sin(theta);
    dj = focal_rad_in_pixels*(1 - cos(theta));
    
    x = (di + center_point(1))*pixel_size;
    y = (dj + center_point(2))*pixel_size;
    
    i = floor(di + center_point(1));
    j = floor(dj + center_point(2));
    
    u_pos(n,:) = [x y];
    u_pos_ij(n,:) = [i j];
    
    distances = sqrt((x - (giX.*pixel_size) + pixel_size).^2 + (y - (giY.*pixel_size)  + pixel_size).^2);
    
    ii=find(distances(:) < pixel_size );
    
    thisSource = 1i*rho_c_k/(2*pi).*exp(-1i*kr.*(distances))./distances;
    thisSource(ii) = 0;
    p2(:,:) = p2 + thisSource;
    
    
    
end

figure(2);
I=(( p2.*conj(p2)  ));
maxI= max(I(:));
imagesc( transpose(I), [0 maxI*0.05] );
axis equal;

%fociCenters = [ focal_point_pix; focal_point_pix; ];
fociCenters = [ focal_point_pix - [30 0];  focal_point_pix + [30 0]; ] ;
%fociCenters = [  [40 270]; [140 270];  ];



%pentagonal pattern: -----------------
% c1 = (sqrt(5)-1)/4.0; c2 = (sqrt(5)+1)/4.0; s1 = sqrt(10 + 2*sqrt(5))/4.0; s2 = sqrt(10 - 2.0*sqrt(5))/4.0;
% fociCenters = 60*[ [1 0]; [ c1 -s1 ]; [ -c2 -s2 ]; [ -c2 s2 ]; [ c1 s1 ]; ];
% % 
%  theta=-pi/2.0;
% % 
%  %triangle
%  fociCenters = 30*[ [1 0]; [-1 0]; [0 sqrt(3)]; ];
%  theta=0;
% % 
% % 
% 
% %
%rectangle
% fociCenters = 30*[ [1 1]; [-1 1]; [-1 -1]; [1 -1]; ];
% theta = pi/4.0;

% rotator = [ [cos(theta) -sin(theta)]; [sin(theta) cos(theta)]; ];
% fociCenters = fociCenters * rotator;
% % 
% % 
%fociCenters(:,1) = round(fociCenters(:,1) + focal_point_pix(1));
%fociCenters(:,2) = round(fociCenters(:,2) + focal_point_pix(2) + 0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

radius_in_pixels = 1;

zeroPoints = [ 10 20;  32 20; 48 20 ]/2;
zrad=3;

pixelArea=pixel_size^2;

for i=1:Nx  
    for j=1:Ny
        for k=1:length(fociCenters)
            p_control(i,j) = p_control(i,j) + pixelArea*rho_c_k*(1.0 / (2*pi*radius_in_pixels^2))*exp(-0.5*((i - fociCenters(k,1))/radius_in_pixels)^2.0)*exp(-0.5*((j - fociCenters(k,2))/radius_in_pixels)^2.0); 
        end
    end
end

med_control = median(p_control(:));
max_control = max(p_control(:));

%ii=find(p_control(:) >= (med_control + 0.8*(max_control-med_control)) );

ii = (fociCenters(:,2)-1)*Nx + fociCenters(:,1);

p_control(ii) = 1e4;

p_hot = p_control(ii);
%p_hot(1) = 0;

p_hot(1) = 1i*p_hot(1);

hot_pix = zeros(length(ii), 2);

hot_pix(:,2) = floor( (ii-1)./Nx) + 1;
hot_pix(:,1) = mod(ii-1, Nx) + 1;

%figure(2);
%imagesc( transpose(p2) );
%axis equal;


% hot_pix = [ [100 400]; [100 200]; [200 300]; ];
% p_hot = [15e13; 15e13; 15e13];

M = length(p_hot);

H = zeros(M, N);

umag = ones(N,1);
uphase = zeros(N,1);

srcarea=pixelArea; nzeros=0;

for m=1:M 
   
    
    i = hot_pix(m,1);
    j = hot_pix(m,2);
    rm = [i j] ;
    
    for n=1:N
        
        Rmn = norm(pixel_size*rm - u_pos(n,:) + pixel_size) ;
        if Rmn == 0
            Rmn=0;
        end
        if Rmn > 0
        H(m,n) = 1i*rho_c_k*exp(-1i*kr*Rmn)/Rmn;
        else
           nzeros=nzeros+1; 
        end
        
    end
end

%Hinv = pinv(H);

Hstar_t = ctranspose(H);
HHstar_tinv = pinv(H*Hstar_t);

uopt = Hstar_t*HHstar_tinv*(p_hot(:));

u_k = complex(zeros(N,1));

for k=1:120
   
    gk = Hstar_t * p_hot(:) - Hstar_t * H * u_k;
    
    alpha = (ctranspose(gk)*gk) / ( ctranspose(H*gk)* (H*gk) );
    
    u_k = u_k + gk.*alpha;
    
    if (norm(gk) < 0.0001)
        break;
    end
    
end

p_recon = zeros(Nx, Ny);

algdiff=norm((u_k - uopt)./uopt)

uopt=u_k;

for n=1:N
   
    theta = half_open_angle*(n - N/2)/N;
    di = focal_rad_in_pixels*sin(theta);
    dj = focal_rad_in_pixels*(1 - cos(theta));
    
    x = (di + center_point(1))*pixel_size;
    y = (dj + center_point(2))*pixel_size;
    
    i = floor(di + center_point(1));
    j = floor(dj + center_point(2));
    
    distances = sqrt((x - (giX.*pixel_size) + pixel_size).^2 + (y - (giY.*pixel_size)  + pixel_size).^2);
    
    ii=find(distances(:) < pixel_size );
    
    thisSource = uopt(n)*1i*rho_c_k/(2*pi).*exp(-1i*kr*(distances))./distances;
    thisSource(ii) = 0;
    p_recon(:,:) = p_recon + thisSource;
    
end

figure(3);
I=(( p_recon.*conj(p_recon)  ) ) / rho_c;
maxI= max(I(:));
imagesc( transpose(I), [0 maxI*0.025] );
axis equal;


xticklabs = round(((-Nx/2.0)*100*pixel_size + .2) : 1 : ((Nx/2.0)*100*pixel_size));
xticks = xticklabs/(100*pixel_size) + Nx/2.0;

yticklabs = round(((-Ny/2.0)*100*pixel_size +.4 ) : 1 : ((Ny/2.0)*100*pixel_size));
yticks = yticklabs/(100*pixel_size) + Ny/2.0;

set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca, 'FontSize',14);
xlabel('cm', 'Fontsize', 18);
ylabel('cm', 'Fontsize', 18);

hold on;
plot( hot_pix(:,1), hot_pix(:,2) , '*r')
plot( u_pos_ij(:,1), u_pos_ij(:,2), '+w');


% create ROIs for heat deposition measurement

%start with a rectange around centered on each hotspot
roiRectXpix = 30;
roiRectYpix = 30;

[templateX, templateY] = meshgrid(1:roiRectXpix, 1:roiRectYpix);
templateX=templateX';
templateY=templateY';

princMat=zeros(2,2);

onTargetMask = zeros(Nx,Ny);

for m=1:M
    
%     roiX = (hot_pix(m,1) - (templateX - roiRectXpix/2) + 1);
%     roiY = (hot_pix(m,2) - (templateY - roiRectYpix/2) + 1);
%     
%     pixX = (roiX(:,1));
%     pixY = (roiY(1,:));
    
    pixX = hot_pix(m,1) - ((1:roiRectXpix) - roiRectXpix/2) + 1;
    pixY = hot_pix(m,2) - ((1:roiRectYpix) - roiRectYpix/2) + 1;
    
    
    pixX=pixX';
   %find intensity-weighted center
   %dist = sqrt( (roiX)^2 + (roiY).^2 );
    
   Iroi = I(pixX, pixY);
   
   
   maxIroi = max(Iroi(:));
   minIroi = min(Iroi(:));
   nullii=find(Iroi(:) <= (minIroi + 0.3*(maxIroi-minIroi)) );
   Iroi(nullii) = 0;
   totI = sum(Iroi(:));
   
   xcentroid = sum((pixX+0.5).*sum(Iroi,2)) / totI;
   ycentroid = sum((pixY+0.5).*sum(Iroi,1)) / totI;
   xrms = sum(((pixX+0.5).^2).*sum(Iroi,2)) / totI;
   yrms = sum(((pixY+0.5).^2).*sum(Iroi,1)) / totI;
   
   princMat(1,1) = sum(((pixY+0.5-ycentroid).^2).*sum(Iroi,1));
   princMat(2,2) = sum(((pixX+0.5-xcentroid).^2).*sum(Iroi,2));
   princMat(1,2) = - sum( ((pixX+0.5-xcentroid).*(Iroi*(pixY+0.5-ycentroid)')) ); 
   princMat(2,1) = princMat(1,2);
   
   [V, D] = eig(princMat);
   D = D/totI;
   
   %abratio = min(D(:))/max(D(:));
   
   if D(1,1) > D(2,2)
       
       maxIDX = 1;
       minIDX = 2;
   else
       maxIDX=2;
       minIDX=1;
   end
   a_roi = 2*sqrt(D(maxIDX,maxIDX));
   b_roi = 2*sqrt(D(minIDX,minIDX));
   
   
   a_roi = 0.01 / pixel_size;
   b_roi = 0.001 / pixel_size;
   
   cosTheta = V(2,maxIDX);
   sinTheta = V(1,maxIDX);
   
   t = -pi:0.05:pi;
   roiedgeX = a_roi*cos(t);
   roiedgeY = b_roi*sin(t);
   
   uX = roiedgeX*cosTheta + roiedgeY*sinTheta + xcentroid;
   uY = -roiedgeX*sinTheta + roiedgeY*cosTheta + ycentroid;
   
   onTargetMask = onTargetMask | ( ((((giX-xcentroid)*cosTheta - (giY-ycentroid)*sinTheta)/a_roi).^2 + (((giY-ycentroid)*cosTheta + (giX-xcentroid)*sinTheta)/b_roi).^2 ) < 1);

   plot( uX, uY, 'y--', 'linewidth',2)
   plot( xcentroid, ycentroid , 'w+', 'linewidth',2)
end

onTargetImage = onTargetMask .* I ;

%now that the foci masks are define, select the off-target area
ynearest = round( focal_point_pix(2) - 0.25*focal_rad_in_pixels );

offTargetMask = ones(Nx,Ny);

offTargetMask(:, 1:(ynearest-1)) = 0;
offTargetMask = offTargetMask.*(1-onTargetMask);

offTargetImage = offTargetMask .* I ;

plotMax = maxI*0.025;


figure(4);
set(gcf,'Position', [300 200 1150 700]);
subplot(1,3,1);
imagesc( I', [0 plotMax] );
axis equal;
set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca, 'FontSize',14);
xlabel('cm', 'Fontsize', 18);
ylabel('cm', 'Fontsize', 18);
subplot(1,3,2);
imagesc( offTargetImage', [0 plotMax] );
axis equal;
set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca, 'FontSize',14);
xlabel('cm', 'Fontsize', 18);
ylabel('cm', 'Fontsize', 18);
subplot(1,3,3);
imagesc( onTargetImage', [0 plotMax] );
axis equal;
set(gca,'XTick', xticks);
set(gca,'XTickLabel', xticklabs);
set(gca,'YTick', yticks);
set(gca,'YTickLabel', yticklabs);
set(gca, 'FontSize',14);
xlabel('cm', 'Fontsize', 18);
ylabel('cm', 'Fontsize', 18);


absorption = 20.0; % per meter
Cv = 4.18e06; % J / m^3*C
time_exposure=1; %sec

deltaT = 2*I*absorption*time_exposure/Cv  * 1e04 ; %1e04 to convert I from W/cm^2 to W/m^2
maxDT = max(deltaT(:));

onTargetImage = onTargetImage* 2*absorption*time_exposure/Cv * 1e04;
offTargetImage = offTargetImage* 2*absorption*time_exposure/Cv * 1e04;

hxmin =0.02*0.025*maxDT;
hxmax = 0.025*maxDT;
nbins = 100;
hxstep = ((hxmax-hxmin)/(nbins-1));

edges = hxmin:hxstep:hxmax;

hkON = histc( onTargetImage(:), edges);
hkOFF = histc( offTargetImage(:), edges);

% 
 figure(5);
 
 loglog(edges, hkON+1, 'r','linewidth',2);
 xlabel('Degrees C per sec', 'Fontsize', 18);
 ylabel('# pixels', 'Fontsize', 18);
 hold on;
 loglog(edges, hkOFF+1, 'b','linewidth',2);
 axis( [0.001 1 0 3*max(hkOFF)]);
 leg=legend('ON-target ROI', 'OFF-target');
 set(leg,'FontSize',18);
 set(gca, 'FontSize',14);
 hold off;
 
 
 
% axis equal;


avgon=sum(onTargetImage(:) / sum(hkON));
avgoff=sum(offTargetImage(:)/ sum(hkOFF) );

sprintf('Avg-ON = %f,  Avg-OFF = %f,  Ratio ON/OFF=%f', avgon, avgoff, avgon / avgoff)



