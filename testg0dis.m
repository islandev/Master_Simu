
x=0:0.001:1
lamda=1.5;
c=0.004;
y=[];
L=2;
d=1;

for i=0:1000
    spa=L^(L*d)*x(i+1)^(L-d)*gamma(lamda+L*d)*(lamda-1)^lamda;
    spb=DPGamma(L,d)*c^L*gamma(lamda);
    spc=(L*x(i+1)/c+(lamda-1))^(-lamda-L*d);
    y(i+1)=spa*spc/spc;
        
end

plot(x,y);