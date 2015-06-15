function [ val ] = sumpsi( d,L,p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

val=0;
for i=0:d-1
    val=psi(p,L-i)+val;

end

end

