dir = 'C:\Users\Vandiver\Data\sonalleve\Phantom_20150915';
files_to_compare = {...
     [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'],...
     [dir,'\Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR']
    };
dir='C:\Users\Vandiver\Data\sonalleve\HifuNanos_20160223\';
files_to_compare = {...
     [dir,'scan10_TempTrans_20160223.PAR'],...
     [dir,'scan13_TempTrans_20160223.PAR']
    };

rois={};
roiVox={};


isRI=0;
angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);

[ deltaTseries1, axis0_mm1, axis1_mm1, slice_axis_mm1, dyntimes1, im1 ] = GetDeltaTemp4D_PAR( files_to_compare{1}, isRI, 0.01, angle2tempFactor );
[ deltaTseries2, axis0_mm2, axis1_mm2, slice_axis_mm2, dyntimes2, im2 ] = GetDeltaTemp4D_PAR( files_to_compare{2}, isRI, 0.01, angle2tempFactor );

dV1 = prod(im1.Spc(1:3))*1e-3;
dV2 = prod(im2.Spc(1:3))*1e-3;

% do phase unwrap
mask = (deltaTseries1/angle2tempFactor) <= -0.3*pi;
deltaTseries1(mask) = deltaTseries1(mask) + 2*pi*angle2tempFactor;

mask = (deltaTseries2/angle2tempFactor) <= -0.3*pi;
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


dbid = mksqlite(0,'open',db);

for n=1:2
    [fdir,fbase,fext]=fileparts(files_to_compare{n});
    query = sprintf('select * from data where file="%s%s";',fbase,fext)
    qrydata = mksqlite(dbid, query);

    if n==1
        dims = size(deltaTseries1);
    else
        dims = size(deltaTseries2);
    end
    
    if length(qrydata) > 0
       rois{n} = false(dims);
       rois{n}(qrydata.start0:qrydata.end0, qrydata.start1:qrydata.end1, qrydata.start2:qrydata.end2,:) = true;
       roiVox{n} = struct('i0', qrydata.start0:qrydata.end0, 'i1', qrydata.start1:qrydata.end1, 'i2', qrydata.start2:qrydata.end2);
    else
       rois{n} = true(dims);
       roiVox{n} = struct('i0', 1:dims(1), 'i1', 1:dims(2), 'i2', 1:dims(3));
       disp('not found')
    end
    
end

mksqlite(dbid,'close');

avgTcurve1 = squeeze(mean(mean(mean(deltaTseries1(roiVox{1}.i0, roiVox{1}.i1, roiVox{1}.i2, : ),1),2),3));
avgTcurve2 = squeeze(mean(mean(mean(deltaTseries2(roiVox{2}.i0, roiVox{2}.i1, roiVox{2}.i2, : ),1),2),3));

maxTcurve1 = squeeze(max(max(max(deltaTseries1(roiVox{1}.i0, roiVox{1}.i1, roiVox{1}.i2, : ), [],1), [],2), [],3 ));
maxTcurve2 = squeeze(max(max(max(deltaTseries2(roiVox{2}.i0, roiVox{2}.i1, roiVox{2}.i2, : ), [],1), [],2), [],3 ));

%lesionVox1 = squeeze(sum(sum(sum( cem1 > 240.0, 1),2),3));
%lesionVox2 = squeeze(sum(sum(sum( cem2 > 240.0, 1),2),3));

sthresh1 = find( cumsum(maxTcurve1) > 0.5 );
sthresh2 = find( cumsum(maxTcurve1) > 0.5 );


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
plot( dyntimes1, maxTcurve1, '-', 'Color',[0.9 0.4 0.1] );
plot( dyntimes2 + dyntimes1(sthresh1(1)) - dyntimes2(sthresh2(1)), maxTcurve2, '-','Color',[0.1 0.4 0.9] );
xlabel('sec');
ylabel('max\DeltaT ^oC');

%%
%%
slicenum=5;

dyns = [8];
ncol = 3;
if ncol > length(dyns)
    ncol = length(dyns);
    nrow=1;
else
nrow = ceil(length(dyns)/ncol);
end

rf = 1; gf=0.4; bf=0.4;
roiImSliceRGB1 = cat(3, rf*rois{1}(:,:,slicenum), gf*rois{1}(:,:,slicenum), bf*rois{1}(:,:,slicenum));
roiImSliceRGB2 = cat(3, rf*rois{2}(:,:,slicenum), gf*rois{2}(:,:,slicenum), bf*rois{2}(:,:,slicenum));

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

    image(axis1_mm1, axis0_mm1, roiImSliceRGB1, 'AlphaDataMapping', 'none', 'AlphaData', 0.4*rois{1}(:,:,slicenum) )
    image(axis1_mm1, axis0_mm1, roiImSliceRGB2, 'AlphaDataMapping', 'none', 'AlphaData', 0.4*rois{2}(:,:,slicenum) )
    
    %contour(axis1_mm1, axis0_mm1, cem1(:,:,slicenum,dn), [240 240], 'LineWidth', 2.0, 'Color', [0.9 0.4 0.1] );
    %contour(axis1_mm2, axis0_mm2, cem2(:,:,slicenum,dn2), [240 240], 'LineWidth', 2.0, 'Color', [0.1 0.4 0.9] );
    
    contour(axis1_mm1, axis0_mm1, deltaTseries1(:,:,slicenum,dn), [5 10 30 60], 'LineWidth', 1.0 ); %, 'Color', [0.9 0.4 0.1]
    contour(axis1_mm2, axis0_mm2, deltaTseries2(:,:,slicenum,dn2), [5 10 30 60], 'LineWidth', 1.0 ); %, 'Color', [0.1 0.4 0.9]

    xlabel('mm','FontSize',18);
    ylabel('mm','FontSize',18);
    set(gca, 'FontSize', 20);
    axis equal;
    
    set( ph, 'Position', [1 1 1.01 1.05] .* get(ph,'Position') );
    
end
