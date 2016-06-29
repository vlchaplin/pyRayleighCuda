 C = importdata('C:\Users\vchaplin\Downloads\Passive cavitation\CAST-CAST_0366_skull_section.txt', '\t');
 dx = 35e-6;
 dy = 35e-6;
 
 ii = find(C < 7000.0);
 
 CH = C;
 CH(ii) = 0;