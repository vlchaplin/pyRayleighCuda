

%% simulation data
filename='C:\\Users\\Vandiver\\Data\\simulations\\circ_nfoc\\nfoci_circ_triangle_2_d=3.5mm.hdf5'

simCEMvsTimevsPass = h5read(filename,'/1/CEM');

tstops = h5readatt(filename,'/1/CEM','tstops');
TON_1 = h5read(filename,'/1/TonCurve');
TOFF_1 = h5read(filename,'/1/ToffCurve');

simCEMvsTimevsPass = h5read(filename,'/1/CEM');

tstops_3 = h5readatt(filename,'/3/CEM','tstops');
TON_3 = h5read(filename,'/3/TonCurve');
TOFF_3 = h5read(filename,'/3/ToffCurve');

%avgRate = ( cem240VolVsTime(end) - cem240VolVsTime(1) ) / ( times(end) - times(1) );
T0=22;
figure(1);
clf;
hold on;
psim1=plot(tstops, (TON_1-T0), 'k--');
psim3=plot(tstops, (TON_3-T0), '-','Color',[0,0,0.9]);


%% MRI data

file_multi='C:\\Users\\Vandiver\\Data\\sonalleve\\QA_phantom_20150628\\Caskey_9999_WIP_TemperatureMapping_CLEAR_6_1.PAR';
isRI=0;
refvox0=66;
refvox1=63;
refvox2=10;
[ deltaTseries_multi, axis0_mm, axis1_mm, slice_axis_mm, dyntimes_1, im ] = GetDeltaTemp4D_PAR( file_multi, isRI, 0.1 );

dTroi = deltaTseries_multi(refvox0 + (-3:3),refvox1 + (-3:3),refvox2 + (-1:1), :);
sz=size(dTroi);
flattened = reshape(dTroi,sz(1)*sz(2)*sz(3),sz(4));
avgTemp_multi = mean(flattened,1);
stdTemp_multi = std(flattened,0,1);
stdTemp_multi = ones(size(avgTemp_multi));

file_1='C:\\Users\\Vandiver\\Data\\sonalleve\\QA_phantom_20150628\\Caskey_9999_WIP_TemperatureMapping_CLEAR_7_1.PAR';

[ deltaTseries_1, axis0_mm, axis1_mm, slice_axis_mm, dyntimes_multi, im ] = GetDeltaTemp4D_PAR( file_1, isRI, 0.1 );

dTroi = deltaTseries_1(refvox0 + (-3:3),refvox1 + (-3:3),refvox2 + (-1:1), :);
sz=size(dTroi);
flattened = reshape(dTroi,sz(1)*sz(2)*sz(3),sz(4));
avgTemp_1 = mean(flattened,1);
stdTemp_1 = std(flattened,0,1);
stdTemp_1 = ones(size(avgTemp_1));

pMR_1=plot( dyntimes_1, avgTemp_1, '*', 'Color', get(psim1,'Color') );
%errorbar( dyntimes_1, avgTemp_1, stdTemp_1, 'LineStyle', 'none', 'Color', get(pMR_1,'Color') );
pMR_mult=plot( dyntimes_multi, avgTemp_multi, '^', 'Color', get(psim3,'Color') )
%errorbar( dyntimes_1, avgTemp_multi, stdTemp_multi, 'LineStyle', 'none', 'Color', get(pMR_mult,'Color') );

xlabel('seconds', 'FontSize', 20);
ylabel('\DeltaT (^oC)', 'FontSize', 20);
legend([psim1 pMR_1 psim3 pMR_mult], {'Single-focus sim', 'Single-focus MRI data', 'Multi-focus sim', 'Multi-focus MRI data' },...
        'Location', 'Southeast', 'FontSize', 17);

set(gca, 'FontSize', 20);


%set(gca(),'Title', text(0.05,0.9,'P=30W acoustic', 'Fontsize', 16, 'Units', 'normalized'))
%text(0.05,0.9,'P=30W acoustic', 'Fontsize', 16, 'Units', 'normalized');
