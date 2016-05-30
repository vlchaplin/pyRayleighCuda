function [ deltaT, L ] = NyborgHeating( r, t, Cv, rho, ktherm, w_perfusionRate )
%function [ deltaT, L ] = NyborgHeating( r, t, Cv, rho, ktherm, w_perfusionRate )
%   Multiply deltaT result by (alpha*I) [combined unit of W/m^3] to convert to degrees C.
%   L is the perfusion length
%
% Typical input vals:
% Cv = 4100; J/kg*C
% rho = 1040; kg/m^3
% ktherm = 0.5; 
% w_perfusionRate = 0.002; 

kappa = ktherm / (rho*Cv);
tau = 1/w_perfusionRate;

K = Cv*kappa;
L = sqrt(kappa*tau);

dv=1;
qvdot_wattsPerVolume = 1/dv;
C = qvdot_wattsPerVolume*dv/(8*pi*K);

tstar = sqrt(t/tau);
R = r/sqrt(4*kappa*t);
deltaT = (C./r).*( exp(-r/L).*(2 - erfc(tstar - R)) + exp(r/L).*erfc(tstar + R) );

end

