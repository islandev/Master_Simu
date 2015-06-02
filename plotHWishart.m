clc
clear all;
k=9.6960;
v=-0.9131;
cov=0.0172;
L=9;
dim=1;
d=gamma(k)/gamma(k+1/v);
res=1e-8;
x=0:0.01:10;
y=[];
if v<0;
    A={[1+(L*dim-k*v)/v;-1/v],[]};
    B={[0;-1/v,],[]};
    for i=0:1000;    
    pa=L^(L*dim)*d^((L*dim-k*v)/v);
    pb=d^(k*v)*gamma(k)*gamma(L-1);
    pc=power(x(i+1),L-dim)/cov^L;
    z=d*cov/(L*x(i+1));
    fox=foxh(z,B,A,res);
    y(i+1)=pa*pc*fox/pc;
    end

        
end

plot(x,y);