
% load THRIVE scan (contains fiducials)


%thrive 19
fiducials_itk_vox_thrive19 = [...
    [269 352 131]; [354 261 130]; [181 89 132]; [105 148 132]; [83 220 133]; 
    [298 267 96]; [312 185 100]; [155 158 98]; [182 303 97];
    ]';

%thrive 16
fiducials_itk_vox_thrive16 = [...
    [269 353 132]; [353 263 131]; [181 91 132]; [106 149 132]; [83 220 133]; 
    [297 267 96]; [313 186 99]; [152 156 98]; [181 306 96];
    ]';

MRILocalizations=containers.Map( ...
    {'fusphantom_99999_16_01_11.43.43_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR',...
    'fusphantom_99999_19_01_12.03.54_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR',...
    'default'},...
    {fiducials_itk_vox_thrive16, fiducials_itk_vox_thrive19, fiducials_itk_vox_thrive16} );

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_14_01_11.29.02_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'
%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_15_01_11.32.52_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'
file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_16_01_11.43.43_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'

%file='C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_99999_19_01_12.03.54_(WIP_THRIVE_supine_1mmACQ_NSA3).PAR'

[filepath,filename,filext] = fileparts(file);

if MRILocalizations.isKey([filename filext])
    fiducials_itk_vox = MRILocalizations([filename filext]);
else
    fiducials_itk_vox = MRILocalizations('default');
    disp('*** Fiducial localization isn''t stored for this scan ***')
end

flipSliceDir=0;
flipSliceAxisLabelDir=0;

imThrive = vuOpenImage(file);

imThrive.FatShiftDir='F';

%vuWriteImage(imThrive, 'C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\fusphantom_15_thrive.mha');

if flipSliceDir
    imThrive.Data = flip(imThrive.Data,3);
end


slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;

imThrive.Data = imThrive.Data / max(imThrive.Data(:));

%un-swap row and column so dimensions agree with external program convention ( vuOpenImage swaps them). 
imThrive.Data = permute( imThrive.Data, [2 1 3]);
imThrive.Dims = size(imThrive.Data);
imThrive.Spc = permute( imThrive.Spc, [2 1 3])';

% imThrive.Data(1:100,1:2,1:5) = 1;
% imThrive.Data(1:2,1:216,1:10) = 2;
% imThrive.Data(1:2,1:2,:) = 3;


%% Compute MRI rotation matrices to convert MPS to LPH coordinates

[TmomThrive,Tfsd,Tprep,Tsom] = Calc_Philips_Tmom( imThrive.Parms.SliceOrientation, imThrive.Parms.preparation_dir, imThrive.FatShiftDir );
TangThrive = Calc_Philips_Tang( imThrive.Parms.angulation );

 XYflipMat= [ [-1 0 0]; [0 -1 0]; [0 0 1]; ];
 
rowMajThriveToLPH = [ [1 0 0]; [0 0 1]; [0 -1 0]; ];
TmomThrive = rowMajThriveToLPH;
TtotThrive=TangThrive*TmomThrive;

%TtotThrive = [ [-1 0 0]; [0 -1 0]; [0 0 1]; ];

[thriveax,thriveang] = to_axis(TtotThrive);


%[Trotax,Trotang] = to_axis(Tmom);

% rotate(p2, thriveax,thriveang, [0 0 0]);
%% Setup THRIVE MPS system
LPH_fov_thrive = imThrive.Parms.fov([3 1 2]);
LPH_offcent_thrive = imThrive.Parms.offcenter([3 1 2]);

%MPS_fov_thrive = (TmomThrive' * LPH_fov_thrive');
MPS_fov_thrive = (imThrive.Dims).* imThrive.Spc;

%create MPS voxel points such that the mid-slice is 0,0,0 in MPS
MvoxEdges_thrive = linspace(-MPS_fov_thrive(1)/2.0, MPS_fov_thrive(1)/2.0, imThrive.Dims(1)+1 );
PvoxEdges_thrive = linspace(-MPS_fov_thrive(2)/2.0, MPS_fov_thrive(2)/2.0, imThrive.Dims(2)+1 );
SvoxEdges_thrive = linspace(-MPS_fov_thrive(3)/2.0, MPS_fov_thrive(3)/2.0, imThrive.Dims(3)+1 );

