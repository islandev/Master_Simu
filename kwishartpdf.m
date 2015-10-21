function [ pdfk ] = kwishartpdf( sigma,c,L,d )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%sigma  is the shape parameter 
%L  the look of the sar img
% d  the dimision of the sar img




L=4;
d=1;
y=[];                      
j=1;
x=0:0.01:2
x=x(find(x>0))
for i=1:200
    spa=2*x(i)^(L-d)*(L*sigma)^((sigma+L*d)/2)
    spb=c^L*gamma(sigma)*gamma(L)
    spc=(x(i)/c)^((sigma-L*d)/2)
    spd=besselk(sigma-L*d,2*((sigma*L*x(i)/c)^0.5));
    y(i)=spa*spc*spd/spb;
   
end
y(1)=0


pdfk=y;




end

