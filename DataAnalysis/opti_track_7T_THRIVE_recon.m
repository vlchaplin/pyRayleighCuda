

file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_16_01_11.43.43_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_19_01_12.03.54_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'


flipSliceDir=0;
flipSliceAxisLabelDir=0;

imThrive = vuOpenImage(file);

if flipSliceDir
    imThrive.Data = flip(imThrive.Data,3);
end


slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;

imThrive.Data = imThrive.Data / max(imThrive.Data(:));

nslice = imThrive.Dims(3);

thriveAxis0_mm = (1:imThrive.Dims(1))*imThrive.Spc(1);
thriveAxis1_mm = (1:imThrive.Dims(2))*imThrive.Spc(2);
thriveAxis2_mm = (1:imThrive.Dims(3))*imThrive.Spc(3);



%%
idx0range=1:imThrive.Dims(1);
idx1range=1:imThrive.Dims(2);
slices=1:imThrive.Dims(3);

[tx, ty, tz] = ndgrid( thriveAxis0_mm(idx0range), thriveAxis1_mm(idx1range), thriveAxis2_mm(slices) );

Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

volViewPermuted = permute(imThrive.Data,[2 1 3]);



%%
figure(1);
clf;
hold on;

light('Position', [240 240 10], 'Style', 'infinite');
light('Position', [0 0 300], 'Style', 'local');

% cval1 = 0.5;
% p1=patch( isosurface( tx, ty, tz, volViewPermuted, cval1 ) );
% isonormals(tx, ty, tz, volViewPermuted, p1);
% 
% set(p1, 'FaceColor', 0.3*[1,1,1], 'EdgeColor', 'none', ...
%     'FaceAlpha',1.0, ...
%     'FaceLighting', 'none', ...
%     'AmbientStrength', 1.0, 'DiffuseStrength', 1.0, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 55, 'BackFaceLighting', 'unlit' ...
%     );

