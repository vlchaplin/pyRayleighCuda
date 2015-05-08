function [ bhe ] = homogenous_fit_variables2bhe( X, bhe, vin2pascals )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

bhe.kt = X(1) *(bhe.rho*bhe.Cp);
bhe.alpha = X(2)*(bhe.rho^2*bhe.Cp*bhe.c) / ( vin2pascals^2 );
bhe.perfusionRate = X(3)*(bhe.rho*bhe.Cp) / (bhe.rhoBlood*bhe.CpBlood);

end