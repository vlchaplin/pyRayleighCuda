dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150621';
%file = [dir,'\Caskey_999_05_01_14.29.16_(TemperatureMapping_CLEAR).PAR'];
file = [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_12_01_15.27.34_(TemperatureMapping_CLEAR).PAR'];

% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150731';
% file = [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_15_1.PAR'];
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150811';
% file = [dir,'\Caskey_GPhantom_150811_7_1.PAR'];
% 
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150822';
% file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_4_1.PAR'];


%whether they are mag & phase or real and imaginary
is_RI_image = 1;
flipSliceDir=0;
flipSliceAxisLabelDir=1;

im = vuOpenImage(file);


if flipSliceDir
    im.Data = flip(im.Data,3);
end

if is_RI_image
    tempComplex = im.Data(:,:,:,1,:) + 1j*im.Data(:,:,:,2,:);
    
    im.Data(:,:,:,1,:) = abs(tempComplex);
    im.Data(:,:,:,2,:) = angle(tempComplex);
    
    clear('tempComplex');
end

slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;


dyntimes = im.Parms.tags(1:2*im.Dims(3):im.Dims(5)*im.Dims(3)*2, dyn_time_col);

[dyntimes,dynamicIdxReorder] = sort(dyntimes);

magmeanForMask = mean(im.Data(:,:,:, 1, :),5);
outsideVox = ( magmeanForMask/ max(magmeanForMask(:)) < 0.03 );



nslice = im.Dims(3);
ndynamics = im.Dims(5);

slice_axis_mm = zeros([1 nslice]);

axis0_mm = (1:im.Dims(1))*im.Spc(1);
axis1_mm = (1:im.Dims(2))*im.Spc(2);

deltaTseries =  zeros(im.Dims([1,2,3,5]));
deltaTseriesCorr =  zeros(im.Dims([1,2,3,5]));

refStack = (im.Data(:,:,:,1,1).*exp(1i*im.Data(:,:,:,2,1)));

angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);

for dn=2:ndynamics

    complexStack = squeeze( (im.Data(:,:,:,1,dn).*exp(1i*im.Data(:,:,:,2,dn))) );
    deltaTseries(:,:,:,dn) = (1-outsideVox).*angle(refStack.*conj(complexStack)) *angle2tempFactor; 
end

% phase un-wrapping 
mask = (deltaTseries/angle2tempFactor) <= -0.8*pi;
deltaTseriesCorr = deltaTseries;
deltaTseriesCorr(mask) = deltaTseriesCorr(mask) + 2*pi*angle2tempFactor;

T0=25;
rbase = 4.0*ones(size(deltaTseries));
rbase( (T0+deltaTseriesCorr) > 43.0 ) = 2.0;

cem = cumsum( rbase.^((T0+deltaTseriesCorr) - 43.0),4 ) .* repmat( reshape(dyntimes/60.0,[1 1 1 ndynamics]), [im.Dims(1:3) 1]) ;

%%
figure(1);
clf;
hold on;
dn=ndynamics;
%dn=1;
slicenum=17;
minC=0; maxC=30;
%axis1_mm, axis0_mm, 
magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
magImGray = magImGray/max(magImGray(:));
imagesc( axis1_mm, axis0_mm,magImGray);
mask=squeeze(deltaTseriesCorr(:,:,slicenum,dn)) > 1.0;
colormap('hot');
imagesc(axis1_mm, axis0_mm,deltaTseriesCorr(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
% 
% figure(2);
% colormap('gray');
% imagesc(im.Data(:,:,slicenum,1,dn));


%%

figure(3);
clf;
dynamicsToPlot = 1:ndynamics;
% dynamicsToPlot = 1:6;
%dynamicsToPlot = 1:30;
%dynamicsToPlot=ndynamics-4:ndynamics;

slicenum=11;
colormap('hot');
clear('movie2DFrames');
movie2DFrames(length(dynamicsToPlot)) = struct('cdata',[],'colormap',[]);

magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
magImGray = magImGray/max(magImGray(:));



for di=1:length(dynamicsToPlot)
    dn=dynamicsToPlot(di);
    deltaTstack = deltaTseriesCorr(:,:,:,dn);
    
    mask=squeeze(deltaTseriesCorr(:,:,slicenum,dn)) > 5.0;
    
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
sliceset = [4:5];
idx0 = 37:47;
idx1 = 33:42;


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
dn=ndynamics;
dn=20;

figure(8);
% clf;
% hold on;
% colormap('gray');
% imagesc(axis1_mm, axis0_mm, im.Data(:,:,slicenum,1,1));
% text( 0.05, 0.1, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',20,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );
% 
% % % multi
% contour(axis1_mm, axis0_mm, cem(:,:,slicenum,dn), [240 240], 'LineWidth', 2.0, 'Color', [0.9 0.4 0.1] );

 contour(axis1_mm, axis0_mm, cem(:,:,slicenum,dn), [240 240], 'LineWidth', 2.0, 'Color', [0.1 0.4 0.9] );

xlabel('mm','FontSize',20);
ylabel('mm','FontSize',20);
set(gca, 'FontSize', 22);
axis equal tight;

%%
figure(9);
clf;
hold on;
colormap('hot');
%imagesc(axis1_mm, axis0_mm, im.Data(:,:,slicenum,1,1));
%text( 0.05, 0.1, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',20,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );

% % multi
%contour(axis1_mm, axis0_mm, deltaTseriesCorr(:,:,slicenum,dn), [30 30], 'LineWidth', 2.0, 'Color', [0.9 0.4 0.1] );
subplot(121);
imagesc(  squeeze(cem(34,:,6:10,dn)), [0 240] );
axis equal tight;
subplot(122);
imagesc( squeeze(cem(37,:,6:10,dn)), [0, 240] );
%contour(axis1_mm, axis0_mm, deltaTseriesCorr(:,:,slicenum,dn), [30 30], 'LineWidth', 2.0, 'Color', [0.1 0.4 0.9] );

xlabel('mm','FontSize',20);
ylabel('mm','FontSize',20);
set(gca, 'FontSize', 22);
axis equal tight;








