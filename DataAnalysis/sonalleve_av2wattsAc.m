function [ W ] = sonalleve_av2wattsAc( av )
%sonalleve_av2wattsAc 2nd order polynomial fit to calibration data

%1.2MHz
coeff = [0 0.0675 0.0001];

W = coeff(1) + coeff(2).*av + coeff(3).*(av.^2);

end

