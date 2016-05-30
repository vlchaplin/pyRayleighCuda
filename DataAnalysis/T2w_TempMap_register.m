dir = 'C:\Users\Vandiver\Data\sonalleve\HifuEggAg_20160211\';


t2file = [dir,'Caskey_20160211_WIP_T2w_TE40_CLEAR_26_1.PAR'];

Tfile = [dir,'Caskey_20160211_WIP_Tmap_SingleFocStatic_40W_CLEAR_18_1.PAR'];

T2im = vuOpenImage(t2file);
TempIm = vuOpenImage(Tfile);

%arbitrarily set
T2im.FatShiftDir='F';
tempScanFatShiftDir='H';

complexImStack = squeeze( (TempIm.Data(:,:,:,1,:).*exp(1i*TempIm.Data(:,:,:,2,:)))  );

numDyns = TempIm.Dims(end);

deltaTstack = angle(repmat(complexImStack(:,:,:,1), [1 1 1 numDyns]) .* conj( complexImStack )) / (42.576*0.01*3.0*0.016*pi);

deltaTstack = abs(complexImStack);
%t2im = flip( permute(T2im.Data, [1 3 2]), 2);

T2im.Data = 1.0 - (T2im.Data / max(T2im.Data(:)));
%un-swap row and column so dimensions agree with external program convention ( vuOpenImage swaps them). 
T2im.Data = permute( T2im.Data, [2 1 3]);
T2im.Dims = size(T2im.Data);
T2im.Spc = permute( T2im.Spc, [2 1 3])';


%this is ad-hoc and really should be replaced by correct calc. of Tmom
if TempIm.Parms.SliceOrientation == 2
    empiricalRot = from_euler(0,-90,0);
elseif TempIm.Parms.SliceOrientation == 1
    empiricalRot = [ [1 0 0]; [0 0 -1]; [0 1 0]; ];
else
    empiricalRot=eye(3);
end


%% Set MRI rotation matrices to convert MPS to LPH coordinates

%just have to figure these out manually

TangT2w = Calc_Philips_Tang( T2im.Parms.angulation );

XYflipMat= [ [-1 0 0]; [0 -1 0]; [0 0 1]; ];
 
rowMajT2wToLPH = [ [1 0 0]; [0 0 1]; [0 -1 0]; ];

TmomT2w = rowMajT2wToLPH;
%TmomT2w = eye(3);
TtotT2w=TangT2w*TmomT2w;

[T2wax,T2wang] = to_axis(TtotT2w);

%% Temperature

Tmom = Calc_Philips_Tmom( TempIm.Parms.SliceOrientation, TempIm.Parms.preparation_dir, tempScanFatShiftDir );

Tmom=TmomT2w* empiricalRot;
Tang = Calc_Philips_Tang( TempIm.Parms.angulation );
Ttot = Tang*Tmom;

LPH_offcent = [1 1 1].*TempIm.Parms.offcenter([3 1 2]);

MPS_fov = TempIm.Dims(1:3) .* TempIm.Spc;

%create MPS voxel points such that the mid-slice is 0,0,0 in MPS
MvoxEdges = linspace(-MPS_fov(1)/2.0, MPS_fov(1)/2.0, TempIm.Dims(1)+1 );
PvoxEdges = linspace(-MPS_fov(2)/2.0, MPS_fov(2)/2.0, TempIm.Dims(2)+1 );
SvoxEdges = linspace(-MPS_fov(3)/2.0, MPS_fov(3)/2.0, TempIm.Dims(3)+1 );

MPSspc = [MvoxEdges(2)-MvoxEdges(1) PvoxEdges(2)-PvoxEdges(1) SvoxEdges(2)-SvoxEdges(1) ];
Mcenters = 0.5*(  MvoxEdges(1:end-1) + MvoxEdges(2:end) );
Pcenters = 0.5*(  PvoxEdges(1:end-1) + PvoxEdges(2:end) );
Scenters = 0.5*(  SvoxEdges(1:end-1) + SvoxEdges(2:end) );

[timx,timy,timz]=ndgrid(Mcenters, Pcenters, Scenters);
Pm = [2 1 3];
timx = permute(timx, Pm);
timy = permute(timy, Pm);
timz = permute(timz, Pm);
%dTperm = permute(dTmapMPS, Pm);

