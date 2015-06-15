function [ val ] = DPGamma( dim,L )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
val=pi^(dim*(dim-1)/2) ;
for i=0:dim-1
    val=val*gamma(L-i);
end

end

