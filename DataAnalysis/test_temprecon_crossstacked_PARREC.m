dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150621';
%file = [dir,'\Caskey_999_05_01_14.29.16_(TemperatureMapping_CLEAR).PAR'];
file = [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_12_01_15.27.34_(TemperatureMapping_CLEAR).PAR'];

dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150731';
file = [dir,'\Caskey_20150731_WIP_TemperatureMapping_CLEAR_16_1.PAR'];
% 
dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150811';
%file = [dir,'\Caskey_GPhantom_150811_6_1.PAR'];
file = [dir,'\Caskey_GPhantom_150811_7_1.PAR'];
% 
% 
dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150822';
%file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_8_1.PAR'];
file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_9_1.PAR'];

file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_15_1.PAR'];
%file = [dir,'\Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_16_1.PAR'];

% dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150915';
% file = [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR'];
%file = [dir,'\Caskey_GPhantom_150811_7_1.PAR'];
% 

% dir = 'C:\Users\Vandiver\Data\sonalleve\Hifu_20150924\phant1';
% file = [dir,'\Caskey_20150924_WIP_TemperatureMapping_CLEAR_8_1.PAR'];
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Hifu_20150924\egg1';
% file = [dir,'\Caskey_20150924_WIP_TempMapEgg1_CLEAR_20_1.PAR'];
% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\Hifu_20150924\egg2';
% file = [dir,'\Caskey_20150924_WIP_TempMapEgg2_CLEAR_30_1.PAR'];
% 

%dir = 'C:\Users\Vandiver\Data\sonalleve\Hifu_20150926';
% %file = [dir,'\Caskey_20150926_WIP_TMap_Sing_60W_CLEAR_4_1.PAR'];
% %file = [dir,'\Caskey_20150926_WIP_TMap_Mult_60W_CLEAR_3_1.PAR'];
% % 
%file = [dir,'\Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR'];
% %file = [dir,'\Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR'];
% % 
% file = [dir,'\Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR'];
% %file = [dir,'\Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR'];
 
%whether they are mag & phase or real and imaginary
is_RI_image = 0;
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
slice_axis_mm = (1:im.Dims(3))*im.Spc(3);

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
%dn=10;
slicenum=6;
minC=0; maxC=30;
%axis1_mm, axis0_mm, 
magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
magImGray = magImGray/max(magImGray(:));

mask=squeeze(deltaTseriesCorr(:,:,slicenum,dn)) > 1.0;
colormap('hot');

use_mm_scale=0
if use_mm_scale
    imagesc(axis1_mm, axis0_mm, magImGray);
    imagesc(axis1_mm, axis0_mm,deltaTseriesCorr(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
else
    imagesc(magImGray);
    imagesc(deltaTseriesCorr(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
end
%set(gca, 'YDir', 'Reverse');
% 
% figure(2);
% colormap('gray');
% imagesc(im.Data(:,:,slicenum,1,dn));


%%

figure(2);
clf;
dynamicsToPlot = 1:ndynamics;
%dynamicsToPlot = 1:5;
%dynamicsToPlot = 1:30;
%dynamicsToPlot=ndynamics-4:ndynamics;

slicenum=3;
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
% idx0 = 30:50;
% idx1 = 35:45;

%2015-08-11
sliceset = [2:8];
idx0 = 30:44;
idx1 = 32:45;


% sliceset=6;
% idx0=49;
% idx1=39;

%idx0 = 36:43;
%idx1 = 42:47;

%2015-08-22
% sliceset = [2:8];
% idx0 = 39:49;
% idx1 = 36:46;

%2015-08-22 scans 15-16
sliceset = [1:5];
idx0 = 41:54;
idx1 = 36:46;

%2015-09-15
% sliceset = [3:9];
% idx0 = 55:65;
% idx1 = 42:60;

%2015-09-24  phantom 1
% sliceset = [5:9];
% idx0 = 70:88;
% idx1 = 66:78;
% 
% %2015-09-24  egg 1
% sliceset = [5:10];
% idx0 = 66:82;
% idx1 = 68:76;
% 
% %2015-09-24  egg 2
% sliceset = [4:12];
% idx0 = 66:82;
% idx1 = 68:76;

% %2015-09-26  phantom 1
% sliceset = [4:9];
% idx0 = 107:125;
% idx1 = 105:118;

lesionVol = squeeze(sum(sum(sum(cem(idx0, idx1, sliceset,:) >= 240.0,1),2),3));

avgTcurve = squeeze(mean(mean(mean(deltaTseriesCorr(idx0, idx1, sliceset,:),1),2),3));

sthresh = find( cumsum(avgTcurve) > 0.5 );

figure(5);
hold on;
plot(dyntimes - dyntimes(sthresh(1)-1), avgTcurve);
xlabel('sec', 'FontSize', 18);
ylabel('\DeltaT (^oC)', 'FontSize', 18);

T0 = 25;
figure(7);
hold on;
% rbase=4*ones(size(avgTcurve));
% rbase( (T0 + avgTcurve) > 43 )=2.0;
% cemcurve = cumsum((rbase.^((T0 + avgTcurve)-43))) .* dyntimes/60.0 ;
plot(dyntimes - dyntimes(sthresh(1)), prod(im.Spc)*1e-3*lesionVol);
xlabel('sec', 'FontSize', 18);
ylabel('lesion size (mL)', 'FontSize', 18);

%%



%%
idx0range=1:im.Dims(1);
idx1range=1:im.Dims(2);

% idx0range=30:90;
% idx1range=20:81;

slices=1:im.Dims(3);
slices=1:10;

[tx, ty, tz] = ndgrid( axis0_mm(idx0range), axis1_mm(idx1range), slice_axis_mm(slices) );
%[tx, ty, tz] = meshgrid( axis1_mm, axis0_mm, slice_axis_mm );
%[tx, ty, tz] = meshgrid( 1:64, 1:64, 1:7 );
Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

magstack = im.Data(idx0range,idx1range,slices,1,2);
magstack = magstack / max(magstack(:));
magmean = mean(magstack,3);
magmean = magmean/max(magmean(:));

dynidx = ndynamics;
%dynidx = 40;
deltaTstack = max( deltaTseriesCorr(idx0range, idx1range, slices, 1:dynidx),[], 4);
deltaTstack( magstack < 0.05 ) = 0.0;
deltaTstack = permute(deltaTstack,[2 1 3]);

figure(9);
clf;
hold on;

xboxr=axis0_mm(idx0([1 end]));
yboxr=axis1_mm(idx1([1 end]));
zboxr=slice_axis_mm(sliceset([1 end]));
xyboxverts= [ xboxr([1 1 2 2 1]) ; yboxr([1 2 2 1 1]) ];
plot3( xyboxverts(1,:), xyboxverts(2,:), zboxr(2) + zeros([1 5]), 'LineStyle','--','LineWidth',2, 'Color', [0.7 0.7 1.0] );
plot3( xyboxverts(1,:), xyboxverts(2,:), zboxr(1) + zeros([1 5]), 'LineStyle','--','LineWidth',2, 'Color', [0.7 0.7 1.0] );
for i=1:4
    plot3( xyboxverts(1,[i i]), xyboxverts(2,[i i]), zboxr, 'LineStyle','--','LineWidth',2, 'Color', [0.7 0.7 1.0] );

end

light('Position', [-30 -30 100], 'Style', 'local');
%light('Position', [40 0 10], 'Style', 'local');

cval1 =30;
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
surf(axis0_mm, axis1_mm, 0+zeros(size(magmean')), repmat( magmean', [1 1 3]) / max( magmean(:)), 'EdgeColor','none');

text( 10, 10, 10, sprintf('t=%0.1f sec', dyntimes(dynidx) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );

legend([p1 p2 p3], {sprintf('+%2d C', cval1), sprintf('+%2d C', cval2), sprintf('+%2d C', cval3)})
axis equal tight;
xlabel('x mm');
ylabel('y mm');
zlabel('mm');

set(gca, 'CameraPosition', [1400  1000  600]);

%%
break;
%% add to database

db = 'C:\Users\Vandiver\Data\sonalleve\sonalleve.db';

tstartidx = sthresh(1)-1;
if tstartidx == 0
    tstartidx=1;
end
tstart=dyntimes(tstartidx);

expdate='2015-09-24';

[fdir,fbase,fext]=fileparts(file);
[query,err] = sprintf( 'insert or ignore into data (file,path,date,isRI,start0,end0,start1,end1,start2,end2,tstartidx,tstart) \n values ("%s", "%s", "%s" ,%d,%d,%d,%d,%d,%d,%d,%d,%f);' ...
    , [fbase fext], fdir, expdate, is_RI_image, idx0(1), idx0(end), idx1(1),idx1(end), sliceset(1), sliceset(end), tstartidx, tstart )

dbid = mksqlite(0,'open',db);
qrydata = mksqlite(dbid, query);
mksqlite(dbid,'close');

[query,err] = sprintf( 'insert or ignore into params (file) values ("%s");' ...
    , [fbase fext] )

dbid = mksqlite(0,'open',db);
qrydata = mksqlite(dbid, query);
mksqlite(dbid,'close');

%% update voxels

db = 'C:\Users\Vandiver\Data\sonalleve\sonalleve.db';

[fdir,fbase,fext]=fileparts(file);
query = sprintf( 'update or replace data set start0=%d,end0=%d,start1=%d,end1=%d,start2=%d,end2=%d where file="%s"' ...
    , idx0(1), idx0(end), idx1(1),idx1(end), sliceset(1), sliceset(end), [fbase fext] );

dbid = mksqlite(0,'open',db);
qrydata = mksqlite(dbid, query);
mksqlite(dbid,'close');



