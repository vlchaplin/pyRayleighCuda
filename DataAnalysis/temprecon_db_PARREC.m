
force_update_tstart=0;

db = 'C:\Users\Vandiver\Data\sonalleve\sonalleve.db';

% Order is single followed by multi

files_to_compare = {...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_14_1.PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_13_1.PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_11_1.PAR'...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_12_1.PAR'...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
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
% files_to_compare = {...
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
% files_to_compare = {...
%     'Caskey_20150926_WIP_TMap_Sing_60W_CLEAR_4_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_60W_CLEAR_3_1.PAR'...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_11_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_9_1.PAR',...
%   };

% %paramset A 40W
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
files_to_compare = {...
    'Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR',...
    'Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR', ...
    'Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
    'Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
   };

% files_to_compare = {...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_11_1.PAR',...
%     'Caskey_20150924_WIP_TemperatureMapping_CLEAR_9_1.PAR'...
%    };
% A vs B 40W
% files_to_compare = {...
%     'Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR', ...
%     'Caskey_20150926_WIP_TMap_Sing_40W_CLEAR_5_1.PAR',...
%    'Caskey_20150926_WIP_TMap_Mult_40W_CLEAR_6_1.PAR'  ...
%    };

% files_to_compare = {...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_16_1.PAR',...
%     'Caskey_GPh2_99999_WIP_TemperatureMapping_CLEAR_15_1.PAR' ...
%     };


% %all A&B
% files_to_compare = {...
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
%     'Caskey_20150926_WIP_TMap_Sing_B_40W_CLEAR_8_1.PAR',...
%     'Caskey_20150926_WIP_TMap_Mult_B_40W_CLEAR_7_1.PAR', ...
%     'Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
%     'Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
% };
%files_to_compare={'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR'};

dbid = mksqlite(0,'open',db);
singMultSetQry=['select file, groups.gid, tmp.gsize, condition from groups join (select gid, count(*) as gsize from groups where fid IN (select fid from data where quality==0) group by gid) as tmp ON groups.gid==tmp.gid where tmp.gsize ==2'];

dataSetFromdb =mksqlite(dbid, singMultSetQry);

files_to_compare = {dataSetFromdb.file};

%mksqlite(dbid,'close');
%%


TFig=figure(1);
clf;
hold on;
xlabel('sec');
ylabel('\Delta T (^oC)');

volFig=figure(2);
clf;
hold on;
xlabel('sec');
ylabel('Lesion volume (ml)');

plotObjs=[];
plotObjs2=[];

timeData = {};
tempData = {};
volData = {};


for fn=1:length(files_to_compare)

    [fdir,fbase,fext]=fileparts(files_to_compare{fn});
    query = sprintf('select * from data where file="%s%s";',fbase,fext)
    qrydata = mksqlite(dbid, query);
    
    
    [ deltaTseries, axis0_mm, axis1_mm, slice_axis_mm, dyntimes, im ] = GetDeltaTemp4D_PAR( [qrydata.path,'\',qrydata.file], qrydata.isRI, 0.01 );

    query = sprintf('select * from params where file="%s%s";',fbase,fext)
    displaydata = mksqlite(dbid, query);
    
    angle2tempFactor = 1.0 / (42.576*0.01*3.0*0.016*pi);
    mask = (deltaTseries/angle2tempFactor) <= -0.8*pi;
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
    
    marker='none';
    if isempty(displaydata.displayname)
        displayName = fbase(end-12:end);
        if mod(fn,2)
            marker='o';
        else
            marker='^';
        end
    else
        displayName=[displaydata.displayname, ' ', qrydata.date, ' ' , displaydata.traj];
    end
    
    
    T0=22;
    rbase = 4.0*ones(size(dTroi));
    rbase( (T0+dTroi) > 43.0 ) = 2.0;
    cem = cumsum( rbase.^((T0+dTroi) - 43.0),4 ) .* repmat( reshape(dyntimes/60.0,[1 1 1 length(dyntimes)]), [sz(1:3) 1] ) ;
    lesVox = 1e-3*prod(im.Spc)*squeeze(sum(sum(sum(cem >= 240.0,1),2),3));
    
    figure(1);
    %pl = plot( dyntimes- dyntimes(t0idx), avgTemp, 'DisplayName', [fbase sprintf(' %f ml, N=%d',roiVol_ml, roiNvox)] );
    pl = plot( dyntimes- dyntimes(t0idx), avgTemp, 'DisplayName', displayName, 'LineWidth',2.0, 'Marker',marker );
    
    if mod(fn,2) 
        set(pl,'LineStyle','--');
    else
        color=get(plprev,'Color'); 
        set(pl,'Color', color);
    end
    
    %single-focus is the first of each pair: {:}{1}  Multi- is {:}{2}
    
    timeData{ceil(fn/2)}{mod(fn+1,2)+1} = dyntimes- dyntimes(t0idx);
    tempData{ceil(fn/2)}{mod(fn+1,2)+1} = avgTemp;
    volData{ceil(fn/2)}{mod(fn+1,2)+1} = lesVox;
    
    plprev=pl;
    plotObjs(end+1)=plprev;
    
    figure(2);
    plcem = plot( dyntimes- dyntimes(t0idx), lesVox, 'DisplayName', displayName, 'LineWidth',2.0,  'Marker',marker );
    
    %single-focus is the first of each pair
    if mod(fn,2) 
        set(plcem,'LineStyle','--');
    else
        color=get(plprev,'Color'); 
        set(plcem,'LineStyle','-','Color', color);
    end
    
    
    plotObjs2(end+1)=plcem;
    
end
mksqlite(dbid,'close');

figure(1);
leg=legend(plotObjs);
set(leg,'Interpreter', 'None', 'Location', 'Northwest','FontSize',16);

figure(2);
leg2=legend(plotObjs2);
set(leg2,'Interpreter', 'None', 'Location', 'Northwest', 'FontSize',16);


set(TFig.CurrentAxes,'FontSize',24);
set(volFig.CurrentAxes,'FontSize',24);


%%

% select the longest time baseline set for interpolation
nPairs = length(timeData);
longestTimeAx=0;
maxTime=0;
for n=1:nPairs
    tm1=max(timeData{n}{1});
    tm2=max(timeData{n}{2});
    [tm tmi] = max([tm1 tm2]);
    
    if tm > maxTime
        longestTimeAx = [n tmi];
        maxTime = tm;
    end

end

refPair = longestTimeAx(1);
timeAxis = timeData{longestTimeAx(1)}{longestTimeAx(2)};

nt = length(timeAxis);

volDeltaFinalPct = [];
tempDeltaFinalPct = [];
tempDeltaFinal = [];
volDeltaFinal=[];

figVol=figure(3);
clf; 
hold on;

figTemp=figure(4);
clf; 
hold on;
 
singleVol=0;
multiVol=0;

%Single- {:}{1}  Multi- {:}{2}
for n=1:nPairs
    try
        volInterp1 = interp1(timeData{n}{1}, volData{n}{1},timeAxis, 'linear',NaN);
        volInterp2 = interp1(timeData{n}{2}, volData{n}{2},timeAxis, 'linear',NaN);
    
        tempInterp1 = interp1(timeData{n}{1}, tempData{n}{1},timeAxis, 'linear',NaN);
        tempInterp2 = interp1(timeData{n}{2}, tempData{n}{2},timeAxis, 'linear',NaN);
    catch
        continue;
    end
    %throw out the extrapolated values
    extraps = ( isnan( volInterp1) | isnan( volInterp2) );
    t = timeAxis(~extraps);
    volInterp1 = volInterp1(~extraps);
    volInterp2 = volInterp2(~extraps);
    
    tempInterp1 = tempInterp1(~extraps);
    tempInterp2 = tempInterp2(~extraps);
    
    pl1 = plotObjs(2*(n-1) + 2);
    
    volChange = (volInterp2 - volInterp1) ;
    tempChange = tempInterp2 - tempInterp1;
    
    volDeltaFinal(end+1) = volChange(end) / t(end);
    tempDeltaFinal(end+1) = tempChange(end) / t(end);
    volDeltaFinalPct(end+1) = volChange(end) / volInterp1(end);
    tempDeltaFinalPct(end+1) = tempChange(end) / tempInterp2(end);
    
    if isnan(volDeltaFinalPct(end))
        volDeltaFinalPct(end)=0;
    end
    
    singleVol =singleVol+ volInterp1(end);
    multiVol =multiVol+ volInterp2(end);
  
    figure(figVol);
    plVolChange = plot( t, volChange, 'Color', get(pl1,'Color'), 'LineStyle', get(pl1,'LineStyle'),'LineWidth',2.0, 'DisplayName', get(pl1,'DisplayName') );
    plot( t([end end]), [0 volChange(end)], '--',  'Color', get(pl1,'Color'));
    plot( t([1 end]), [0 0], 'k--');
    %set(plcem,'LineStyle', get(pl,'LineStyle'), 'Color', get(pl,'Color'))
    
    figure(figTemp);
    plVolChange = plot( t, tempChange, 'Color', get(pl1,'Color'), 'LineStyle', get(pl1,'LineStyle'),'LineWidth',2.0, 'DisplayName', get(pl1,'DisplayName') );
    plot( t([end end]), [0 tempChange(end)], '--',  'Color', get(pl1,'Color'));
    plot( t([1 end]), [0 0], 'k--');
    
end

set(figVol.CurrentAxes,'FontSize',24);
figVol.CurrentAxes.XLabel.String='sec';
figVol.CurrentAxes.YLabel.String='\Delta mL';

set(figTemp.CurrentAxes,'FontSize',24);
figTemp.CurrentAxes.XLabel.String='sec';
figTemp.CurrentAxes.YLabel.String='\Delta \DeltaT';

disp(sprintf('%60s, %10s, %10s, %10s, %10s','File','delta ml/min', 'delta T/min', '%% vol','%% temp'))
for n=1:length((volDeltaFinalPct))
    disp(sprintf('%60s, %10f, %10f, %10f, %10f, \n',files_to_compare{2*n-1}, 60*volDeltaFinal(n), 60*tempDeltaFinal(n), 100*volDeltaFinalPct(n), 100*(tempDeltaFinalPct(n)) ))
    disp(sprintf('%60s\n',files_to_compare{2*n} ))
end

sprintf('delta-volume (ml/min) = %f +/- %f, N=%d', 60*mean(volDeltaFinal), std(60*volDeltaFinal), length((volDeltaFinal)) )
sprintf('delta delta-T (C/min) = %f +/- %f, N=%d', 60*mean(tempDeltaFinal), std(60*tempDeltaFinal), length((tempDeltaFinal)) )

sprintf('cumulative volume ratio multi/single %%: %f' , 100*multiVol / singleVol)


sprintf('delta-volume (%%) = %f +/- %f, N=%d', 100*mean(volDeltaFinalPct), 100*std(volDeltaFinalPct), length((volDeltaFinalPct)) )
sprintf('delta delta-T (%%) = %f +/- %f, N=%d', 100*mean(tempDeltaFinalPct), 100*std(tempDeltaFinalPct), length((tempDeltaFinalPct)) )
