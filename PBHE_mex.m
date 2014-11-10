%mex 'C:\Users\vchaplin\Documents\HiFU\code\BioHeatCpp\BioHeatCpp\PBHE_FDsolve_mex.cpp'
Nt=11;Nx=64;Ny=64;Nz=16;
T=zeros(Nt,Nx,Ny,Nz);
rCp=zeros(Nx,Ny,Nz);
kt=rCp;

tdotsrc=zeros(Nt,Nx,Ny,Nz);


dx=[0.01 0.001 0.001 0.005];

% for i=1:Nx
% 
%     for j=1:Ny
%         
%         for k=1:Nz
%             
%             T(1,i,j,k) = 37.0;
%             rCp(i,j,k) = 3700*1000;
%             kt(i,j,k) = 0.5;
%             
%         end
%     end
% end

T(:) = 37;
rCp(:) = 3700000;
kt(:) = 0.5;

%rCp(:,1:Nx/2,1:Ny/2,:) = 370000;

%T(1,1:10,Ny/2:Ny/2+3,Nz/2:Nz/2+3) =45;

%set up spiral path
focspeed_pix = 10.0*(Nx/Nt);
pathradius=10;
xpx0=32+pathradius;
ypx0=32;
zpx0=Nz/2;

xpx2=32-pathradius;
ypx2=32;
zpx2=zpx0;

s=2;

figure(2);
clf;
hold on;
for t=1:Nt
    
    xpx = (xpx0-(focspeed_pix)*sin( t*(focspeed_pix/pathradius) ));
    ypx = (ypx0+focspeed_pix*cos( t*(focspeed_pix/pathradius) ));
    zpx = zpx0;
    
    xpx0 = xpx;
    ypx0 = ypx;
    zpx0 = zpx;
    
    if ( xpx+s <= Nx && xpx-s > 0 )
        tdotsrc(t, fix(xpx-s):fix(xpx+s), fix(ypx-s):fix(ypx+s), fix(zpx) ) = 4;
    end
    
    %multifoc
%     xpx = (xpx2-(focspeed_pix)*sin(pi+ t*(focspeed_pix/pathradius) ));
%     ypx = (ypx2+focspeed_pix*cos(pi+ t*(focspeed_pix/pathradius) ));
%     zpx = zpx2;
%     
%     xpx2 = xpx;
%     ypx2 = ypx; 
%     zpx2 = zpx;
%     
%     if ( xpx+s <= Nx && xpx-s > 0 )
%         tdotsrc(t, fix(xpx-s):fix(xpx+s), fix(ypx-s):fix(ypx+s), fix(zpx) ) = 2;
%     end
    
   % x(t) = xpx;
   % y(t) = ypx;
    
end
%plot( x, y ); 

tdotsrc(2000:Nt,:,:,:)=0;
tdotsrc = zeros(Nx,Ny,Nz);
PBHE_FDsolve_mex(T, tdotsrc, rCp,kt,dx)


roix=(32+pathradius)+ (-1:1);
roiy=(32)+ (-1:1);
roiz=[Nz/2];

roiSize = length(roix)*length(roiy)*length(roiz);

figure(2);
clf;
hold on;
f1=figure(1);
clf;
clear('mov'); clear('roiT');
ti=0;
for t=1:5:Nt
    figure(1);
    imagesc( squeeze(T(t,:,:,Nz/2)), [37 47] );
    colorbar;
    ti=ti+1;
    mov(ti) = getframe(gcf);
    
    figure(2);
    roiT(ti) = sum(sum( T(t, roix, roiy, roiz), 3 )) / roiSize;
    
    plot( t, roiT(ti), 'Marker', '+', 'LineStyle', 'none');
    
end


% vidwrite = VideoWriter('son_single_Nz=12.mp4', 'MPEG-4');
% open(vidwrite);
% 
% for t=1:ti
%     writeVideo(vidwrite,mov(t));
% end
% close(vidwrite);






% %% Thin
clear all;

Nt=4000;Nx=64;Ny=64;Nz=4;
T=zeros(Nt,Nx,Ny,Nz);
rCp=zeros(Nx,Ny,Nz);
kt=rCp;

tdotsrc=zeros(Nt,Nx,Ny,Nz);


dx=[0.01 0.001 0.001 0.005];

% for i=1:Nx
% 
%     for j=1:Ny
%         
%         for k=1:Nz
%             
%             T(1,i,j,k) = 37.0;
%             rCp(i,j,k) = 3700*1000;
%             kt(i,j,k) = 0.5;
%             
%         end
%     end
% end

T(:) = 37;
rCp(:) = 3700000;
kt(:) = 0.5;

%rCp(:,1:Nx/2,1:Ny/2,:) = 370000;

%T(1,1:10,Ny/2:Ny/2+3,Nz/2:Nz/2+3) =45;

%set up spiral path
focspeed_pix = 10.0*(Nx/Nt);
pathradius=10;

xpx0=32+pathradius;
ypx0=32;
zpx0=Nz/2;

xpx2=32-pathradius;
ypx2=32;
zpx2=zpx0;

s=2;


for t=1:Nt
    
    xpx = (xpx0-(focspeed_pix)*sin( t*(focspeed_pix/pathradius) ));
    ypx = (ypx0+focspeed_pix*cos( t*(focspeed_pix/pathradius) ));
    zpx = zpx0;
    
    xpx0 = xpx;
    ypx0 = ypx;
    zpx0 = zpx;
    
    if ( xpx+s <= Nx && xpx-s > 0 )
        tdotsrc(t, fix(xpx-s):fix(xpx+s), fix(ypx-s):fix(ypx+s), fix(zpx) ) = 4;
    end
    
    %multifoc
%     xpx = (xpx2-(focspeed_pix)*sin(pi+ t*(focspeed_pix/pathradius) ));
%     ypx = (ypx2+focspeed_pix*cos(pi+ t*(focspeed_pix/pathradius) ));
%     zpx = zpx2;
%     
%     xpx2 = xpx;
%     ypx2 = ypx; 
%     zpx2 = zpx;
%     
%     if ( xpx+s <= Nx && xpx-s > 0 )
%         tdotsrc(t, fix(xpx-s):fix(xpx+s), fix(ypx-s):fix(ypx+s), fix(zpx) ) = 2;
%     end
    
   % x(t) = xpx;
   % y(t) = ypx;
    
end
%plot( x, y ); 

tdotsrc(2000:Nt,:,:,:)=0;

PBHE_FDsolve_mex(T, tdotsrc, rCp,kt,dx)

roix=(32+pathradius)+ (-1:1);
roiy=(32)+ (-1:1);
roiz=[Nz/2];

roiSize = length(roix)*length(roiy)*length(roiz);

figure(3);
clf;
hold on;
f1=figure(1);
clf;
clear('mov'); clear('roiT');
ti=0;
for t=1:5:Nt
    figure(1);
    imagesc( squeeze(T(t,:,:,Nz/2)), [37 47] );
    colorbar;
    ti=ti+1;
    mov(ti) = getframe(gcf);
    
    figure(3);
    roiT(ti) = sum(sum( T(t, roix, roiy, roiz), 3 )) / roiSize;
    
    plot( t, roiT(ti), 'Marker', '+', 'LineStyle', 'none');
    
end


% vidwrite = VideoWriter('son_single_Nz=4.mp4', 'MPEG-4');
% open(vidwrite);
% 
% for t=1:ti
%     writeVideo(vidwrite,mov(t));
% end
% close(vidwrite);