cval2 = 0.1;
p2=patch( isosurface( tx, ty, tz, volViewPermuted, cval2 ) );
isonormals(tx, ty, tz, volViewPermuted,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 0.7*[1,1,1], 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'none', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

axis equal;
xlabel('x (rl) ... hf')
ylabel('y (hf) ... lr')
zlabel('z (ap)')

%%
% s1=slice(tx, ty, tz, volViewPermuted, 80.0, [], [] );
% s2=slice(tx, ty, tz, volViewPermuted, [], [], 100 );
% set(s1,'EdgeColor', 'None' );
% set(s2,'EdgeColor', 'None' );
%%
% delete([s1,s2]);

imAx0 = (1:im.Dims(1))*im.Spc(1) - 0*im.Origin(1);
imAx1 = (1:im.Dims(2))*im.Spc(2) - 0*im.Origin(2);
imAx2 = (1:im.Dims(3))*im.Spc(3) - 0*im.Origin(3);


%dT_23coords = permute(deltaTseriesCorr(:,:,:,dn), [3 1 2]);
%dT_23coords = flip(dT_23coords,1);
% im23_Ax0 = -(imAx2 + imThrive.Origin(1));
% im23_Ax1 = imAx0 + imThrive.Origin(2);
% im23_Ax2 = imAx1 + imThrive.Origin(3);

dT_23coords = deltaTseriesCorr(:,:,:,dn);
im23_Ax0 = imAx0;
im23_Ax1 = imAx1;
im23_Ax2 = imAx2;

[timx,timy,timz]=ndgrid(im23_Ax0,im23_Ax1,im23_Ax2);
Pm = [2 1 3];
timx = permute(timx, Pm);
timy = permute(timy, Pm);
timz = permute(timz, Pm);
dTperm = permute(dT_23coords, Pm);

pT=patch( isosurface( timx, timy, timz, dTperm, 1 ) );
isonormals(timx, timy, timz, dTperm, pT);
set(pT, 'Clipping', 'on', 'FaceColor', 0.7*[1,0,0], 'EdgeColor', 'none','FaceAlpha',0.3, ...
    'FaceLighting', 'none', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

%%
delete(pT);
%% temperature data already loaded in 'im'
%figure(2);
%clf;
figure(1);
hold on;

reorientMat_1_to_3 = [ [1 0 0]; [0 0 -1]; [0 1 0]; ];
reorientMat_2_to_3 = [ [0 0 -1]; [0 1 0]; [1 0 0]; ];
slicenum=2;
tempMap = deltaTseriesCorr(:,:,slicenum,dn);

rotator = imThrive.Orientation' * im.Orientation;
trans = im.Origin - imThrive.Origin;

[sliceax,sliceang]= to_axis(reorientMat_2_to_3);
[ax,angdeg] = to_axis(rotator);



imAx0 = (1:im.Dims(1))*im.Spc(1) + trans(1);
imAx1 = (1:im.Dims(2))*im.Spc(2) + trans(2);
imAx2 = (1:im.Dims(3))*im.Spc(3) + trans(3);

colormap('hot');

rf=1.0;gf=0.9;bf=0.0;

cslice = ceil(imThrive.Dims(3)/2);
cslice=98;
centersliceThrive = imThrive.Data(:,:,cslice )';

%roiImSliceRGB = cat(3, rf*centersliceThrive, gf*centersliceThrive, bf*centersliceThrive);
%csSurf = surf( thriveAxis1_mm, thriveAxis0_mm, thriveAxis2_mm(cslice) + zeros(size(centersliceThrive)), roiImSliceRGB, 'EdgeColor','none' );

% yslice = imThrive.Dims(2)/2;
% yslice=170;
% ysliceThrive = squeeze(imThrive.Data(:,yslice,: ));
% csSurfY = surf( thriveAxis2_mm, thriveAxis0_mm, thriveAxis1_mm(yslice) + zeros(size(ysliceThrive)), cat(3, rf*ysliceThrive, gf*ysliceThrive, bf*ysliceThrive), 'EdgeColor','none' );
%  
% rotate( csSurfY, [0 1 0], -90.0 );
% rotate( csSurfY, [0 0 1], -90.0 );

  tsurf0=surf(imAx0, imAx1, 0*imAx2(slicenum)+ zeros(flip(size(tempMap))), tempMap', 'EdgeColor','none', 'BackFaceLighting', 'unlit');
  tsurf=surf(imAx0, imAx1, 0*imAx2(slicenum)+ zeros(flip(size(tempMap))), tempMap', 'EdgeColor','none', 'BackFaceLighting', 'unlit');
  caxis([-2,20]);
  
%  rotate(tsurf, sliceax, 0);
rotate(tsurf, sliceax, sliceang, [0 0 0]);
rotate(tsurf, ax, angdeg, [0 0 0]);

% rotate( tsurf, [0 1 0], -90.0 );
% rotate( tsurf, [0 0 1], -90.0 );

%  rotate( tsurf, [0 0 1], 90.0 );
%  rotate( tsurf, [1 0 0], 90.0 );

% tr = (-reorientMat_2_to_3 * im.Origin') + imThrive.Origin';
% 
%  tsurf0.XData = tsurf0.XData + tr(1);
%  tsurf0.YData = tsurf0.YData + tr(2);
%  tsurf0.ZData = tsurf0.ZData + tr(3);

% 
%  tsurf.XData = tsurf.XData - imThrive.Origin(1);
%  tsurf.YData = tsurf.YData - imThrive.Origin(2);
%  tsurf.ZData = tsurf.ZData - imThrive.Origin(3);

%Pm = [2 1 3];
% tempX = tsurf.XData;
% tempY = tsurf.YData;
% tempZ = tsurf.ZData;
% tsurf.XData = -tempZ;
% tsurf.YData = tempY;
% tsurf.ZData = tempX;

%%
delete(tsurf);
delete(tsurf0);
delete(csSurf);
delete(csSurfY);



%%
figure(3);
clf;
hold on;

slicenum=2;
tempMap = deltaTseriesCorr(:,:,slicenum,dn);

rotator = imThrive.Orientation' * im.Orientation;
trans = im.Origin - imThrive.Origin;

[sliceax,sliceang]= to_axis(reorientMat_2_to_3);
[ax,angdeg] = to_axis(rotator);

imAx0 = (1:im.Dims(1))*im.Spc(1) + im.Origin(1);
imAx1 = (1:im.Dims(2))*im.Spc(2) + im.Origin(2);
imAx2 = (1:im.Dims(3))*im.Spc(3) + im.Origin(3);

%tempMap = flip(tempMap,1);
mask=squeeze(tempMap) > 1.0;

sl=112;
sl=99;
%imagesc( thriveAxis1_mm, thriveAxis0_mm, imThrive.Data(:,:,sl ) );
%imagesc( imThrive.Data(:,:,sl ) );
imdata=squeeze(imThrive.Data(210,:,: ));

 imdata = imdata / max(imdata(:));
 image( thriveAxis2_mm + imThrive.Origin(3), thriveAxis1_mm + imThrive.Origin(2), repmat(imdata, [1 1 3]) );
%imagesc( thriveAxis2_mm, thriveAxis1_mm, imdata );
xlabel('mm')
ylabel('mm')

%imagesc(imAx1, imAx0, tempMap , 'AlphaDataMapping', 'none', 'AlphaData', 0.5*mask);


axis equal tight;
set(gca, 'FontSize', 18);
% 
% figure(4);
% clf;
% hold on;
% imagesc( imAx1, imAx0, tempMap );
% axis equal;

