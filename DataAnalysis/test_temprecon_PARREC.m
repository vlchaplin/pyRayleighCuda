% 
% dir = 'C:\Users\Vandiver\Data\sonalleve\polya_20150526';
% 
% 
% file = [dir,'\Chaplin_99999_WIP_TemperatureMapping_CLEAR_15_1.PAR'];
%file = [dir,'\Chaplin_99999_WIP_TemperatureMapping_CLEAR_8_1.PAR'];
%file = [dir,'\Chaplin_999_WIP_TemperatureMapping_CLEAR_25_1.PAR']



dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150621';
%file = [dir,'\Caskey_999_05_01_14.29.16_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR'];
file = [dir,'\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR'];
%file = [dir,'\Caskey_999_12_01_15.27.34_(TemperatureMapping_CLEAR).PAR'];

dir = 'C:\Users\Vandiver\Data\sonalleve\QA_phantom_20150628';
 file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'];
% file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR'];
% file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_8_1.PAR'];
% %file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_9_1.PAR'];
% %file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_10_1.PAR'];
% %file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_11_1.PAR'];
% %file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_12_1.PAR'];
%file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_13_1.PAR'];
%file = [dir,'\Caskey_9999_WIP_TemperatureMapping_CLEAR_14_1.PAR'];

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
outsideVox = ( magmeanForMask/ max(magmeanForMask(:)) < 0.1 );

%%

idx1=1;

nslice = im.Dims(3);
ndynamics = im.Dims(5);

slice_axis_mm = zeros([1 nslice]);

axis0_mm = (1:im.Dims(1))*im.Spc(1);
axis1_mm = (1:im.Dims(2))*im.Spc(2);

deltaTseries =  zeros(im.Dims([1,2,3,5]));

refStack = (im.Data(:,:,:,1,idx1).*exp(1i*im.Data(:,:,:,2,idx1)));

for dn=2:ndynamics

    complexStack = squeeze( (im.Data(:,:,:,1,dn).*exp(1i*im.Data(:,:,:,2,dn))) );
    deltaTseries(:,:,:,dn) = (1-outsideVox).*angle(refStack.*conj(complexStack)) / (42.576*0.01*3.0*0.016*pi);
end

for slicenum=1:nslice   
    slice_axis_mm(slicenum) = slicenum*im.Parms.tags(2*slicenum - 1, slice_thick_col) +  (slicenum - 1)*im.Parms.tags(2*slicenum - 1, slice_gap_col);
end

if flipSliceAxisLabelDir
    slice_axis_mm=flip(slice_axis_mm);
end


%% 2D movie of temperature

slicenum=10;

figure(2);
clf;
colormap('jet');
minC=0;
maxC=20;

set(gcf,'Position',[10 200 1200 400]);

sliceidx0 = ceil(im.Dims(1)/2)+2;
sliceidx1 = ceil(im.Dims(2)/2)-1;

sliceidx0 = 66;
sliceidx1 = 63;

