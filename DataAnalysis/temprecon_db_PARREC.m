


db = 'C:\Users\Vandiver\Data\sonalleve\sonalleve.db';
% 
% files_to_compare = {...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_14_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_13_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_11_1.PAR'...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_12_1.PAR'...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
%     'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
%     };

%single vs triangular sweep, 20W & 30W
files_to_compare = {...
    'QA_phantom_20150621\Caskey_999_11_01_15.14.59_(TemperatureMapping_CLEAR).PAR',...
    'QA_phantom_20150621\Caskey_999_08_01_14.49.12_(TemperatureMapping_CLEAR).PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR',...
    'QA_phantom_20150628\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR'...
    };


dbid = mksqlite(0,'open',db);

figure(1);
clf;
hold on;
xlabel('sec');
ylabel('\Delta T (^oC)');
for fn=1:length(files_to_compare)

    [fdir,fbase,fext]=fileparts(files_to_compare{fn});
    query = sprintf('select * from mrhifu where file="%s%s";',fbase,fext)
    qrydata = mksqlite(dbid, query);
    
    [ deltaTseries, axis0_mm, axis1_mm, slice_axis_mm, dyntimes, im ] = GetDeltaTemp4D_PAR( [qrydata.path,'\',qrydata.file], qrydata.isRI, 0.1 );

    dTroi = deltaTseries(qrydata.refvox0 + (-3:3),qrydata.refvox1 + (-3:3),qrydata.refvox2 + (-1:1), :);
    sz=size(dTroi);
    flattened = reshape(dTroi,sz(1)*sz(2)*sz(3),sz(4));
    avgTemp = mean(flattened,1);
    %avgTemp = max(flattened);
    pl = plot( dyntimes, avgTemp );
    
    if mod(fn,2) 
        set(pl,'LineStyle','--');
    else
        color=get(plprev,'Color'); 
        set(pl,'Color', color);
    end
    
    plprev=pl;
    
end
mksqlite(dbid,'close');