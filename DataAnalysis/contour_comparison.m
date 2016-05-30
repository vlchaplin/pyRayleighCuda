dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150621';
%file = [dir,'\Caskey_999_05_01_14.29.16_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_12_01_15.27.34_(TemperatureMapping_CLEAR).PAR'];
files_to_compare = {...
     [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'],...
     [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR']
    };

% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150731';
% 
% files_to_compare = {...
%      [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'],...
%      [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR']
%     };

%dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150811';

% files_to_compare = {...
% %     [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'],...
% %     [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR'];
% %    [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_14_1.PAR'],...
% %    [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_15_1.PAR']
% %      [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_17_1.PAR'],...
% %      [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_16_1.PAR']
%         [dir,'\Caskey_GPhantom_150811_7_1.PAR'],...
%      [dir,'\Caskey_GPhantom_150811_8_1.PAR']
%     };
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150822';
% files_to_compare = {...
% %      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_12_1.PAR'],...
% %      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_8_1.PAR']
% %      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_11_1.PAR'],...
% %      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_10_1.PAR']
%      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_7_1.PAR'],...
%      [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_13_1.PAR']
%     };
dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150915';
files_to_compare = {...
     [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'],...
     [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR']
    };

isRI=0;
angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);

[ deltaTseries1, axis0_mm1, axis1_mm1, slice_axis_mm1, dyntimes1, im1 ] = GetDeltaTemp4D_PAR( files_to_compare{1}, isRI, 0.01, angle2tempFactor );
[ deltaTseries2, axis0_mm2, axis1_mm2, slice_axis_mm2, dyntimes2, im2 ] = GetDeltaTemp4D_PAR( files_to_compare{2}, isRI, 0.01, angle2tempFactor );

dV1 = prod(im1.Spc(1:3))*1e-3;
dV2 = prod(im2.Spc(1:3))*1e-3;

% do phase unwrap
mask = (deltaTseries1/angle2tempFactor) <= -0.8*pi;
deltaTseries1(mask) = deltaTseries1(mask) + 2*pi*angle2tempFactor;

mask = (deltaTseries2/angle2tempFactor) <= -0.8*pi;
deltaTseries2(mask) = deltaTseries2(mask) + 2*pi*angle2tempFactor;

T01 = 22;
T02 = 22;
% calc cem
rbase1 = 4.0*ones(size(deltaTseries1));
rbase2 = 4.0*ones(size(deltaTseries2));
rbase1( (T01+deltaTseries1) > 43.0 ) = 2.0;
rbase2( (T02+deltaTseries2) > 43.0 ) = 2.0;

cem1 = cumsum( rbase1.^((T01+deltaTseries1) - 43.0),4 ) .* repmat( reshape(dyntimes1/60.0,[1 1 1 length(dyntimes1)]), [im1.Dims(1:3) 1]) ;
cem2 = cumsum( rbase2.^((T02+deltaTseries2) - 43.0),4 ) .* repmat( reshape(dyntimes2/60.0,[1 1 1 length(dyntimes2)]), [im2.Dims(1:3) 1]) ;
%%
% calc offset time of HIFU start b/w data sets

%2015-06-21
sliceset = [8:11];
idx0 = 55:70;
idx1 = 55:70;

% sliceset = [1:5];
% idx0 = 31:50;
% idx1 = 30:44;
% 
% %2015-08-11
% sliceset = [7:9];
% idx0 = 33:37;
% idx1 = 36:42;
% 
% %2015-08-22
% sliceset = [3:7];
% idx0 = 37:47;
% idx1 = 33:49;

%2015-09-15
sliceset = [5:8];
idx0 = 55:65;
idx1 = 42:60;

roiMask = zeros(im1.Dims(1:3));
roiMask(idx0, idx1, sliceset)=1;
avgTcurve1 = squeeze(mean(mean(mean(deltaTseries1(idx0, idx1, sliceset,:),1),2),3));
avgTcurve2 = squeeze(mean(mean(mean(deltaTseries2(idx0, idx1, sliceset,:),1),2),3));
%avgCEM1 = squeeze(mean(mean(mean(cem1(idx0, idx1, sliceset,:),1),2),3));
%avgCEM2 = squeeze(mean(mean(mean(cem2(idx0, idx1, sliceset,:),1),2),3));

lesionVox1 = squeeze(sum(sum(sum( cem1 > 240.0, 1),2),3));
lesionVox2 = squeeze(sum(sum(sum( cem2 > 240.0, 1),2),3));

sthresh1 = find( cumsum(avgTcurve1) > 0.5 );
sthresh2 = find( cumsum(avgTcurve2) > 0.5 );


shift12 = sthresh1(1) - sthresh2(1) + 1;
%%

s1 = (1:im1.Dims(5));
figure(2);
clf;
subplot(121);
hold on;
plot( dyntimes1, avgTcurve1, '-', 'Color',[0.9 0.4 0.1] );
plot( dyntimes2 + dyntimes1(sthresh1(1)) - dyntimes2(sthresh2(1)), avgTcurve2, '-','Color',[0.1 0.4 0.9] );
xlabel('sec');
ylabel('\langle\DeltaT\rangle ^oC');
subplot(122);
hold on;
plot( dyntimes1, dV1*lesionVox1, '-', 'Color',[0.9 0.4 0.1] );
plot( dyntimes2 + dyntimes1(sthresh1(1)) - dyntimes2(sthresh2(1)), dV2*lesionVox2, '-','Color',[0.1 0.4 0.9] );
xlabel('sec');
ylabel('ml');
%set(gca, 'YLim',[0 240]);
%plot( avgTcurve1, '-*', 'Color',[0.9 0.4 0.1] );
%plot( shift12:im2.Dims(5), avgTcurve2(1:end-shift12+1), '-*','Color',[0.1 0.4 0.9] );

%%
slicenum=14;

%dyns = [20 30 39 49 60 70];
dyns = [15 20 23 26 29 32];
dyns = [8 15 20 29 37 47];
ncol = 3;
if ncol > length(dyns)
    ncol = length(dyns);
    nrow=1;
else
nrow = ceil(length(dyns)/ncol);
end

rf = 1; gf=0.4; bf=0.4;
roiImSliceRGB = cat(3, rf*roiMask(:,:,slicenum), gf*roiMask(:,:,slicenum), bf*roiMask(:,:,slicenum));

figure(8);
clf;
hold on;
for d=1:length(dyns)
    r=floor((d-1)/ncol) + 1 ;
    c=mod( (d-1),nrow) + 1;
    
    ph = subplot(nrow,ncol,d);
    
    dn = dyns(d);
    dn2 = dn - shift12;
    hold on;
    colormap('gray');
    imagesc(axis1_mm1, axis0_mm1, im1.Data(:,:,slicenum,1,1));
    text( 0.05, 0.1, sprintf('t=%0.1f sec', dyntimes1(dn) ), 'FontSize',20,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );

    image(axis1_mm1, axis0_mm1, roiImSliceRGB, 'AlphaDataMapping', 'none', 'AlphaData', 0.4*roiMask(:,:,slicenum) )
    
    contour(axis1_mm1, axis0_mm1, cem1(:,:,slicenum,dn), [240 240], 'LineWidth', 2.0, 'Color', [0.9 0.4 0.1] );
    contour(axis1_mm2, axis0_mm2, cem2(:,:,slicenum,dn2), [240 240], 'LineWidth', 2.0, 'Color', [0.1 0.4 0.9] );

    xlabel('mm','FontSize',18);
    ylabel('mm','FontSize',18);
    set(gca, 'FontSize', 20);
    axis equal;
    
    set( ph, 'Position', [1 1 1.01 1.05] .* get(ph,'Position') );
    
end

%%
slicenum=11;
rf = 1; gf=0.4; bf=0.4;
roiImSliceRGB = cat(3, rf*roiMask(:,:,slicenum), gf*roiMask(:,:,slicenum), bf*roiMask(:,:,slicenum));

figure(9);
clf;
hold on;
for d=1:length(dyns)
    r=floor((d-1)/ncol) + 1 ;
    c=mod( (d-1),nrow) + 1;
    
    ph=subplot(nrow,ncol,d);
    
    dn = dyns(d);
    dn2 = dn - shift12;
    
    hold on;
    %colormap('gray');
    %imagesc(axis1_mm1, axis0_mm1, im1.Data(:,:,slicenum,1,1));
    text( 0.05, 0.1, sprintf('t=%0.1f sec', dyntimes1(dn) ), 'FontSize',20,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );
    
    image(axis1_mm1, axis0_mm1, roiImSliceRGB, 'AlphaDataMapping', 'none', 'AlphaData', 0.4*roiMask(:,:,slicenum) );
    
    contour(axis1_mm1, axis0_mm1, deltaTseries1(:,:,slicenum,dn), [10 20], 'LineWidth', 2.0, 'Color', [0.9 0.4 0.1] );
    contour(axis1_mm2, axis0_mm2, deltaTseries2(:,:,slicenum,dn2), [10 20], 'LineWidth', 2.0, 'Color', [0.1 0.4 0.9] );

    xlabel('mm','FontSize',18);
    ylabel('mm','FontSize',18);
    set(gca, 'FontSize', 20);
    axis equal;
    
    set( ph, 'Position', [1 1 1.01 1.05] .* get(ph,'Position') );
end

%%
slicenum=7;
dn=90;
dn2 = dn - shift12;

mask=squeeze(deltaTseries1(:,:,slicenum,dn)) > 1.0;
deltadeltaT = deltaTseries1(:,:,slicenum,dn) - deltaTseries2(:,:,slicenum,dn2);

magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
magImGray = magImGray/max(magImGray(:));

figure(10);
clf;
hold on;
colormap('gray');
imagesc(axis1_mm1, axis0_mm1, magImGray);

colormap('jet');
imagesc(axis1_mm1, axis0_mm1, squeeze(deltadeltaT), 'AlphaDataMapping', 'none', 'AlphaData', mask, [-20 20]  );
colorbar();

