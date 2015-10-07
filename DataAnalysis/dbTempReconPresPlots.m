
force_update_tstart=0;

db = 'C:\Users\Vandiver\Data\sonalleve\sonalleve.db';

% Order is single followed by multi

files_to_compare = {...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_14_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_13_1.PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_11_1.PAR'...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_12_1.PAR'...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
    };

%single vs triangular sweep, 20W & 30W
% files_to_compare = {...
%     'QA_phantom_20150621\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR',...
%     'QA_phantom_20150621\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
%    };
% 
% files_to_compare = {...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR' ...
%    };

%paramset A
% files_to_plot = {...
%     'Caskey_20150926_WIP_TMap_Sing_60W_CLEAR_4_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_60W_CLEAR_3_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_11_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_9_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR', ...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_6_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_5_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'...
%    };

%paramset A 60W
files_to_plot = {...
    'Caskey_20150926_WIP_TMap_Sing_60W_CLEAR_4_1.PAR',...
    'Caskey_20150926_WIP_TMap_Mult_60W_CLEAR_3_1.PAR',...
    'Caskey_20150924_WIP_TemperatureMapping_CLEAR_11_1.PAR',...
    'Caskey_20150924_WIP_TemperatureMapping_CLEAR_9_1.PAR',...
   };
% % %paramset A 40W
% files_to_compare = {...
%     'Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR', ...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_6_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_5_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'...
%    };
% 
% %paramsec B
% % files_to_compare = {...
% %     'Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR',...
% %     'Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR', ...
% %     'Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
% %     'Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
% %    };
% 
% % A vs B 40W
% files_to_plot = {...
%     'Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR', ...
%     'Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR',...
%    'Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR'  ...
%    };

% files_to_plot = {...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_4_1.PAR',...
%     'Grissom_8888_WIP_TemperatureMapping_CLEAR_3_1.PAR'};
% files_to_plot = {...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_16_1.PAR',...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_15_1.PAR'};
% files_to_plot = {...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_8_1.PAR',...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_12_1.PAR'};

%files_to_compare={'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR'};
dbid = mksqlite(0,'open',db);

figure(1);
clf;
hold on;
xlabel('sec');
ylabel('\Delta T (^oC)');

figure(2);
clf;
hold on;
xlabel('sec');
ylabel('Lesion volume (ml)');

plotObjs=[];
plotObjs2=[];

