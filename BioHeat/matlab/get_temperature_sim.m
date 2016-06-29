function [ timearray, temparray, TfinalMap ] = get_temperature_sim( T0, bioheatparams, accousticIntensity, ROI, xyzdims, xyzresolution, totalTime, dataInterval, simTstep, freeOut   )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

c = bioheatparams.c;
kt = bioheatparams.kt;
alpha = bioheatparams.alpha;
rho = bioheatparams.rho;
Cp = bioheatparams.Cp;
bloodTemp = bioheatparams.bloodTemp;
perfusionRate = bioheatparams.perfusionRate;

NDataPoints = ceil(totalTime/dataInterval);

timearray=zeros(1,NDataPoints);
temparray=zeros(1,NDataPoints);

t=0;

nx=xyzdims(1);
ny=xyzdims(2);
nz=xyzdims(3);

nt=round(dataInterval/simTstep);
simTstep=dataInterval/nt;

[T] = homogenousPerfusedPBHE( T0, alpha, kt, rho, Cp, c, accousticIntensity, nx,ny,nz, xyzresolution, nx,ny,nz, nt, simTstep, 0, bloodTemp, perfusionRate, freeOut );

t = t + dataInterval;


roiT = T(nt, ROI.x, ROI.y, ROI.z);
avgT = sum(roiT(:)) / (length(ROI.x)*length(ROI.y)*length(ROI.z) );
ti=1;
timearray(ti)=t;
temparray(ti)=avgT;

while (t < totalTime)

    [T] = homogenousPerfusedPBHE( T(nt,:,:,:), alpha, kt, rho, Cp, c, accousticIntensity, nx,ny,nz, xyzresolution, nx,ny,nz, nt, simTstep, 0, bloodTemp, perfusionRate, freeOut );

    t = t + dataInterval;
    
    roiT = T(nt, ROI.x, ROI.y, ROI.z);
    avgT = sum(roiT(:)) / length(roiT(:));
    
    ti=ti+1;
    timearray(ti)=t;
    temparray(ti)=avgT;
    
end

TfinalMap =  T(nt,:,:,:) ;

end

