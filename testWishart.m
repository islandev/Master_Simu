
sigma= 2.7306;
L=4;
d=1;
y=[];
j=1;
c=0.016;
x=0:0.001:1
for i=0:1000
    spa=2*x(i+1)^(L-d)*(L*sigma)^((sigma+L*d)/2);
    spb=c^L*gamma(sigma)*gamma(L);
    spc=(x(i+1)/c)^((sigma-L*d)/2);
    spd=besselk(sigma-L*d,2*(sigma*L*x(i+1)/c)^0.5);
    y(i+1)=spa*spc*spd/spb;
   
end

plot(x,y);