Mcenters_thrive = 0.5*(  MvoxEdges_thrive(1:end-1) + MvoxEdges_thrive(2:end) );
Pcenters_thrive = 0.5*(  PvoxEdges_thrive(1:end-1) + PvoxEdges_thrive(2:end) );
Scenters_thrive = 0.5*(  SvoxEdges_thrive(1:end-1) + SvoxEdges_thrive(2:end) );

thriveSpc = [MvoxEdges_thrive(2) - MvoxEdges_thrive(1), PvoxEdges_thrive(2) - PvoxEdges_thrive(1), SvoxEdges_thrive(2) - SvoxEdges_thrive(1)];

MPS_offcent_thrive = (TmomThrive' *LPH_offcent_thrive');

% testPoints_vox = [[206 428 115]; [242 3 115]; ]'; 
% testPoints_vox = testPoints_vox([2 3 1],:);
% testPoints_mps = [Mcenters_thrive(testPoints_vox(1,:)); PvoxEdges_thrive(testPoints_vox(2,:)); SvoxEdges_thrive(testPoints_vox(3,:)); ];
% testPoints_lph = TtotThrive * testPoints_mps + repmat( LPH_offcent_thrive', [1 size(testPoints_vox,2)]);

%pp = plot3(testPoints_lph(1,:), testPoints_lph(2,:), testPoints_lph(3,:), 'k-', 'LineWidth',2.0);
%delete(pp);
[tx, ty, tz] = ndgrid(Mcenters_thrive, Pcenters_thrive, Scenters_thrive);

%imThrive.Data = flip(imThrive.Data,1);
%imThrive.Data = flip(imThrive.Data,2);

Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

volViewPermuted = permute(imThrive.Data,[2 1 3]);

%% Draw THRIVE voxel data in LPH frame.  Uses TmomThrive, MPS->LPH
figure(1);
clf;
hold on;


thriveTRmatrix = eye(4);
thriveTRmatrix(1:3, 1:3) = TtotThrive;
thriveTRmatrix(1:3, 4) = LPH_offcent_thrive;
thriveTrans = hgtransform('Matrix',thriveTRmatrix);

set(gcf,'Renderer','opengl');
% 
light('Position', [-80 -80 100], 'Style', 'local');
cval1 = 0.45;
p1=patch( isosurface( tx, ty, tz, volViewPermuted, cval1 ) );
isonormals(tx, ty, tz, volViewPermuted,p1);
set(p1, 'Clipping', 'on', 'FaceColor', 0.7*[1,1,1], 'EdgeColor', 'none','FaceAlpha',0.8, ...
    'FaceLighting', 'flat', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );
p1.Parent = thriveTrans;


cval2 = 0.1;
p2=patch( isosurface( tx, ty, tz, volViewPermuted, cval2 ) );
isonormals(tx, ty, tz, volViewPermuted,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 0.7*[1,1,1], 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'flat', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


p2.Parent = thriveTrans;

axis equal;
xlabel('x RL (mm)');
ylabel('y AP (mm)');
zlabel('z FH (mm)');
set(gca,'FontSize',24);
%%
figure(1);
% clf;
% hold on;

% Load the transducer fiducial positions and plot
% fiducials_mps_vox = fiducials_MRI_7T([0 0 0]);
% %fiducials_mps = [Mcenters_thrive(fiducials_mps_vox(1,:)); Pcenters_thrive(fiducials_mps_vox(2,:)); Scenters_thrive(fiducials_mps_vox(3,:)); ones(size(fiducials_mps_vox(3,:))); ];
% 
% fiducials_mps = [Mcenters_thrive(fiducials_mps_vox(1,:)); Pcenters_thrive(fiducials_mps_vox(2,:)); Scenters_thrive(fiducials_mps_vox(3,:)); ones(size(fiducials_mps_vox(3,:))); ];
% 
%fiducials_clean = read_vtk('C:\Users\Vandiver\Data\opti-track\7T-MR-HIFU\itksnap_thrive19_clean_REORDERED.vtk');
% %fiducials_clean = fiducials_clean + repmat( [6.7 2.67 -12.3]', 1, size(fiducials_clean,2));
% % 
% fiducials_clean_vox = zeros(size(fiducials_clean));
% %to convert itksnap 'cleaned' fidos to mps voxel
% fiducials_clean_vox(1,:) = 431 - floor(431*(fiducials_clean(1,:) - (-73.0) ) / (86.5+73.0))+1;
% fiducials_clean_vox(2,:) = 431 - floor(431*(fiducials_clean(2,:) - (-77.1) ) / (82.4+77.1))+1;
% fiducials_clean_vox(3,:) = floor(159*(fiducials_clean(3,:) - (-67.2) ) / (91.8+67.2 +0.5))+1;
% 
% fiducials_clean_mps =  [Mcenters_thrive(fiducials_clean_vox(1,:)); Pcenters_thrive(fiducials_clean_vox(2,:)); Scenters_thrive(fiducials_clean_vox(3,:)); ones(size(fiducials_clean_vox(3,:)));];

% to get to match with _mps before the thrive x&y axes were negated in the first. now
% not necessary
%   fiducials_clean(1,:) = -fiducials_clean(1,:);
%  fiducials_clean(2,:) = -fiducials_clean(2,:);


%fiducials_clean(3,:) = -fiducials_clean(3,:);

% 
% [Rf, tf, FREf, FREcomf] = point_register( fiducials_clean_mps(1:3,:), fiducials_mps(1:3,:) );
% 
% fiducials_clean_mps(1:3,:) = Rf*fiducials_clean_mps(1:3,:) + tf*ones( 1, size( fiducials_lph, 2));

% 
% FREf
%fiducials_mps(1:3,:) = fid2(1:3,:);

%thrive 19
% fiducials_itk_vox = [...
%     [269 352 131]; [354 261 130]; [181 89 132]; [105 148 132]; [83 220 133]; 
%     [298 267 96]; [312 185 100]; [155 158 98]; [182 303 97];
%     ]';

%thrive 16
% fiducials_itk_vox = [...
%     [269 353 132]; [353 263 131]; [181 91 132]; [106 149 132]; [83 220 133]; 
%     [297 267 96]; [313 186 99]; [152 156 98]; [181 306 96];
%     ]';

fiducials_itk_mps =  [Mcenters_thrive(fiducials_itk_vox(1,:)); Pcenters_thrive(fiducials_itk_vox(2,:)); Scenters_thrive(fiducials_itk_vox(3,:)); ones(size(fiducials_itk_vox(3,:)));];


% tempX=fiducials_itk_vox(1,:);
% fiducials_itk_vox(1,:)=fiducials_itk_vox(2,:);
% fiducials_itk_vox(2,:)=tempX;

fiducials_lph = thriveTRmatrix*fiducials_itk_mps;

%fiducials_lph2= thriveTRmatrix*fiducials_clean;
%fiducials_lph(1,:) = -fiducials_lph(1,:);
%fiducials_lph(2,:) = -fiducials_lph(2,:);

plt=plot3( fiducials_lph(1,:), fiducials_lph(2,:), fiducials_lph(3,:), 'g*', 'LineWidth', 2.0,  'DisplayName', 'fiducials (MRI-THRIVE)' );
%plt2=plot3( fiducials_lph2(1,:), fiducials_lph2(2,:), fiducials_lph2(3,:), 'b+', 'LineWidth', 2.0,  'DisplayName', 'fiducials (MRI-THRIVE)' );

%pp = plot3(testPoints_lph(1,:), testPoints_lph(2,:), testPoints_lph(3,:), 'k-', 'LineWidth',2.0);

%% LOAD NDI-frame fiducial points, compute transform, and plot
load('C:\Users\Vandiver\Data\opti-track\20150922_Calibration\fiducials_average_9x3_first5samples.mat', 'Fiducials');
fiducials_ndi = Fiducials';

% fiducials_lph(1,:) = -fiducials_lph(1,:);
% fiducials_lph(2,:) = -fiducials_lph(2,:);

set_to_use = [1 2 3 8];
set_to_use = 1:9;
[R,t,FRE, FRE_components] = point_register( fiducials_ndi(1:3, set_to_use), fiducials_lph(1:3, set_to_use) );

FRE

N = size( fiducials_lph, 2);
fiducials_ndi2lph = R*fiducials_ndi + t*ones(1,N);

pltNDI2LPH=plot3( fiducials_ndi2lph(1,set_to_use), fiducials_ndi2lph(2,set_to_use), fiducials_ndi2lph(3,set_to_use), 'r^', 'LineWidth', 2.0,  'DisplayName', 'fiducials (NDI)' );



%% Temperature

Tmom = Calc_Philips_Tmom( im.Parms.SliceOrientation, im.Parms.preparation_dir, tempScanFatShiftDir );



dTmapMPS = deltaTseriesCorr(:,:,:,20);

%Tmom=from_euler(0,180,0)*TmomThrive* rowMajScan20TmomEmpirical;
Tmom=TmomThrive* empiricalRot;
Tang = Calc_Philips_Tang( im.Parms.angulation );
Ttot = Tang*Tmom;

%LPH_fov = [1 1 1].*im.Parms.fov([3 1 2]);
LPH_offcent = [1 1 1].*im.Parms.offcenter([3 1 2]);

%MPS_fov = LPH_fov;
%MPS_fov = im.Parms.fov;
% MPS_fov = (Ttot' * LPH_fov');
% MPS_fov = (Tmom' * LPH_fov');
%MPS_fov = (Tmom' * [160.0 160.0 9.0]');
%MPS_fov = MPS_fov .* [0.9 1.0/0.9 1]';
%MPS_offcent = (Tmom' * LPH_offcent');

MPS_fov = im.Dims(1:3) .* im.Spc;

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

[timx,timy,timz]=ndgrid(Mcenters, Pcenters, Scenters);
Pm = [2 1 3];
timx = permute(timx, Pm);
timy = permute(timy, Pm);
timz = permute(timz, Pm);
dTperm = permute(dTmapMPS, Pm);

%flip = [ [-1 0 0]; [0 -1 0]; [0 0 1]; ];
tempTRmatrix = eye(4);
tempTRmatrix(1:3, 1:3) = Ttot;
tempTRmatrix(1:3, 4) = LPH_offcent;
trans = hgtransform('Matrix',tempTRmatrix);

% pT=patch( isosurface( timx, timy, timz, dTperm, 1 ) );
% 
% isonormals(timx, timy, timz, dTperm, pT);
% set(pT, 'Clipping', 'on', 'FaceColor', 0.7*[1,0,0], 'EdgeColor', 'none','FaceAlpha',0.3, ...
%     'FaceLighting', 'none', ...
%     'AmbientStrength', .5, 'DiffuseStrength', 1, ...
%     'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
%     );
% 
% pT.Parent = trans;

%%
%delete(pT);


%% (optional) Cross-sectional slices of the THRIVE scan

% thriveTRmatrix = eye(4);
% thriveTRmatrix(1:3, 1:3) = TtotThrive;
% thriveTRmatrix(1:3, 4) = LPH_offcent_thrive;
% thriveTrans = hgtransform('Matrix',thriveTRmatrix);
% 
% figure(1);
% hold on;
% s=slice( tx, ty, tz, volViewPermuted, [], 0, [] );
% set(s,'EdgeColor','none', 'AlphaData', s.CData , 'AlphaDataMapping', 'none');
% s.Parent = thriveTrans;
% 
% s2=slice( tx, ty, tz, volViewPermuted, 0, [], [] );
% set(s2,'EdgeColor','none', 'Facecolor','interp','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
% s2.Parent = thriveTrans;
% axis equal;
% xlabel('x RL')
% ylabel('y AP')
% zlabel('z FH')
% %%
% %delete([s s2]);


h115_pulse_echo_file = 'C:\Users\Vandiver\Data\opti-track\20150922_Calibration\max_point_001.csv';
%h115_pulse_echo_file ='C:\Users\Vandiver\Documents\HiFU\optical_tracking\H115_pulse_echo\ProbeTip_relative_2_000.csv';
h115_pulse_echo_file ='C:\Users\Vandiver\Data\opti-track\AllPulseEchoMaxPoints.csv';
[Txyz,Qsxyz]=readNDIcsv(h115_pulse_echo_file);

h115_focus_ndi = mean(Txyz,1)';
h115_focus_ndi =Txyz';

Nfp=size(h115_focus_ndi,2);
h115_focus_lph = R*h115_focus_ndi + t*ones(1,Nfp);

tempTRmatrixReverse = tempTRmatrix;
tempTRmatrixReverse(1:3, 1:3) = inv(tempTRmatrixReverse(1:3, 1:3));
tempTRmatrixReverse(1:3, 4) = -tempTRmatrixReverse(1:3, 4);

%tempTRmatrixReverse*[ h115_focus_lph; ones([1 size(h115_focus_lph,2)]);]

h115_focus_MPS_Tscan = tempTRmatrix(1:3,1:3)'*(h115_focus_lph - repmat(tempTRmatrix(1:3,4), [1 Nfp]) );
%h115_focus_MPS_Tscan = tempTRmatrixReverse*horzcat( h115_focus_lph', ones([Nfp 1]) )';
h115_focus_MPS_Tscan = h115_focus_MPS_Tscan(1:3,:);
h115_pulseEchoAvg_MPS = mean(h115_focus_MPS_Tscan,2);
h115_pulseEchoAvg_LPH = mean(h115_focus_lph,2);

h115_pulseEchoAvg_MPS_vox = ceil( (h115_pulseEchoAvg_MPS - [MvoxEdges(1) PvoxEdges(1) SvoxEdges(1)]' ) ./ MPSspc');


%plot3( h115_focus_lph(1,:), h115_focus_lph(2,:), h115_focus_lph(3,:), 'gx', 'LineWidth', 1.0, 'DisplayName', 'Pulse-echo focus' );

avgPlot=plot3( h115_pulseEchoAvg_LPH(1), h115_pulseEchoAvg_LPH(2), h115_pulseEchoAvg_LPH(3), 'x','Color',[0., 0., 0.7], 'LineWidth', 2.0, 'DisplayName', 'Pulse-echo focus' );

%% find maximum MP voxel in each tempature map slice

interpTempMPSSpc = [0.5 0.5 0.5];
interpM = (MvoxEdges(2):interpTempMPSSpc(1):MvoxEdges(end-1));
interpP = (PvoxEdges(2):interpTempMPSSpc(2):PvoxEdges(end-1));
interpS = (SvoxEdges(2):interpTempMPSSpc(2):SvoxEdges(end-1));

[tintrM,tintrP,tintrS] = ndgrid(interpM, interpP, interpS);
tintrM = permute(tintrM, Pm);
tintrP = permute(tintrP, Pm);
tintrS = permute(tintrS, Pm);

interpTemp = interp3(timx,timy,timz,dTperm,tintrM,tintrP,tintrS);

[filtX,filtY]=meshgrid( interpTempMPSSpc(1)*(-2:2), interpTempMPSSpc(2)*(-3:3) );
maxingKernel = exp( -(filtX / (sqrt(2.0)*2.0 )).^2 ) .* exp( -(filtY / (sqrt(2.0)*2.0 )).^2 ) ;

h115_pulseEchoAvg_MPS_interpvox = ceil( (h115_pulseEchoAvg_MPS - [interpM(1) interpP(1) interpS(1)]' ) ./ interpTempMPSSpc');

corMaxTs = zeros(size(interpS));
corMaxMPvals = zeros([2 length(interpS)]);

ccfGrid = zeros(size(interpTemp));

interpTempNdgridFmt = permute(interpTemp,[2 1 3]);
searchMargin = round(8.0 ./ interpTempMPSSpc);
searchMask = zeros(size(interpTempNdgridFmt) );
searchMask(h115_pulseEchoAvg_MPS_interpvox(1) + (-searchMargin(1):searchMargin(1)), h115_pulseEchoAvg_MPS_interpvox(2) + (-searchMargin(1):searchMargin(1)),:) = 1;

for s=1:length(Scenters)

    ccfT = conv2( searchMask(:,:,s).*interpTempNdgridFmt(:,:,s), maxingKernel, 'same' );
    ccfGrid(:,:,s)=ccfT;
    [mval, maxMPpix] = max(ccfT(:));
    [maxMvox,maxPvox] = ind2sub( size(ccfT), maxMPpix );
    corMaxTs(s) = (mval);
    corMaxMPvals(:,s) = [maxMvox,maxPvox];
    disp( [maxMvox,maxPvox,mval] )
end

[mval, maxSvox] = max(corMaxTs);

maxMvox = corMaxMPvals(1,maxSvox);
maxPvox = corMaxMPvals(2,maxSvox);

heatMaxPoint_MPS = [ interpM(maxMvox) interpP(maxPvox) interpS(maxSvox) ]';

targetRegErrorMPSVec = (heatMaxPoint_MPS - h115_pulseEchoAvg_MPS);
targetRegError_mm = sqrt( sum( targetRegErrorMPSVec.^2 ) )

heatMaxPoint_LPH = tempTRmatrix(1:3,1:3)*heatMaxPoint_MPS + tempTRmatrix(1:3,4);

targetRegErrorLPHVec = (heatMaxPoint_LPH - h115_pulseEchoAvg_LPH);
targetRegError_mm = sqrt( sum( targetRegErrorLPHVec.^2 ) )

figure(1);
hold on;
errVecPlt=plot3( [ h115_pulseEchoAvg_LPH(1) heatMaxPoint_LPH(1) ], ...
    [ h115_pulseEchoAvg_LPH(2) heatMaxPoint_LPH(2) ], ...
    [ h115_pulseEchoAvg_LPH(3) heatMaxPoint_LPH(3) ], ...
    'y', 'LineWidth', 2.0, 'Color', [0.0 0.0 0.9], 'DisplayName', 'MRI vs Pulse-echo TRE' );

figure(3);
clf;
hold on;

imagesc( ccfT );

%delete(errVecPlt)
%delete(avgPlot)


%% Plot temperature slice containing the maximized point
figure(1);
hold on;
% tempTRmatrix = eye(4);
% tempTRmatrix(1:3, 1:3) = Ttot;
% tempTRmatrix(1:3, 4) = LPH_offcent;
% trans = hgtransform('Matrix',tempTRmatrix);

%ccfGridPerm=permute(ccfGrid,[2 1 3]);

% tsurf=slice( timx, timy, timz, dTperm, [], [], Scenters(maxSvox) );
% set(tsurf,'EdgeColor','none', 'Facecolor','flat','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
% tsurf.Parent = trans;

tsurf=slice( tintrM, tintrP, tintrS, interpTemp, [], [], interpS(maxSvox) );
set(tsurf,'EdgeColor','none', 'Facecolor','flat','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
tsurf.Parent = trans;

% tsurf2=slice( timx, timy, timz, dTperm, [], [], SvoxEdges(end-1) );
% set(tsurf2,'EdgeColor','none', 'Facecolor','flat','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
% tsurf2.Parent = trans;

caxis([0 30]);
colormap('hot');

% tempMap =dTmapMPS(:,:,2);
% tsurf = surf(Mcenters, Pcenters, zeros(flip(size(tempMap))), tempMap', 'EdgeColor','none', 'BackFaceLighting', 'unlit');
% 
% tsurf.Parent = trans;
%%
%delete([tsurf]);
