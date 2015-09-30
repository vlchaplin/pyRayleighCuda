
% load THRIVE
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_14_01_11.29.02_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'
file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_15_01_11.32.52_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_16_01_11.43.43_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_19_01_12.03.54_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'

flipSliceDir=0;
flipSliceAxisLabelDir=0;

imThrive = vuOpenImage(file);

imThrive.FatShiftDir='F';

if flipSliceDir
    imThrive.Data = flip(imThrive.Data,3);
end


slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;

imThrive.Data = imThrive.Data / max(imThrive.Data(:));

%%

TmomThrive = Calc_Philips_Tmom( imThrive.Parms.SliceOrientation, imThrive.Parms.preparation_dir, imThrive.FatShiftDir );
TangThrive = Calc_Philips_Tang( imThrive.Parms.angulation );

TtotThrive=TangThrive*TmomThrive;

[thriveax,thriveang] = to_axis(TtotThrive);

Tmom = Calc_Philips_Tmom( im.Parms.SliceOrientation, im.Parms.preparation_dir, 'H' );
Tang = Calc_Philips_Tang( im.Parms.angulation );
Ttot = Tang*Tmom;

%[Trotax,Trotang] = to_axis(Tmom);

% rotate(p2, thriveax,thriveang, [0 0 0]);
%% Temperature

LPH_fov = [1 1 1].*im.Parms.fov([3 1 2]);
LPH_offcent = [1 1 1].*im.Parms.offcenter([3 1 2]);

%MPS_fov = LPH_fov;
%MPS_fov = im.Parms.fov;
MPS_fov = (Ttot' * LPH_fov');
%MPS_fov = (Tmom' * LPH_fov');
%MPS_fov = (Tmom' * [160.0 160.0 9.0]');
%MPS_fov = MPS_fov .* [0.9 1.0/0.9 1]';
%MPS_offcent = (Tmom' * LPH_offcent');

%MPS_fov = [-1 -1 1]'.*MPS_fov([2 1 3]);

%MPS_fov = [-117.39 180.0 9.0];

%create MPS voxel points such that the mid-slice is 0,0,0 in MPS
MvoxEdges = linspace(-MPS_fov(1)/2.0, MPS_fov(1)/2.0, im.Dims(1)+1 );
PvoxEdges = linspace(-MPS_fov(2)/2.0, MPS_fov(2)/2.0, im.Dims(2)+1 );
SvoxEdges = linspace(-MPS_fov(3)/2.0, MPS_fov(3)/2.0, im.Dims(3)+1 );

MPSspc = [MvoxEdges(2)-MvoxEdges(1) PvoxEdges(2)-PvoxEdges(1) SvoxEdges(2)-SvoxEdges(1) ];

Mcenters = 0.5*(  MvoxEdges(1:end-1) + MvoxEdges(2:end) );
Pcenters = 0.5*(  PvoxEdges(1:end-1) + PvoxEdges(2:end) );
Scenters = 0.5*(  SvoxEdges(1:end-1) + SvoxEdges(2:end) );

dTmapMPS = deltaTseriesCorr(:,:,:,12);

[timx,timy,timz]=ndgrid(Mcenters, Pcenters, Scenters);
Pm = [2 1 3];
timx = permute(timx, Pm);
timy = permute(timy, Pm);
timz = permute(timz, Pm);
dTperm = permute(dTmapMPS, Pm);

% pT=patch( isosurface( timx, timy, timz, dTperm, 1 ) );
% 
% isonormals(timx, timy, timz, dTperm, pT);
% set(pT, 'Clipping', 'on', 'FaceColor', 0.7*[1,0,0], 'EdgeColor', 'none','FaceAlpha',0.3, ...
%     'FaceLighting', 'none', ...
%     'AmbientStrength', .5, 'DiffuseStrength', 1, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
%     );

tempTRmatrix = eye(4);
tempTRmatrix(1:3, 1:3) = Ttot;
tempTRmatrix(1:3, 4) = LPH_offcent;
trans = hgtransform('Matrix',tempTRmatrix);

%pT.Parent = trans;
%rotate( pT, Trotax, Trotang, [0 0 0]);
% pT.XData = pT.XData + LPH_offcent(1);
% pT.YData = pT.YData + LPH_offcent(2);
% pT.ZData = pT.ZData + LPH_offcent(3);

%%
delete(pT);
%%

tempTRmatrix = eye(4);
tempTRmatrix(1:3, 1:3) = Ttot;
tempTRmatrix(1:3, 4) = LPH_offcent;
trans = hgtransform('Matrix',tempTRmatrix);

