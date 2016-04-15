function [ inputPower,avgbbNoise_mV,avgbbSpecPower,avghmSpecPower,avgBBToHarm,stdbbNoise_mV,stdbbSpecPower,stdhmSpecPower,stdBBToHarm  ] = pcd_gagedata_analyze_sonalleve_func( globfiles, butter_win, outfile, selection_width_us, approx_echo_arrival_us, num_acq, xlabelstr )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dir=['C:\Users\Vandiver\Data\sonalleve\HifuPCD_20160323\sonalleve_pcd_032316\'];

eval(['cd ' dir]);

%globfiles = strsplit(evalc(['ls *phantmulti_10*.mat']));
files={};
for ng=1:length(globfiles)
    if exist(globfiles{ng})==2
        files{end+1} = globfiles{ng};
    end
end

%sort file names according to input power
inputPower=zeros([1 length(files)]);

for nf=1:length(files)
    [path,name,ext]=fileparts(files{nf});
    
    vstring=regexpi(name,'(\d+).*_','tokens');
    inputPower(nf) = str2double( vstring{1} );
end

all_acq=0;
if ~exist('num_acq','var')
    all_acq=1;
end

if ~exist('xlabelstr','var')
    xlabelstr='Power (W)';
end

[inputPower sortinds]=sort(inputPower);

files = files(sortinds);

bbToHarmRatios = {};
bbNoise_mV = {};
bbSpecPower={};
hmSpecPower = {};
bbNoise_mV_5sigma={};
bbSpecAmp={};
bbHmAmp={};

%[bb,ba] = butter(3,[5.0e6 15.0e6]/ (100.0e6/2) );butter_win
[bb,ba] = butter(3, butter_win );

avgbbNoise_mV=zeros([1 length(files)]);
avgbbSpecPower=zeros([1 length(files)]);
avgBBToHarm=zeros([1 length(files)]);

stdbbNoise_mV=zeros(size(avgbbNoise_mV));
stdbbSpecPower=zeros(size(avgbbNoise_mV));
stdBBToHarm=zeros(size(avgbbNoise_mV));

for nf=1:length(files)
    [path,name,ext]=fileparts(files{nf});
    load( files{nf});
    
%     vstring=regexpi(name,'(\d+).*_','tokens');
%     inputPower(nf) = str2double( vstring{1} );
    
    if all_acq
        num_acq=size(saved_PC_sig,1);
    end
    %num_acq=10;
    
    disp(['Analyzing ' name  ext] )
    
    bbToHarmRatios{nf} = zeros([1 num_acq]);
    bbNoise_mV{nf} = zeros([1 num_acq]);
    bbSpecPower{nf}= zeros([1 num_acq]);
    bbSpecAmp{nf}= zeros([1 num_acq]);
    bbHmAmp{nf}= zeros([1 num_acq]);
    hmSpecPower{nf}= zeros([1 num_acq]);
    bbNoise_mV_5sigma{nf}= zeros([1 num_acq]);
    for a=1:num_acq
    %for a=1:1
        voltageSeries = saved_PC_sig(a,:);

        %Should be 100 MHz scope sampling rate
        Fs=1.0 / (timeaxis1(2) - timeaxis1(1));

        %approx_echo_arrival_us=140;
        pulse_duration_us=1000;
        %selection_width_us=200;

        bg_time_mask = (timeaxis1 < 1e-6*(approx_echo_arrival_us-30)) | (timeaxis1 > 1600*1e-6);

        %find transient
        trspikes=find(abs(voltageSeries) > 0.99);
        if numel(trspikes)>0
            ti=trspikes(1);
            bg_time_mask = bg_time_mask | ((timeaxis1>(timeaxis1(ti)-20e-6)) & (timeaxis1<(timeaxis1(ti)+20e-6)));
        end
        
       
        bgMean = mean(voltageSeries(bg_time_mask));
        bgStd = std(voltageSeries(bg_time_mask));
        
        bgSeries = voltageSeries;
        bgSeries(~bg_time_mask)=0;
        
        bgSigma = std(bgSeries);

        src_time_mask = (timeaxis1 > 1e-6*(approx_echo_arrival_us)) & (timeaxis1 < 1e-6*(approx_echo_arrival_us+selection_width_us));
        src_time_mask = src_time_mask & (~bg_time_mask);
        
        voltageSeries = voltageSeries - bgMean;
        
        voltageSeries(~src_time_mask)=0;
        
        voltageSeries=filter(bb,ba,voltageSeries);

        bgs0 = find(bg_time_mask,1);
        bgs1 = find(bg_time_mask,1,'last');



        figure( 1);
        clf;
        hold on;
        plot( timeaxis1, saved_PC_sig(a,:));
        plot( timeaxis1([bgs0 bgs0]), ylim(), 'k--' );
        plot( timeaxis1([bgs1 bgs1]), ylim(), 'k--' );

        N = length(timeaxis1);
        NFFT = 2^nextpow2(N); % Next power of 2 
        sigFFT = fft(voltageSeries,NFFT)/N;
        bgFFT = fft(bgSeries,NFFT)/N;

        fendidx=NFFT/2+1;
        fMHz = Fs/2*linspace(0,1,fendidx)*1e-6;

        harmonicFilt = ones(size(sigFFT));
        f0MHz = 1.2;
        nharm=ceil(fMHz(end)/f0MHz);
        tw=200;
        %harmonics
        for n=1:nharm
            if n==1
                %dropout=n*f0MHz + [-0.04 0.04];
                dropout=[-0.1 f0MHz+0.1];
            else
                dropout=n*f0MHz + [-0.05 0.05];
            end
            harmonicFilt(1:fendidx) = harmonicFilt(1:fendidx).*(1.0 ./ (1.0 + exp(tw*(fMHz- dropout(1) )))  +  1.0 ./ (1.0 + exp(-tw*(fMHz- dropout(2) ))));
        end
        %ultraharmonics
        for n=2:nharm
            dropout=(n+0.5)*f0MHz + [-0.03 0.03];
            harmonicFilt(1:fendidx) = harmonicFilt(1:fendidx).*(1.0 ./ (1.0 + exp(tw*(fMHz- dropout(1) )))  +  1.0 ./ (1.0 + exp(-tw*(fMHz- dropout(2) ))));
        end
        

        noiseFilt = ones(size(sigFFT));
        noiseWindowsMHz = {[5 10], [15 50]};
        noiseWindowsMHz={};
        tw=100;
        for n=1:length(noiseWindowsMHz)
            dropout=noiseWindowsMHz{n};
            noiseFilt(1:fendidx) = noiseFilt(1:fendidx).*(1.0 ./ (1.0 + exp(tw*(fMHz- dropout(1) )))  +  1.0 ./ (1.0 + exp(-tw*(fMHz- dropout(2) ))));
        end

        figure(2);
        clf;
        hold on;
        plot( fMHz, 2*abs(sigFFT(1:fendidx)) );
        %plot( fMHz, 2*abs(bgFFT(1:fendidx)),'g' );
        yll=get(gca,'YLim');
        yb=yll(2);
        %plot( fMHz, 0.1*yb*noiseFilt(1:fendidx),'k' );
        plot( fMHz, 0.1*yb*harmonicFilt(1:fendidx),'k' );

        cleanedSpectrum = (sigFFT ).*noiseFilt.*harmonicFilt;
        harmonicSpec = (sigFFT).*noiseFilt.*(1-harmonicFilt);

        plot( fMHz, 2*abs(cleanedSpectrum(1:fendidx)),'r' );
        plot( fMHz, 2*abs(harmonicSpec(1:fendidx)),'color',[.7 .7 .7] );
        
        %totalPower = sum( 4*abs(sigFFT(1:fendidx)).^2 );
        harmonicPower = sum( 4*abs(harmonicSpec(1:fendidx)).^2 );
        broadBandPower = sum( 4*abs(cleanedSpectrum(1:fendidx)).^2 );
        
        hmAmp=mean( 2*abs(harmonicSpec(1:fendidx)) );
        bbAmp=mean( 2*abs(cleanedSpectrum(1:fendidx)) );
%         totalAmp = mean( 2*abs(sigFFT(1:fendidx)) );
        
        bbToHarmRatios{nf}(a) = broadBandPower/(harmonicPower+broadBandPower);
        %bbToHarmRatios{nf}(a) = bbAmp/(totalAmp);
        bbSpecPower{nf}(a)=broadBandPower;
        hmSpecPower{nf}(a) = harmonicPower;
        bbSpecAmp{nf}(a)=bbAmp ;
        bbHmAmp{nf}(a)=hmAmp;
        
        %disp(sprintf('BB/(BB+harmonic) power = %f',broadBandPower/(harmonicPower+broadBandPower) ))

        sigFilt=ifft(N*cleanedSpectrum);
        figure(1);
        plot( timeaxis1, real((sigFilt(1:N))),'r');
        
        absFiltSignal=abs(sigFilt);
        bbNoise_mV{nf}(a) = 1000*mean(absFiltSignal);
        bbNoise_mV_5sigma{nf}(a) = 1000*mean(absFiltSignal(absFiltSignal>(5*bgStd)));

    end
    
    
    avgbbNoise_mV(nf)=mean(bbNoise_mV{nf});
    avgbbSpecPower(nf)=mean(bbSpecPower{nf});
    avghmSpecPower(nf)=mean(hmSpecPower{nf});
    avgBBToHarm(nf) = mean(bbToHarmRatios{nf});
    
    stdbbNoise_mV(nf)=std(bbNoise_mV{nf});
    stdbbSpecPower(nf)=std(bbSpecPower{nf});
    stdhmSpecPower(nf)=std(hmSpecPower{nf});
    stdBBToHarm(nf)=std(bbToHarmRatios{nf});
end


%%

%pnpFromVin_MPa = (7.8363*inputPower + 9.9976)*1e-3;

xvalues = inputPower;

figure(4);
clf;
hold on;
for nf=1:length(files)
    num_acq=length( bbToHarmRatios{nf} );
    ax1=subplot(131);
    hold on;
    plot( xvalues(nf)*ones([1 num_acq]), bbNoise_mV{nf}, '^' );
    
    ax2=subplot(132);
    hold on;
    plot( xvalues(nf)*ones([1 num_acq]), bbSpecPower{nf}, '^' );
    
    ax3=subplot(133);
    hold on;
    plot( xvalues(nf)*ones([1 num_acq]), bbToHarmRatios{nf}, '^' );
end

for ax=[ax1,ax2,ax2]
    xlabel(ax,xlabelstr);
end

ylabel(ax1,'BB noise level (mV)');
ylabel(ax2,'BB power ');
ylabel(ax3,'BB/Total power ');

%set(ax3,'YLim',[0.8,1.0]);

%%
figure(5);
%clf;
hold on;

ax1=subplot(131);
hold on;
%plot( inputVoltages, avgbbNoise_mV);
errorbar(xvalues, avgbbNoise_mV, stdbbNoise_mV,'o','linewidth',1.5);
%semilogy(xvalues, avgbbNoise_mV,'-o')
axis tight

ax2=subplot(132);
hold on;
%plot( inputVoltages, avgbbSpecPower);
errorbar(xvalues,avgbbSpecPower, stdbbSpecPower,'o','linewidth',1.5);
%semilogy(xvalues, avgbbSpecPower,'-o')
axis tight

ax3=subplot(133);
hold on;
%plot( inputVoltages, avgbbSpecPower);
errorbar(xvalues,avgBBToHarm, stdBBToHarm,'o','linewidth',1.5);
axis tight

for ax=[ax1,ax2,ax3]
    xlabel(ax,xlabelstr);
end

ylabel(ax1,'BB noise level (mV)');
ylabel(ax2,'BB power ');
ylabel(ax3,'BB/Total power ');

%xlabel(ax3,'Vin (mV)');
%ylabel(ax3,'BB/Harm. power ');



save(outfile);

end

