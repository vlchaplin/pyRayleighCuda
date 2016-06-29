function [ value, interpolatedLowPoint, interpolatedHiPoint ] = calc_fwhm_1d( X, Y, pp_mode, quantile )
%calc_fwhm_1d  Return fwhm and its lower and upper bound.
%   [ value, interpolatedLowPoint, interpolatedHiPoint ] = calc_fwhm_1d( X, Y )
%   [ value, interpolatedLowPoint, interpolatedHiPoint ] = calc_fwhm_1d( X, Y, pp_mode, value )
%   Set pp_mode to 1 to find the peak-to-peak FWHM instead of the absolute.

    if ~exist('pp_mode','var')
       pp_mode=0;
    end
    
    if ~exist('quantile','var')
       quantile=0.5;
    end

    if pp_mode
        Y = Y - min(Y(:));
    end
    
    [Ymax,maxj] = max(Y(:));

    ratio = Y/Ymax;
    for j=maxj:-1:1
        
        if ratio(j) <= quantile
            lowindex=j;
            break;
        end
    end
    
    x1 = X(lowindex);   f1 = Y(lowindex)  / Ymax;
    x2 = X(lowindex+1); f2 = Y(lowindex+1) / Ymax;
    interpolatedLowPoint = x1 + (quantile - f1)*(x2-x1) / (f2-f1);
        
    for j=maxj:length(X)
        
        if ratio(j) <= quantile
            hiindex=j;
            break;
        end
    end
    
    
    x1 = X(hiindex-1);  f1 = Y(hiindex-1) / Ymax;
    x2 = X(hiindex);    f2 = Y(hiindex) / Ymax;
    interpolatedHiPoint = x1 + (quantile - f1)*(x2-x1) / (f2-f1);
    
    
    value = interpolatedHiPoint - interpolatedLowPoint;
    
end

