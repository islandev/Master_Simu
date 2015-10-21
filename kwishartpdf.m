<<<<<<< HEAD
function [ pdfk ] = kwishartpdf( sigma,c,L,d )
=======
function [ pdf ] = kwishartpdf( sigma,L,d )
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%sigma  is the shape parameter 
%L  the look of the sar img
% d  the dimision of the sar img


<<<<<<< HEAD


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
=======
sigma= 2.7306;
L=1;
d=1;
c=0.0040;
y=[];
j=1;
x=0:0.001:1
for i=0:1000
    spa=2*x(i+1)^(L-d)*(L*sigma)^((sigma+L*d)/2)
    spb=c^L*gamma(sigma)*gamma(L)
    spc=(x(i+1)/c)^((sigma-L*d)/2)
    spd=besselk(sigma-L*d,2*(sigma*L*x(i+1)/c)^0.5)
    y(i+1)=spa*spc*spd/spb;
   
end

plot(x,y)
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9




end