%flip = [ [-1 0 0]; [0 -1 0]; [0 0 1]; ];
tempTRmatrix = eye(4);
tempTRmatrix(1:3, 1:3) = Ttot;
tempTRmatrix(1:3, 4) = LPH_offcent;
trans = hgtransform('Matrix',tempTRmatrix);
%%

dn=30;
dTmapMPS = deltaTstack(:,:,:,dn);
dTperm = permute(dTmapMPS, Pm);

%% Setup T2w MPS system
LPH_fov_T2w = T2im.Parms.fov([3 1 2]);
LPH_offcent_T2w = T2im.Parms.offcenter([3 1 2]);

%MPS_fov_T2w = (TmomT2w' * LPH_fov_T2w');
MPS_fov_T2w = (T2im.Dims).* T2im.Spc;

%create MPS voxel points such that the mid-slice is 0,0,0 in MPS
MvoxEdges_T2w = linspace(-MPS_fov_T2w(1)/2.0, MPS_fov_T2w(1)/2.0, T2im.Dims(1)+1 );
PvoxEdges_T2w = linspace(-MPS_fov_T2w(2)/2.0, MPS_fov_T2w(2)/2.0, T2im.Dims(2)+1 );
SvoxEdges_T2w = linspace(-MPS_fov_T2w(3)/2.0, MPS_fov_T2w(3)/2.0, T2im.Dims(3)+1 );

Mcenters_T2w = 0.5*(  MvoxEdges_T2w(1:end-1) + MvoxEdges_T2w(2:end) );
Pcenters_T2w = 0.5*(  PvoxEdges_T2w(1:end-1) + PvoxEdges_T2w(2:end) );
Scenters_T2w = 0.5*(  SvoxEdges_T2w(1:end-1) + SvoxEdges_T2w(2:end) );

T2wSpc = [MvoxEdges_T2w(2) - MvoxEdges_T2w(1), PvoxEdges_T2w(2) - PvoxEdges_T2w(1), SvoxEdges_T2w(2) - SvoxEdges_T2w(1)];

MPS_offcent_T2w = (TmomT2w' *LPH_offcent_T2w');

[tx, ty, tz] = ndgrid(Mcenters_T2w, Pcenters_T2w, Scenters_T2w);

Pm = [2 1 3];
tx = permute(tx, Pm);
ty = permute(ty, Pm);
tz = permute(tz, Pm);

volViewPermuted = permute(T2im.Data,[2 1 3]);

%% Draw T2w voxel data in LPH frame.  Uses TmomT2w, MPS->LPH
figure(1);
clf;
hold on;


T2wTRmatrix = eye(4);
T2wTRmatrix(1:3, 1:3) = TtotT2w;
T2wTRmatrix(1:3, 4) = LPH_offcent_T2w;
T2wTrans = hgtransform('Matrix',T2wTRmatrix);

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
p1.Parent = T2wTrans;


cval2 = 0.9;
p2=patch( isosurface( tx, ty, tz, volViewPermuted, cval2 ) );
isonormals(tx, ty, tz, volViewPermuted,p2);
set(p2, 'Clipping', 'on', 'FaceColor', 0.7*[1,1,1], 'EdgeColor', 'none','FaceAlpha',0.2, ...
    'FaceLighting', 'flat', ...
    'AmbientStrength', .5, 'DiffuseStrength', 1, ...
    'SpecularStrength', 1.0, 'SpecularExponent', 5, 'BackFaceLighting', 'unlit' ...
    );


p2.Parent = T2wTrans;

axis equal;
xlabel('x RL (mm)');
ylabel('y AP (mm)');
zlabel('z FH (mm)');
set(gca,'FontSize',24);

%%

Si = 8;
trans = hgtransform('Matrix',tempTRmatrix);

tsurf=slice( timx, timy, timz, dTperm, [], [], Scenters(Si) );
set(tsurf,'EdgeColor','none', 'Facecolor','flat','AmbientStrength', 1.0, 'DiffuseStrength', 0, 'FaceAlpha', 1.0);
tsurf.Parent = trans;
