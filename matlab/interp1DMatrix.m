function [ lin1Mat ] = interp1DMatrix( inX, Xq )
%interp1DMatrix Return a matrix equivalent to matlab's Yq=interp1( inX, inY, Xq,'linear', 0.0)
%   
%   Can provide a faster alternative to interp1() but with a higher memory
%   demand.  Perhaps useful if doing repeated interpolations, since it
%   doesn't make reference to the original Y values but computes a linear operator
%   valid for any Y.
%
%   Return matrix L is used like:   
%       L = interp1DMatrix( originalX, interpX );
%       interpY = L*originalY;
%
%   which is equivalent to:
%       interpY = interp1( originalX, originalY, interpX, 'linear', 0.0);
%
%--------------

IX = 1:length(inX);
fXq = interp1( inX, IX, Xq,'linear', 0.0);

N = length(inX);
M = length(Xq);
lin1Mat = zeros([M N]);


for m=1:M
   if fXq(m)<1.0
       continue
   end
   
   ii = floor(fXq(m));
   
   upperFraction = fXq(m) - ii;
   lowerFraction = 1.0 - upperFraction;
   lin1Mat(m,ii) = lowerFraction;
   
   if ii<length(oX)
       lin1Mat(m,ii+1) = upperFraction;
   end
end


end

