function [ uxyz,nn ] = new_stipled_sherecap( radius, capDiam, voidDiam, nn )
%new_stipled_sherecap  get an array no larger than nn of uniformly spaced
%points
%   

nr=0;
nk=0;
nb=0;
while(nk < nn)
    nr=nr+1;
    nb=nk;
    nk= nr+ sum( floor((2.0*pi)*(0:nr-1)) );
end

nn=nb;
mintheta = asin( (voidDiam/2.0)/radius );
maxtheta = asin( (capDiam/2.0)/radius);
dth = (maxtheta - mintheta)/(nr-1);
nphi = floor( (0:nr-1)*2.0*pi );
if voidDiam <= 0.0
    nphi = nphi+1;
end

nn = sum(nphi);
uxyz = zeros([3 nn]);
n=1;
for i=1:nr
   theta=(i-1)*dth + mintheta;
   dphi=2*pi/nphi(i);
   for j=0:nphi(i)-1
      phi = dphi*j;
      uxyz(:,n) = radius*([sin(theta)*cos(phi) sin(theta)*sin(phi) 1-cos(theta)]);
      n=n+1;
   end
end




end

