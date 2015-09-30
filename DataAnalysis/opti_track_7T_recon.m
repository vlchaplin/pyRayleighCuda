dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150621';
%file = [dir,'\Caskey_999_05_01_14.29.16_(TemperatureMapping_CLEAR).PAR'];
file = [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_12_01_15.27.34_(TemperatureMapping_CLEAR).PAR'];

% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150731';
% file = [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_15_1.PAR'];
% 
dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150811';
file = [dir,'\Caskey_GPhantom_150811_6_1.PAR'];
%file = [dir,'\Caskey_GPhantom_150811_7_1.PAR'];
% 
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150822';
% file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_4_1.PAR'];


dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150915';
file = [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'];
%file = [dir,'\Caskey_GPhantom_150811_7_1.PAR'];
% 

% file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_20_01_12.10.22_(WIP_TemperatureMapping).PAR'
file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_11_01_10.53.21_(WIP_TemperatureMapping).PAR'

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_17_01_11.52.02_(WIP_TemperatureMapping).PAR'
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_18_01_11.57.08_(WIP_TemperatureMapping).PAR'


%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_17_01_11.52.02_(WIP_TemperatureMapping).PAR'
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_18_01_11.57.08_(WIP_TemperatureMapping).PAR'

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_20_01_12.10.22_(WIP_TemperatureMapping).PAR'
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_21_01_12.20.12_(WIP_TemperatureMapping).PAR'
% 

%whether they are mag & phase or real and imaginary
is_RI_image = 1;
flipSliceDir=0;
flipSliceAxisLabelDir=0;

im = vuOpenImage(file);


if flipSliceDir
    im.Data = flip(im.Data,3);
end



if is_RI_image
    tempComplex = im.Data(:,:,:,2,:) + 1j*im.Data(:,:,:,3,:);
    
    im.Data(:,:,:,1,:) = abs(tempComplex);
    im.Data(:,:,:,2,:) = angle(tempComplex);
    
    clear('tempComplex');
end

slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;

sliceOri=im.Parms.tags(1,26);
dyntimes = im.Parms.tags(1:2*im.Dims(3):im.Dims(5)*im.Dims(3)*2, dyn_time_col);

[dyntimes,dynamicIdxReorder] = sort(dyntimes);

magmeanForMask = mean(im.Data(:,:,:, 1, :),5);
outsideVox = ( magmeanForMask/ max(magmeanForMask(:)) < 0.03 );



nslice = im.Dims(3);
ndynamics = im.Dims(5);

slice_axis_mm = zeros([1 nslice]);

axis0_mm = (1:im.Dims(1))*im.Spc(1);
axis1_mm = (1:im.Dims(2))*im.Spc(2);
slice_axis_mm = (1:im.Dims(3))*im.Spc(3);

deltaTseries =  zeros(im.Dims([1,2,3,5]));
deltaTseriesCorr =  zeros(im.Dims([1,2,3,5]));

refStack = (im.Data(:,:,:,1,1).*exp(1i*im.Data(:,:,:,2,1)));

B0 = 7.0;
TE = 0.010;
angle2tempFactor = 1.0 / (42.576*0.01*B0*TE*pi);

for dn=2:ndynamics

    complexStack = squeeze( (im.Data(:,:,:,1,dn).*exp(1i*im.Data(:,:,:,2,dn))) );
    deltaTseries(:,:,:,dn) = (1-outsideVox).*angle(refStack.*conj(complexStack)) *angle2tempFactor; 
end

% phase un-wrapping 
mask = (deltaTseries/angle2tempFactor) <= -0.3*pi;
deltaTseriesCorr = deltaTseries;
deltaTseriesCorr(mask) = deltaTseriesCorr(mask) + 2*pi*angle2tempFactor;

T0=21;
rbase = 4.0*ones(size(deltaTseries));
rbase( (T0+deltaTseriesCorr) > 43.0 ) = 2.0;


cem = cumsum( rbase.^((T0+deltaTseriesCorr) - 43.0),4 ) .* repmat( reshape(dyntimes/60.0,[1 1 1 ndynamics]), [im.Dims(1:3) 1]) ;



% 
% deltaTseriesCorr = squeeze(im.Data(:,:,:,1,:));
% deltaTseriesCorr = 20*deltaTseriesCorr/max(deltaTseriesCorr(:));

%%
figure(2);
clf;
hold on;
dn=ndynamics;
%dn=10;
slicenum=2;
minC=0; maxC=30;
%axis1_mm, axis0_mm, 
magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
%magImGray = magImGray/max(magImGray(:));

magImGray = ( magImGray - min(magImGray(:)) ) / ( max(magImGray(:)) - min(magImGray(:)) );
magImGray( magImGray > 0.9 ) = 0.9;
magImGray = magImGray / 0.9;

imagesc( axis1_mm, axis0_mm,magImGray, [0.0 1.0]);
mask=squeeze(deltaTseriesCorr(:,:,slicenum,dn)) > 1.0;
colormap('hot');
imagesc(axis1_mm, axis0_mm,deltaTseriesCorr(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
c=colorbar();
c.Label.String='\DeltaT^oC';
c.Label.FontSize=18;
axis equal tight;

xlabel('mm', 'Fontsize', 16);
ylabel('mm', 'Fontsize', 16);

set(gca, 'FontSize',16);

% 
% figure(2);
% colormap('gray');
% imagesc(im.Data(:,:,slicenum,1,dn));


%%

figure(2);
clf;
dynamicsToPlot = 1:ndynamics;
% dynamicsToPlot = 1:6;
%dynamicsToPlot = 1:30;
%dynamicsToPlot=ndynamics-4:ndynamics;

slicenum=2;
colormap('hot');
clear('movie2DFrames');
movie2DFrames(length(dynamicsToPlot)) = struct('cdata',[],'colormap',[]);

magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
magImGray = magImGray/max(magImGray(:));



for di=1:length(dynamicsToPlot)
    dn=dynamicsToPlot(di);
    deltaTstack = deltaTseriesCorr(:,:,:,dn);
    
    mask=squeeze(deltaTseriesCorr(:,:,slicenum,dn)) > 3.0;
    
    if di==1 
        set(gcf,'Color', 'white');
        subplot(121);
        hold on;
        imagesc(magImGray);
        imA=imagesc(deltaTstack(:,:,slicenum), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
        colorbar();
        textlab=text( 0.05, 0.1, sprintf('[%d] t=%0.1f sec', dn, dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );
        axis equal tight;
        subplot(122);
        hold on;
        imagesc(magImGray);
        imB=imagesc(cem(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [0 240]);
        colorbar();
        set(gca, 'YDir', 'Normal');
        axis equal tight;
    else
        %deltadeltaPhase = (deltaTstack(:,:,slicenum) - deltaTseries(:,:,slicenum,dn))/angle2tempFactor;
        %wrappix = abs(deltadeltaPhase) >= 1.7*pi;
        %dT = deltaTstack(:,:,slicenum-1);
        %dT(wrappix) =  
        %deltadeltaPhase(wrappix) = deltadeltaPhase(wrappix) + 2*pi; 
        %dT(wrappix) = dT(wrappix) + deltadeltaPhase(wrappix)*angle2tempFactor;
        %dT = dT + deltadeltaPhase*angle2tempFactor;
        %deltaTstack(:,:,slicenum) = dT;
        imA.CData = deltaTstack(:,:,slicenum);
        imB.CData = cem(:,:,slicenum,dn);
        
        imA.AlphaData = mask;
        imB.AlphaData = mask;
        set(textlab,'String', sprintf('[%d] t=%0.1f sec', dn, dyntimes(dn) ) );
        
        %subplot(122);
        
        %imB.CData=deltadeltaPhase;
        
        
    end
    drawnow;
    movie2DFrames(di) = getframe(gcf);
end
%%
%2015-07-13
% sliceset = [1:5];
% idx0 = 33:47;
% idx1 = 40:48;

%2015-08-11
sliceset = [7:9];
idx0 = 33:37;
idx1 = 36:42;
idx0 = 47:52;
% sliceset=6;
% idx0=49;
% idx1=39;

%idx0 = 36:43;
%idx1 = 42:47;

%2015-08-22
% sliceset = [4:5];
% idx0 = 37:47;
% idx1 = 33:42;

2015-09-15
sliceset = [3:9];
idx0 = 55:65;
idx1 = 42:60;

avgTcurve = squeeze(mean(mean(mean(deltaTseriesCorr(idx0, idx1, sliceset,:),1),2),3));

sthresh = find( cumsum(avgTcurve) > 0.5 );

figure(5);
hold on;
plot(dyntimes - dyntimes(sthresh(1)), avgTcurve);
xlabel('sec', 'FontSize', 18);
ylabel('\DeltaT (^oC)', 'FontSize', 18);

T0 = 25;
figure(7);
hold on;
rbase=4*ones(size(avgTcurve));
rbase( (T0 + avgTcurve) > 43 )=2.0;
cemcurve = cumsum((rbase.^((T0 + avgTcurve)-43))) .* dyntimes/60.0 ;
plot(dyntimes - dyntimes(sthresh(1)), cemcurve);


%%



%%
idx0range=1:im.Dims(1);
idx1range=1:im.Dims(2);

idx0range=30:90;
idx1range=20:81;

slices=1:11
[tx, ty, tz] = ndgrid( axis0_mm(idx0range), axis1_mm(idx1range), slice_axis_mm(slices) );
%[tx, ty, tz] = meshgrid( axis1_mm, axis0_mm, slice_axis_mm );
%[tx, ty, tz] = meshgrid( 1:64, 1:64, 1:7 );
Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

magmean = mean(im.Data(idx0range,idx1range,1:2,1,2),3);

dynidx = 40;
deltaTstack = deltaTseriesCorr(idx0range, idx1range, slices, dynidx);

deltaTstack = permute(deltaTstack,[2 1 3]);

figure(5);
clf;
hold on;

light('Position', [240 240 10], 'Style', 'local');
%light('Position', [40 0 10], 'Style', 'local');

cval1 = 30;
p1=patch( isosurface( tx, ty, tz, deltaTstack, cval1 ) );
isonormals(tx, ty, tz, deltaTstack, p1);
set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 55, 'BackFaceLighting', 'unlit' ...
    );

cval2 = 20;
p2=patch( isosurface( tx, ty, tz, deltaTstack, cval2 ) );
isonormals(tx, ty, tz, deltaTstack,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 'yellow', 'EdgeColor', 'none','FaceAlpha',0.6, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

cval3 = 10;
p3=patch( isosurface( tx, ty, tz, deltaTstack, cval3 ) );
isonormals(tx, ty, tz, deltaTstack,p3);
set(p3, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .9, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5  ...
    );

%magmean = deltaTstack(:,:,1);
%colormap('gray');
%surf(axis1_mm, axis0_mm, 0+zeros(size(magmean)), magmean, 'EdgeColor','none');

text( 10, 10, 10, sprintf('t=%0.1f sec', dyntimes(dynidx) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );

legend([p1 p2 p3], {sprintf('+%2d C', cval1), sprintf('+%2d C', cval2), sprintf('+%2d C', cval3)})
axis equal tight;
xlabel('x mm');
ylabel('y mm');
zlabel('mm');

set(gca, 'CameraPosition', [1400  1000  600]);


