function [ u_pos ] = get_sonalleve_transducers_xyz( file )

%this file has the focal axis along x, so rotate the coords

if ~exist('file','var')
    file='C:\\Users\\vchaplin\\Documents\\HiFU\\multifocus\\SonalleveCoords.txt';
end

R = rotmatZYZ(0, pi/2, 0);
    
u_pos = read_sonalleve_xml(file);

N = size(u_pos,2);

for n=1:N
   u_pos(:,n) =  R*u_pos(:,n) ;
end

end

