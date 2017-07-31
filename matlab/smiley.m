function [ points ] = smiley( diam,n,z )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dphi = 0.5*pi/n;
points = zeros(3,n+2);
width=0.5*pi;
phis = linspace(0,width,n) + -width/2;
r=.9*diam/2.0;
points(1,1:n)=r*cos(phis);
points(2,1:n)=r*sin(phis);
points(3,1:n)=z;

rad=diam/2.0;
points(:,n+1)=[-rad/3.0 rad/2.0 z];
points(:,n+2)=[-rad/3.0 -rad/2.0 z];
end

