clc
clear all;
k= 13.3872;
v= 0.1871;
cov=0.1850;
L=9;
dim=1;
sigma=gamma(k)/gamma(k+1/v);
res=1e-8;
x=0:0.001:1;
y=[];
foxp=[];
if v<0;
    A={[1+(L*dim-k*v)/v;-1/v],[]};
    B={[0;-1/v],[]};
    for i=0:1000;    
    pa=L^(L*dim)*sigma^((L*dim-k*v)/v);
    pb=sigma^(k*v)*gamma(k)*DPGamma(dim,L);
    pc=power(x(i+1),L-dim)/cov^L;
    z=sigma*cov/(L*x(i+1));
    fox=foxh(z,B,A,res);
    foxp(i+1)=fox;
    y(i+1)=pa*pc*fox/pb;
    end
else if v>0
    A={[],[]};
    B={[0,L*dim-k*v;1/v,1],[]};
    
    for j=0:1000;
        pa=L^(L*dim)*power((L*x(j+1)/cov),(k*v-L*dim));
        pb=sigma^(k*v)*gamma(k)*DPGamma(dim,L);
        pc=(x(j+1)^(L-dim))/(cov^L);
        z=L*x(j+1)/(cov*sigma);
        fox=foxh(z,B,A,res);
        foxp(j+1)=fox;
        y(j+1)=pa*pc*fox/pb;
    end        
    end
end



yp=datatransfer(y);
plot(x,y);
