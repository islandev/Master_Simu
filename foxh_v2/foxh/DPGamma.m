function [ dpGamma ] = DPGamma( dim,L )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
dpGamma=pi^(dim*(dim-1)/2) ;
for i=0:dim-1
    dpGamma=dpGamma*gamma(L-i);
end

end

