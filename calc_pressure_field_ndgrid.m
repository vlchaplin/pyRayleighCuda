function [ p0, near_field_mask ] = calc_pressure_field_ndgrid( kr, uamp, uxyz, simXp, simYp, simZp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[gx, gy, gz] = ndgrid( simXp, simYp, simZp );


N = size(uxyz,2);

integral_coeffs = uamp.*1i.*ones([1 N]);

simNx = length(simXp);
simNy = length(simYp);
simNz = length(simZp);

p0 = zeros([simNx, simNy, simNz]);

near_field_mask = zeros(size(p0));

for n=1:N
    
    d = sqrt( (uxyz(1,n)-gx).^2 + (uxyz(2,n)-gy).^2 + (uxyz(3,n)-gz).^2 );
    
    thisSource = integral_coeffs(n).*exp(-1i*kr.*(d))./d;
    
    p0 = thisSource+p0;

    near_field_mask( d < 0.01 ) = true;
    
end

end

