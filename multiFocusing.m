
Nx = 150;
Ny = 256;



p_control = zeros(Nx, Ny);

%acoustic source positions
pixel_size = 0.0005;

r_foc = 25.4e-3*2.5;
c = 1540; % m/s
f_o = 1.5e6; % Hz
w = 2*pi*f_o; % rad/sec

kr = w/c;

rho = 1000; %kg per m^3
rho_c_k = rho*c*kr;

focal_rad_in_pixels = round(r_foc / pixel_size);
center_point = [Nx/2 10];

half_open_angle = pi/3.0;
N = round( 2.0*focal_rad_in_pixels*half_open_angle);
face_diameter_pixels = 2.0*focal_rad_in_pixels*(1 - cos(half_open_angle));

focal_point_pix = center_point + [0 focal_rad_in_pixels];

u_pos = zeros(N,2);

for n=1:N
   
    theta = half_open_angle*(n - N/2)/N;
    di = focal_rad_in_pixels*sin(theta);
    dj = focal_rad_in_pixels*(1 - cos(theta));
    
    i = floor(di + center_point(1));
    j = floor(dj + center_point(2));
    
    u_pos(n,:) = [i j];
end


%fociCenters = [ 20 48; 30 32; 48 48 ]/2;
fociCenters = [ focal_point_pix - [20 0]; focal_point_pix + [20 0] ] ;
radius_in_pixels = 1;

zeroPoints = [ 10 20;  32 20; 48 20 ]/2;
zrad=3;



pixelArea=pixel_size^2;

for i=1:Nx  
    for j=1:Ny
        for k=1:length(fociCenters)
            p_control(i,j) = p_control(i,j) + (1.0 / (2*pi*radius_in_pixels^2))*exp(-0.5*((i - fociCenters(k,1))/radius_in_pixels)^2.0)*exp(-0.5*((j - fociCenters(k,2))/radius_in_pixels)^2.0); 
        end
    end
end

ptestRe = zeros(Nx,Ny);
ptestIm = zeros(Nx,Ny);
for i=1:Nx  
    for j=1:Ny
        
        for n=1:N
            Rmn = norm(pixel_size*([i j] - u_pos(n,:) + 1)) ;
            ptestRe(i,j) = ptestRe(i,j) - rho_c_k*pixelArea * sin(kr*Rmn)/ Rmn;
            ptestIm(i,j) = ptestIm(i,j) + rho_c_k*pixelArea * cos(kr*Rmn)/ Rmn;
        end
    end
end
% 
% for k=1:length(zeroPoints)
%     
%     i0 = zeroPoints(k,1);
%     j0 = zeroPoints(k,2);
%     
%     for i=(i0-zrad):(i0+zrad)
% 
%         for j=round(j0-sqrt(zrad^2 - (i-i0)^2)):round(j0+sqrt(zrad^2 - (i-i0)^2))
% 
%             %p_control(i,j) = 0;
% 
%         end
% 
%     end
% 
% end


figure(1);
imagesc( ( transpose((ptestRe.^2 + ptestIm.^2)) ), [0 1e14] );
axis equal;

med_control = median(p_control(:));
max_control = max(p_control(:));

ii=find(p_control(:) >= (med_control + 0.8*(max_control-med_control)) );



p2 = p_control.*0;
p2(ii)= 10*max_control;

figure(2);
imagesc( transpose(p2) );
axis equal;
M = length(ii);

Hre = zeros(M, N);
Him = zeros(M, N);
H = Hre;

srcarea=pixelArea; nzeros=0;
for m=1:M 
   
    q = ii(m);
    
    j = mod(q-1, Ny) + 1;
    i = floor((q-1)/Ny) + 1;
    
    rm = [i j] ;
    
    for n=1:N
        
        Rmn = pixel_size*norm(rm - u_pos(n,:) + 1) ;
        if Rmn == 0
            Rmn=0;
        end
        if Rmn > 0
        Hre(m, n) = -rho_c_k*srcarea*sin( kr * Rmn ) / Rmn;
        Him(m, n) = rho_c_k*srcarea*cos( kr * Rmn ) / Rmn;
        
%         H(m,n) = rho_c_k*1i*exp(-1i*kr*Rmn) / Rmn;
        
        else
           nzeros=nzeros+1; 
        end
    end
end

H0t = transpose(Hre);
H1t = transpose(Him);

H00 = H0t*Hre;
H11 = H1t*Him;
H01 = H0t*Him;
H10 = H1t*Hre;

uRe = ones(N,1);
uIm = uRe;

pRe = p_control(ii);
pRe(:)=5e13;
pIm = zeros(M,1);

H = Hre + 1i*Him;
Hinv = pinv(H);

Hstar_t = ctranspose(H);
HHstar_tinv = pinv(H*Hstar_t);
%uopt = Hinv*[1e12;1e12];
uopt = Hstar_t*HHstar_tinv*(pRe + 1i*pIm);

for k=1:1

    stepRe = H0t*pRe + H1t*pIm + (H01 - H10)*uIm - (H00 + H11)*uRe;
    stepIm = H0t*pIm - H1t*pRe - (H01 - H10)*uRe - (H00 + H11)*uIm;

    HvRe = Hre*stepRe - Him*stepIm;
    HvIm = Hre*stepIm + Him*stepRe;

    hvnorm = sum( HvRe.^2 + HvIm.^2 );
    stnorm = sum( stepRe.^2 + stepIm.^2);

    mult = stnorm / hvnorm;

    uRe = uRe + mult*stepRe;
    uIm = uIm + mult*stepIm;
    
end


p_reconRe = zeros(Nx, Ny);
p_reconIm = p_reconRe;
% 
% uRe = real(uopt);
% uIm = imag(uopt);


for i=1:Nx
   
    for j=1:Ny
     
        for n=1:N
            
            Rmn = pixel_size*norm([i j] - u_pos(n,:) + 1) ;

            hRe = -rho_c_k*srcarea*sin( kr * Rmn ) / Rmn;
            hIm = rho_c_k*srcarea*cos( kr * Rmn ) / Rmn;
        
            p_reconRe(i,j) = p_reconRe(i,j) + (hRe*uRe(n) - hIm*uIm(n));
            p_reconIm(i,j) = p_reconIm(i,j) + (hRe*uIm(n) + hIm*uRe(n));
        
        end
    end
    
end

p_recon = (p_reconRe.^2 + p_reconIm.^2);

figure(3);
imagesc( (transpose(p_recon)), [0 max(p_recon(:))*0.05] );
axis equal;
% m = j + (i-1)*Ny;
% i = floor((m-j)/Ny) + 1












