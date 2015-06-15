clc;
clear all;
L=4;
d=1;
z=0:0.01:1;
k=3.5216;
v=1.1213;
cov=0.016;
sigma=gamma(k)/gamma(k+1/v);
intfy=[];
for i=0:100
pa=abs(v)*L^(L*d)*z(i+1)^(L-d);
pb=sigma^(k*v)*gamma(k)*gamma(L)*cov^L;

res=1e-30;
step=1e-3;
temp=1;
y=0;
cur_val=0;
x=0;



while (temp>res)
    x=x+step;
    temp=x^(k*v-L*d-1)*exp(-L*x/(cov*z(i+1)))*exp(-x^v/sigma^v)*step
    y=y+temp;
    
end
intfy(i+1)=y*pa/pb;

end



plot(z,intfy);