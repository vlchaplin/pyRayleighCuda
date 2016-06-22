function [ points ] = geom_ring( diam,n,z,rot )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dphi = 2.0*pi/n;
points = zeros(3,n);
phis = (0.0:dphi:2*pi-dphi) + rot;
r=diam/2.0;
points(1,:)=r*cos(phis);
points(2,:)=r*sin(phis);
points(3,:)=z;
end

