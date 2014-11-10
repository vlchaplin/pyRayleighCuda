function [ ampvals, phase ] = complex2int_amp_ang( z, minscaledampchannel, maxscaledampchannel )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

amplitude=abs(z);
phase = 180.0/pi .* angle(z);
phase = floor(mod(phase + 360, 360));

ampvals = minscaledampchannel+floor(( (amplitude-min(amplitude))*(maxscaledampchannel-minscaledampchannel)/(max(amplitude)-min(amplitude))) );



end

