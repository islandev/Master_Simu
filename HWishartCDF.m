function [ cdf ] = HWishartCDF( k,v,d,z ,c)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 gac=gammainc(L,L*T*z/d*c,'upper') ;
 
bga=power(x,(-k*v-1));
aga=exxp(power(-x,-p));

cdf1=int(gac*bga*aga,x);

spa=abs(k)/(gamma(L)*gama(v))
cdf=1-spa*cdf1;
end