tsurf=slice( timx, timy, timz, dTperm, [], [], 0 );
set(tsurf,'EdgeColor','none', 'Facecolor','flat','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
tsurf.Parent = trans;
caxis([0 10]);

% tempMap =dTmapMPS(:,:,2);
% tsurf = surf(Mcenters, Pcenters, zeros(flip(size(tempMap))), tempMap', 'EdgeColor','none', 'BackFaceLighting', 'unlit');
% 
% tsurf.Parent = trans;
%%
delete(tsurf);


%%
LPH_fov_thrive = imThrive.Parms.fov([3 1 2]);
LPH_offcent_thrive = imThrive.Parms.offcenter([3 1 2]);

MPS_fov_thrive = (TmomThrive' * LPH_fov_thrive');

%create MPS voxel points such that the mid-slice is 0,0,0 in MPS
MvoxEdges_thrive = linspace(-MPS_fov_thrive(1)/2.0, MPS_fov_thrive(1)/2.0, imThrive.Dims(1)+1 );
PvoxEdges_thrive = linspace(-MPS_fov_thrive(2)/2.0, MPS_fov_thrive(2)/2.0, imThrive.Dims(2)+1 );
SvoxEdges_thrive = linspace(-MPS_fov_thrive(3)/2.0, MPS_fov_thrive(3)/2.0, imThrive.Dims(3)+1 );

Mcenters_thrive = 0.5*(  MvoxEdges_thrive(1:end-1) + MvoxEdges_thrive(2:end) );
Pcenters_thrive = 0.5*(  PvoxEdges_thrive(1:end-1) + PvoxEdges_thrive(2:end) );
Scenters_thrive = 0.5*(  SvoxEdges_thrive(1:end-1) + SvoxEdges_thrive(2:end) );

[tx, ty, tz] = ndgrid(Mcenters_thrive, Pcenters_thrive, Scenters_thrive);


% idx0range=1:imThrive.Dims(1);
% idx1range=1:imThrive.Dims(2);
% slices=1:imThrive.Dims(3);
%[tx, ty, tz] = ndgrid( thriveAxis0_mm(idx0range), thriveAxis1_mm(idx1range), thriveAxis2_mm(slices) );



Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

volViewPermuted = permute(imThrive.Data,[2 1 3]);

% % 
%%
figure(1);
clf;
hold on;


thriveTRmatrix = eye(4);
thriveTRmatrix(1:3, 1:3) = TtotThrive;
thriveTRmatrix(1:3, 4) = LPH_offcent_thrive;
thriveTrans = hgtransform('Matrix',thriveTRmatrix);

set(gcf,'Renderer','opengl');
cval2 = 0.1;
p2=patch( isosurface( tx, ty, tz, volViewPermuted, cval2 ) );
isonormals(tx, ty, tz, volViewPermuted,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 0.7*[1,1,1], 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'none', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );

p2.Parent = thriveTrans;

axis equal;
xlabel('x RL')
ylabel('y AP')
zlabel('z FH')
%%

thriveTRmatrix = eye(4);
thriveTRmatrix(1:3, 1:3) = TtotThrive;
thriveTRmatrix(1:3, 4) = LPH_offcent_thrive;
thriveTrans = hgtransform('Matrix',thriveTRmatrix);

figure(1);
hold on;
s=slice( tx, ty, tz, volViewPermuted, [], 0, [] );
set(s,'EdgeColor','none', 'AlphaData', s.CData , 'AlphaDataMapping', 'none');
s.Parent = thriveTrans;

s2=slice( tx, ty, tz, volViewPermuted, 0, [], [] );
set(s2,'EdgeColor','none', 'Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
s2.Parent = thriveTrans;
axis equal;
xlabel('x RL')
ylabel('y AP')
zlabel('z FH')
%%
delete([s s2]);
%%

Pslice=210;
thriveSlice =squeeze( imThrive.Data(:,Pslice,:) );

%thr_MS_Surf = surf(Mcenters_thrive, Scenters_thrive, Pcenters_thrive(Pslice) + zeros(flip(size(thriveSlice))), thriveSlice', 'EdgeColor','none', 'BackFaceLighting', 'unlit');

%thriveMSTrans = hgtransform('Matrix', tmomPslice*makehgtform('translate',[0 -Pcenters_thrive(Pslice) 0]) );

%thriveMSTrans = hgtransform('Matrix', makehgtform('zrotate',pi/2)*makehgtform('translate', -LPH_offcent_thrive)*thriveTRmatrix*makehgtform('translate',[0 -Pcenters_thrive(Pslice) 0]) );
%thriveMSTrans.Parent = thriveTrans;
%thriveTrans.Parent = thriveMSTrans;
%thr_MS_Surf.Parent = thriveMSTrans;

sl=130;
thrSurf = surf(Mcenters_thrive, Pcenters_thrive,Scenters_thrive(sl)+ zeros(flip(imThrive.Dims(1:2))), squeeze( imThrive.Data(:,:,sl) )', 'EdgeColor','none', 'BackFaceLighting', 'unlit');


%rotate(thrSurf,[0 1 0], 90);
thrSurf.Parent = thriveTrans;

%%
delete(thrSurf);
delete(thr_MS_Surf);
