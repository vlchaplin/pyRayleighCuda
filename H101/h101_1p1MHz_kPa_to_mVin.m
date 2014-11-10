function [ mVin ] = h101_1p1MHz_kPa_to_mVin( measured_kPa )
% inverse of the linear calibration function-fit

calibration_kPa_per_mVoltIn = 24.9577; 


mVin = measured_kPa / calibration_kPa_per_mVoltIn;




end

