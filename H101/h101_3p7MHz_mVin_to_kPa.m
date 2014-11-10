function [ predicted_kPa ] = h101_3p7MHz_mVin_to_kPa( mVin )
% The linear calibration function-fit

calibration_kPa_per_mVoltIn = 10.2578; 


predicted_kPa = calibration_kPa_per_mVoltIn * mVin;




end