dynamicsToPlot = 1:ndynamics;
% dynamicsToPlot = 1:6;
%dynamicsToPlot = 8;
clear('movie2DFrames');
movie2DFrames(length(dynamicsToPlot)) = struct('cdata',[],'colormap',[]);
for di=1:length(dynamicsToPlot)
    
    dn=dynamicsToPlot(di);
    deltaTstack = deltaTseries(:,:,:,dn);
    %deltaTstack=max(deltaTseries(:,:,:,1:dn),[],4);

    if di==1 
        set(gcf,'Color', 'white');
        subplot(121);
        hold on;
        imA = imagesc(axis1_mm, axis0_mm, deltaTstack(:,:,slicenum), [minC maxC]);
        plot( axis1_mm, repmat( axis0_mm(sliceidx0)  , 1, im.Dims(2)), '--w');
        plot( repmat( axis1_mm(sliceidx1)  , 1, im.Dims(1)), axis0_mm, '-.c');
        axis equal tight;
        %axis tight manual;
        set(gca,'YDir','normal', 'FontSize', 18);
        xlabel('mm','FontSize',20);
        ylabel('mm','FontSize',20);
        cbar=colorbar();
        cbar.Label.String = '\DeltaT (^oC)';
        cbar.FontSize = 20;

        textlab=text( 0.05, 0.1, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );

        axis([axis1_mm(sliceidx1)+[-40 40] axis0_mm(sliceidx0)+[-40 40]]);

        subplot(122);
        hold on;
        imB = imagesc(axis1_mm, slice_axis_mm, squeeze(deltaTstack(sliceidx0,:,:))', [minC maxC]);
        plot( axis1_mm, repmat( slice_axis_mm(slicenum)  , 1, im.Dims(2)), '--w');
        plot( repmat( axis1_mm(sliceidx1)  , 1, im.Dims(3)), slice_axis_mm, '--w');
        axis equal tight;
        axis([axis1_mm(sliceidx1)+[-40 40] min(slice_axis_mm) max(slice_axis_mm)]);
        
        %axis tight manual;
        set(gca,'YDir','normal', 'FontSize', 18);
        cbar=colorbar();
        cbar.Label.String = '\DeltaT (^oC)';
        cbar.FontSize = 20;
        xlabel('mm','FontSize',20);
        ylabel('mm','FontSize',20);
    
    else
        imA.CData = deltaTstack(:,:,slicenum);
        imB.CData = squeeze(deltaTstack(sliceidx0,:,:))';
        
        set(textlab,'String', sprintf('t=%0.1f sec', dyntimes(dn) ) );
    end

    drawnow;
    movie2DFrames(di) = getframe(gcf);
end

%%

vidFileName = [dir, '\analysis\hifu_7_20150628_slice10_tmax.mp4'];

vidObj = VideoWriter(vidFileName, 'MPEG-4'); 
vidObj.FrameRate = 6;
open(vidObj);
writeVideo(vidObj, movie2DFrames);
close(vidObj);

%% plot of Temperature rise

%for sonication 5 from 06-21-2015
% steeredFoc0 = 58;
% steeredFoc1 = 68;
% steeredFoc2 = 12;
% physFoc0 = 63;
% physFoc1 = 63;
% physFoc2 = 14;
% 
% dTroi = deltaTseries(steeredFoc0 + (-1:1),steeredFoc1 + (-1:1),steeredFoc2, :);
% dTroi = deltaTseries(physFoc0 + (-1:1),physFoc1 + (-1:1),physFoc2, :);

dTroi = deltaTseries(sliceidx0 + (-3:3),sliceidx1 + (-3:3),slicenum, :);

sz=size(dTroi);
flattened = reshape(dTroi,sz(1)*sz(2)*sz(3),sz(4));
avgTemp = mean(flattened,1);
maxTemp = max(flattened,[],1);

tempVolume = sum( flattened > 5, 1 );

figure(3);
hold on;
plot(dyntimes, avgTemp);
xlabel('sec');
ylabel('\Delta T (^oC)');
%% Max temp plot
figure(2)
subplot(121);
hold on;
max
imA = imagesc(axis1_mm, axis0_mm, deltaTstack(:,:,slicenum), [minC maxC]);
plot( axis1_mm, repmat( axis0_mm(sliceidx0)  , 1, im.Dims(2)), '--w');
plot( repmat( axis1_mm(sliceidx1)  , 1, im.Dims(1)), axis0_mm, '-.c');
axis equal tight;
%axis tight manual;
set(gca,'YDir','normal');
xlabel('mm','FontSize',16);
ylabel('mm','FontSize',16);
cbar=colorbar();
cbar.Label.String = '\Delta T (^oC)';
cbar.FontSize = 14;

textlab=text( 50, 60, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );


%% 2D movie of CEM

%slicenum=5;

figure(2);
clf;
colormap('hot');
minCEM=0;
maxCEM=240;

set(gcf,'Position',[10 200 1200 400]);

%sliceidx0 = ceil(im.Dims(1)/2)-1;

dynamicsToPlot = 1:ndynamics;
clear('movie2DFrames');
movie2DFrames(length(dynamicsToPlot)) = struct('cdata',[],'colormap',[]);

Rbase = 4.00*ones(im.Dims(1:3));
ThermDose = zeros(im.Dims(1:3));
T0 = 22;
for di=1:length(dynamicsToPlot)
    
    dn=dynamicsToPlot(di);
    deltaTstack = deltaTseries(:,:,:,dn);
    %Rbase = 4.00*ones(im.Dims(1:3));
    if di==1 
        subplot(121);
        hold on;
        imA = imagesc(axis1_mm, axis0_mm, ThermDose(:,:,slicenum), [minCEM maxCEM]);
        plot( axis1_mm, repmat( axis1_mm(sliceidx0)  , 1, im.Dims(2)), '--w');
        %axis equal tight;
        %axis tight manual;
        
        axis([axis1_mm(sliceidx1)+[-40 40] axis0_mm(sliceidx0)+[-40 40]]);
        
        set(gca,'YDir','normal');
        xlabel('mm','FontSize',16);
        ylabel('mm','FontSize',16);
        cbar=colorbar();
        cbar.Label.String = 'CEM';
        cbar.FontSize = 14;

        textlab=text( 50, 60, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );

        %axis([50 175 50 170]);

        subplot(122);
        hold on;
        imB = imagesc(axis1_mm, slice_axis_mm, squeeze(ThermDose(sliceidx0,:,:))', [minCEM maxCEM]);
        plot( axis1_mm, repmat( slice_axis_mm(slicenum)  , 1, im.Dims(2)), '--w');
        %axis equal tight;
        %axis([50 175 min(slice_axis_mm) max(slice_axis_mm)]);
        
        axis([axis1_mm(sliceidx1)+[-40 40] min(slice_axis_mm) max(slice_axis_mm)]);
        
        %axis tight manual;
        set(gca,'YDir','normal');
        cbar=colorbar();
        cbar.Label.String = 'CEM';
        cbar.FontSize = 16;
        xlabel('mm','FontSize',16);
        ylabel('mm','FontSize',16);
    
    else
        tstep_minutes = (dyntimes(dn) - dyntimes(dynamicsToPlot(di-1)))/60.0;
        Rbase(deltaTstack>=43) = 2.0;
    
        ThermDose = ThermDose + (Rbase.^(deltaTstack+T0-43))*tstep_minutes;
        
        imA.CData = ThermDose(:,:,slicenum);
        imB.CData = squeeze(ThermDose(sliceidx0,:,:))';
        
        set(textlab,'String', sprintf('t=%0.1f sec', dyntimes(dn) ) );
    end

    drawnow;
    movie2DFrames(di) = getframe(gcf);
end




%%

[tx, ty, tz] = ndgrid( axis0_mm, axis1_mm, slice_axis_mm );
%[tx, ty, tz] = meshgrid( axis1_mm, axis0_mm, slice_axis_mm );
%[tx, ty, tz] = meshgrid( 1:64, 1:64, 1:7 );
Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);
%Im = permute(I,[2 1 3]);

magmean = mean(im.Data(:,:,1:2,1,2),3);

dynidx = 15;
deltaTstack = deltaTseries(:,:,:,dynidx);

figure(5);
clf;
hold on;

light('Position', [240 240 10], 'Style', 'local');
%light('Position', [40 0 10], 'Style', 'local');

cval1 = 15;
p1=patch( isosurface( tx, ty, tz, deltaTstack, cval1 ) );
isonormals(tx, ty, tz, deltaTstack, p1);
set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
    'FaceAlpha',1.0, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 55, 'BackFaceLighting', 'unlit' ...
    );

