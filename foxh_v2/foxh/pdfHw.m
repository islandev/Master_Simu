clc
clear all;
k=3.52;
v=1.12;
cov=0.0130;
L=1;
dim=1;
d=gamma(k)/gamma(k+1/v);
res=1e-8;
x=0:0.001:1
y=[];
foxp=[];
if v<0;
    A={[1+(L*dim-k*v)/v;-1/v],[]};
    B={[0;-1/v],[]};
    for i=0:1000;    
    pa=L^(L*dim)*d^((L*dim-k*v)/v);
    pb=d^(k*v)*gamma(k)*DPGamma(dim,L);
    pc=power(x(i+1),L-dim)/cov^L;
    z=d*cov/(L*x(i+1));
    fox=foxh(z,B,A,res);
    foxp(i+1)=fox;
    y(i+1)=pa*pc*fox/pb;
    end
else if v>0
    A={[],[]};
    B={[0,L*dim-k*v;1/v,1],[]};
    
    for j=0:1000;
        pa=L^(L*dim)*power((L*x(j+1)/cov),(k*v-L*dim));
        pb=d^(k*v)*gamma(k)*DPGamma(dim,L);
        pc=(x(j+1)^(L-dim))/(cov^L);
        z=L*x(j+1)/(cov*d);
        fox=foxh(z,B,A,res);
        foxp(j+1)=fox;
        y(j+1)=pa*pc*fox/pb;
    end        
    end
end



axis([0 1 0 3e12]);

hold on;

 plot(1-x,y,'k:') 
