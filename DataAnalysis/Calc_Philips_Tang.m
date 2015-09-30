function [ Tang ] = Calc_Philips_Tang( angles )
%Calc_Philips_Tang( angulation ), where angulation = [ap, fh, rl] in degrees. 
%   Tang Converts L'P'H' -> LPH.. though document states it the other way

ap = angles(1);
fh = angles(2);
rl = angles(3);
%calculate Tang given angulation abt. each axis (in degrees)
Trl = [ 1 0 0; 0 cosd(rl) -sind(rl); 0 sind(rl) cosd(rl)];
Tap = [cosd(ap) 0 sind(ap);0 1 0;-sind(ap) 0 cosd(ap)];
Tfh = [cosd(fh) -sind(fh) 0;sind(fh) cosd(fh) 0;0 0 1];

Tang = Trl*Tap*Tfh;
end

