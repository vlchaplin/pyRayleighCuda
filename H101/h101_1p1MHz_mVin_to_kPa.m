function [ predicted_kPa ] = h101_1p1MHz_mVin_to_kPa( mVin )
% The linear calibration function-fit

calibration_kPa_per_mVoltIn = 24.9577; 


predicted_kPa = calibration_kPa_per_mVoltIn * mVin;




end