for fn=1:length(files_to_plot)

    [fdir,fbase,fext]=fileparts(files_to_plot{fn});
    query = sprintf('select * from data where file="%s%s";',fbase,fext)
    qrydata = mksqlite(dbid, query);
    
    
    [ deltaTseries, axis0_mm, axis1_mm, slice_axis_mm, dyntimes, im ] = GetDeltaTemp4D_PAR( [qrydata.path,'\',qrydata.file], qrydata.isRI, 0.01 );

    query = sprintf('select * from params where file="%s%s";',fbase,fext)
    displaydata = mksqlite(dbid, query);
    
    angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);
    mask = (deltaTseries/angle2tempFactor) <= -0.5*pi;
    
    deltaTseries(mask) = deltaTseries(mask) + 2*pi*angle2tempFactor;
    
    
    dTroi = deltaTseries(qrydata.start0:qrydata.end0, qrydata.start1:qrydata.end1, qrydata.start2:qrydata.end2, :);
    sz=size(dTroi);
    flattened = reshape(dTroi,sz(1)*sz(2)*sz(3),sz(4));
    
    roiNvox =  prod(sz(1:3));
    roiVol_ml = prod(sz(1:3).*im.Spc(1:3))*1e-3;
    
    avgTemp = mean(flattened,1);
    %avgTemp = max(flattened);
    %avgTemp_per_ml = sum(flattened,1) / roiVol_ml;
    %avgTemp_per_ml = squeeze( sum(sum(sum(dTroi,1),2),3) ) / roiVol_ml;
    disp(sprintf('roi volume ml: %f',roiVol_ml))
    sthresh = find( cumsum(avgTemp) > .5 ) - 1;
    t0idx = sthresh(1)-1;
    if t0idx == 0
        t0idx = 1;
    end
    disp(sthresh(1)-1)
    if force_update_tstart || (~isfield(qrydata,'tstartidx')) || length(qrydata.tstartidx)==0
        disp([fbase fext ' no tstart'])
        query = sprintf('update data set tstart=%f, tstartidx=%d where file="%s%s";',dyntimes(t0idx), t0idx,fbase,fext)
        mksqlite(dbid, query)
    else
        t0idx = qrydata.tstartidx;
    end
    
    T0=25;
    rbase = 4.0*ones(size(deltaTseries));
    rbase( (T0+deltaTseries) > 43.0 ) = 2.0;
    cem = cumsum( rbase.^((T0+deltaTseries) - 43.0),4 ) .* repmat( reshape(dyntimes/60.0,[1 1 1 length(dyntimes)]), [im.Dims(1:3) 1] ) ;
    cemROI=cem(qrydata.start0:qrydata.end0, qrydata.start1:qrydata.end1, qrydata.start2:qrydata.end2);
    lesVox = 1e-3*prod(im.Spc)*squeeze(sum(sum(sum(cemROI >= 240.0,1),2),3));
    
%     figure(1);
%     %pl = plot( dyntimes- dyntimes(t0idx), avgTemp, 'DisplayName', [fbase sprintf(' %f ml, N=%d',roiVol_ml, roiNvox)] );
%     pl = plot( dyntimes- dyntimes(t0idx), avgTemp, 'DisplayName', displaydata.displayname, 'LineWidth', 3.0 );
%     
%     if mod(fn,2) 
%         set(pl,'LineStyle','--');
%     else
%         color=get(plprev,'Color'); 
%         set(pl,'Color', color);
%     end
%     
%     plprev=pl;
    %plotObjs(end+1)=plprev;
    
    if isempty(displaydata.displayname)
        displaydata.displayname='';
    end
%     figure(2);
%     plcem = plot( dyntimes- dyntimes(t0idx), lesVox, 'DisplayName', displaydata.displayname, 'LineWidth', 3.0 );
%     
%     if mod(fn,2) 
%         set(plcem,'LineStyle','--');
%     else
%         color=get(plprev,'Color'); 
%         set(plcem,'Color', color);
%     end
    
    
    %plotObjs2(end+1)=plcem;
    
    dn =im.Dims(end) - 25;
    slicenum = round((qrydata.start2+qrydata.end2)/2.0);
    
    magImGray = cat(3,im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn),im.Data(:,:,slicenum,1,dn));
    magImGray = magImGray/max(magImGray(:));
    
    mask=squeeze(deltaTseries(:,:,slicenum,dn)) > 2.0;
    
    figure('name',fbase);
    
    colormap('hot');
    minC=0;
    maxC=30;
    set(gcf,'Color', 'white');
    subplot(121);
    hold on;
    
    imagesc(axis1_mm*0.1,axis0_mm*0.1,magImGray);
    %axis0_mm, axis1_mm, slice_axis_mm
    imA=imagesc(axis1_mm*0.1,axis0_mm*0.1, deltaTseries(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [minC maxC]);
    cb=colorbar('Location','northoutside');
    cb.Label.FontSize=26;
    cb.Label.String='\DeltaT (^oC)';
    
    roiR0 = 0.1*axis0_mm([qrydata.start0 qrydata.end0]);
    roiR1 = 0.1*axis1_mm([qrydata.start1 qrydata.end1]);
    roi01verts= [ roiR0([1 1 2 2 1]) ; roiR1([1 2 2 1 1]) ];
    plot( roi01verts(2,:), roi01verts(1,:),  'Color', [0.7 0.7 1.0], 'LineWidth', 2.0);
    
    %textlab=text( 0.05, 0.1, sprintf('[%d] t=%0.1f sec', dn, dyntimes(dn) ), 'FontSize',18,'FontWeight', 'bold', 'Color', [0.9 0 0], 'Units','normalized' );
    axis equal tight;
    xlabel('cm', 'FontSize', 26);
    ylabel('cm', 'FontSize', 26);
    set(gca,'FontSize',26);
    
    subplot(122);
    colormap('hot');
    hold on;
    imagesc(axis1_mm *0.1,axis0_mm*0.1 ,magImGray);
    imB=imagesc(axis1_mm*0.1,axis0_mm*0.1, cem(:,:,slicenum,dn), 'AlphaDataMapping', 'none', 'AlphaData', mask, [0 240]);
    cb=colorbar('Location','northoutside');
    cb.Label.FontSize=26;
    cb.Label.String='CEM';
    set(gca, 'YDir', 'Normal');
    axis equal tight;
    xlabel('cm', 'FontSize', 26);
    ylabel('cm', 'FontSize', 26);
    set(gca,'FontSize',26);
    
    roiR0 = 0.1*axis0_mm([qrydata.start0 qrydata.end0]);
    roiR1 = 0.1*axis1_mm([qrydata.start1 qrydata.end1]);
    roi01verts= [ roiR0([1 1 2 2 1]) ; roiR1([1 2 2 1 1]) ];
    plot( roi01verts(2,:), roi01verts(1,:),  'Color', [0.7 0.7 1.0], 'LineWidth', 2.0);
    
    saveas(gcf, ['C:\Users\Vandiver\Data\sonalleve\BatchAnalysis\maps\' fbase '.png']);
    
end
mksqlite(dbid,'close');
% 
% figure(1);
% leg=legend(plotObjs);
% set(leg,'Interpreter', 'None', 'Location', 'Northwest');
% 
% figure(2);
% leg2=legend(plotObjs2);
% set(leg2,'Interpreter', 'None', 'Location', 'Northwest');
