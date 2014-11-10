function [ mVin ] = h101_3p7MHz_kPa_to_mVin( measured_kPa )
% inverse of the linear calibration function-fit

calibration_kPa_per_mVoltIn = 10.2578; 


mVin = measured_kPa / calibration_kPa_per_mVoltIn;




end