cval2 = 10;
p2=patch( isosurface( tx, ty, tz, deltaTstack, cval2 ) );
isonormals(tx, ty, tz, deltaTstack,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 'yellow', 'EdgeColor', 'none','FaceAlpha',0.6, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

cval3 = 5;
p3=patch( isosurface( tx, ty, tz, deltaTstack, cval3 ) );
isonormals(tx, ty, tz, deltaTstack,p3);
set(p3, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'gouraud', ...
    'AmbientStrength', .9, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5  ...
    );

%magmean = deltaTstack(:,:,1);
colormap('gray');
surf(axis1_mm, axis0_mm, 0+zeros(size(magmean)), magmean, 'EdgeColor','none');

text( 10, 10, 10, sprintf('t=%0.1f sec', dyntimes(dynidx) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );

legend([p1 p2 p3], {sprintf('+%2d C', cval1), sprintf('+%2d C', cval2), sprintf('+%2d C', cval3)})
axis equal tight;
xlabel('x mm');
ylabel('y mm');
zlabel('mm');

set(gca, 'CameraPosition', [1400  1000  600]);


%% 3D movie

fig=figure(6);
clf;
hold on;

%ax = gca;
%ax.NextPlot = 'replaceChildren';

light('Position', [240 240 10], 'Style', 'local');
%light('Position', [40 0 10], 'Style', 'local');

movieFrames(ndynamics)=struct('cdata',[],'colormap',[]);

for dn=1:ndynamics
    dT = deltaTseries(:,:,:,dn);
    
    cval1 = 15;
    cval2 = 10;
    cval3 = 5;
    
    fvstruct1 = isosurface( tx, ty, tz, dT, cval1 );
    fvstruct2 = isosurface( tx, ty, tz, dT, cval2 );
    fvstruct3 = isosurface( tx, ty, tz, dT, cval3 );
    if dn == 1
        
        p1=patch( fvstruct1 );
        isonormals(tx, ty, tz, dT, p1);
        set(p1, 'FaceColor', 'red', 'EdgeColor', 'none', ...
            'FaceAlpha',1.0, ...
            'FaceLighting', 'gouraud', ...
            'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
            'SpecularStrength', 1.0, 'SpecularExponent', 55, 'BackFaceLighting', 'unlit' ...
            );

        
        p2=patch( fvstruct2 );
        isonormals(tx, ty, tz, dT,p2);
        set(p2, 'Clipping', 'on', 'FaceColor', 'yellow', 'EdgeColor', 'none','FaceAlpha',0.6, ...
            'FaceLighting', 'gouraud', ...
            'AmbientStrength', .5, 'DiffuseStrength', 1, ...
            'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
            );

        
        p3=patch(fvstruct3 );
        isonormals(tx, ty, tz, dT,p3);
        set(p3, 'Clipping', 'on', 'FaceColor', 'blue', 'EdgeColor', 'none','FaceAlpha',0.2, ...
            'FaceLighting', 'gouraud', ...
            'AmbientStrength', .9, 'DiffuseStrength', 1, ...
            'SpecularStrength', 1.0, 'SpecularExponent', 5  ...
            );

        %magmean = deltaTstack(:,:,1);
        colormap('gray');
        surf(axis1_mm, axis0_mm, 0+zeros(size(magmean)), magmean, 'EdgeColor','none');

        textlab=text( 10, 10, 10, sprintf('t=%0.1f sec', dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0] );

        legend([p1 p2 p3], {sprintf('+%2d C', cval1), sprintf('+%2d C', cval2), sprintf('+%2d C', cval3)})

        axis equal tight;
        xlabel('x mm');
        ylabel('y mm');
        zlabel('mm');
        set(gca, 'CameraPosition',  [1400  1000  600]);
    else 
        
        set(p1,'Faces', fvstruct1.faces,'Vertices', fvstruct1.vertices); 
        set(p2,'Faces', fvstruct2.faces,'Vertices', fvstruct2.vertices); 
        set(p3,'Faces', fvstruct3.faces,'Vertices', fvstruct3.vertices);
        
        isonormals(tx, ty, tz, dT, p1);
        isonormals(tx, ty, tz, dT, p2);
        isonormals(tx, ty, tz, dT, p3);
        
        set(textlab,'String', sprintf('t=%0.1f sec', dyntimes(dn) ) );
    end
    drawnow;
    movieFrames(dn) = getframe(gcf);
   
end
