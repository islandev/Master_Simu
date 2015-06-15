clc
clear all;
k=   3.5216;
v= 1.1213;
cov=0.016;
L=4;
d=1;
sigma= 0.3294;
res=1e-15;
x=0:0.001:1;
y=[];
foxp=[];   
if v<0;
    A={[1+(L*d-k*v)/v;-1/v],[]};
    B={[0;-1/v],[]};
 
    
    for i=0:1000;    
    pa=L^L*sigma^((L*d-k*v)/v)*x(i+1)^(L-1);
    pb=sigma^(k*v)*gamma(k)*gamma(L)*cov^L;
    z=sigma*cov/(x(i+1)*L);
     fox=foxh(z,B,A,res)
     y(i+1)=pa*fox/pb;
   
    end
else if v>0
    A={[],[]};
    B={[0,L*d-k*v;1/v,1],[]};
    
    for j=0:1000;
        pa=L^L*(x(j+1)^(L-1))*(L*x(j+1)/cov)^(k*v-L*d);
        pb=(sigma^(k*v))*gamma(k)*gamma(L)*cov^L;
        z=L*x(j+1)/(cov*sigma)
        fox=foxh(z,B,A,res)
        foxp(j+1)=fox;
        y(j+1)=pa*fox/pb;
    end
       
    end        
end



yp=datatransfer(y);
plot(x,y,'r');
