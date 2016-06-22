

dir='C:\Users\Vandiver\Data\052416_phantom7Tscans\';
file = [dir,'DBIEX_38_1.PAR'];

im = vuOpenImage(file);



if length(im.Dims)==4
    %this assumes a 2D image

    imgMagnitudeSeries = im.Data(:,:,1,:);
    imgPhaseSeries = im.Data(:,:,4,:);
    
    complexSeries = imgMagnitudeSeries .* exp(1j*imgPhaseSeries);
    
    %complexSeries = reshape(complexSeries,[im.Dims(1:2) 1 im.Dims(3)]);
    
    imDims = size(complexSeries);
    
elseif length(im.Dims)==5
   
    %this assumes a 3D image (or multi-slice 2D)

    imgMagnitudeSeries = im.Data(:,:,:,1,:);
    imgPhaseSeries = im.Data(:,:,:,4,:);
    
    complexSeries = imgMagnitudeSeries .* exp(1j*imgPhaseSeries);
    
    imDims = im.Dims;
end

slice_thick_col=23;
slice_gap_col=24;

pix_dx_col=29;
dyn_time_col=32;


%re-order the PAR file table entries in terms of dynamic time
dyninds = im.Parms.tags(:, 3);
[dynindsSorted,dynamicIdxReorder] = sort(dyninds);

dyntimes = im.Parms.tags(dynamicIdxReorder, dyn_time_col);
dyntimes=unique(dyntimes);

nslice = imDims(3);
ndynamics = imDims(4);

axis0_mm = (1:imDims(1))*im.Spc(1);
axis1_mm = (1:imDims(2))*im.Spc(2);
slice_axis_mm = (1:imDims(3))*im.Spc(3);


TE_param_column = 31;
% temperature unwrapping
alpha=0.01;
B0 = 7.0;
TEms = im.Parms.tags(1,TE_param_column);
angle2tempFactor = 1.0 / (42.576*alpha*B0*(TEms*1e-3)*pi);

deltaTseries = zeros(size(complexSeries));

%baseLineComplexImage = complexSeries(:,:,:,1); 
%to average several images for the baseline

baseLineComplexImage = mean( complexSeries(:,:,:,1:1), 4); 

for dn=2:ndynamics
    deltaTseries(:,:,:,dn) = angle2tempFactor*angle( baseLineComplexImage .* conj(complexSeries(:,:,:,dn)) );
end



%%
imagesc( deltaTseries(:,:,1, 80) )

%%
figTemp=figure(1);
clf;
hold on;

dn=ndynamics;

dn=50;


slicenum=1;
minC=0; maxC=30;

magImg=abs(complexSeries(:,:,slicenum,dn));
%convert magnitude to RGB image
magImGray = cat(3,magImg,magImg,magImg);
magImGray = magImGray/max(magImGray(:));

mask=squeeze(deltaTseries(:,:,slicenum,dn)) > minC;
colormap('hot');


use_mm_scale=0;
if use_mm_scale
    imagesc(axis1_mm, axis0_mm, magImGray);
    imagesc(axis1_mm, axis0_mm,deltaTseries(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
    xlabel('mm');
    ylabel('mm');
else
    imagesc(magImGray);
    imagesc(deltaTseries(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
    %imagesc(deltaTseriesCorr(:,:,slicenum,dn), [minC maxC] );
    xlabel('voxel dim 1');
    ylabel('voxel dim 0');
end

axis equal;
axis tight;
cb=colorbar();
cb.Label.FontSize=26;
cb.Label.String='\DeltaT (^oC)';

%%

roidim0 = 47:56;
roidim1 = 45:57;

roiSlices = [1];

roiAvgTemp = squeeze(mean(mean(mean(deltaTseries(roidim0,roidim1,roiSlices,:),1),2),3));
roiMaxTemp = squeeze(max(max(max(deltaTseries(roidim0,roidim1,roiSlices,:),[],1),[],2),[],3));

figure(2);
clf;
hold on;
subplot(121);
plot(dyntimes, roiAvgTemp, 'linewidth',2.0)
xlabel('sec');
ylabel('ROI Avg \DeltaT (^oC)');
subplot(122);
plot(dyntimes, roiMaxTemp, 'linewidth',2.0)
xlabel('sec');
ylabel('ROI Max \DeltaT (^oC)');


figure(figTemp);
if exist('roiPlot','var') & isvalid(roiPlot)
    roiPlot.XData=roidim1([1 1 end end 1]);
    roiPlot.YData=roidim0( [1 end end 1 1]);
else
    roiPlot=plot( roidim1([1 1 end end 1]),  roidim0( [1 end end 1 1]), 'linewidth',2.0, 'color', [0.6 0.9 0.9]);
end
