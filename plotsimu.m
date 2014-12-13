clc
x=1:2;
y=psi(1,x).^3/psi(2,x).^2;
plot(x,y,'r'); 
plot(plot::Function2d(psi(1,x).^3/psi(2,x).^2),x=-1..1,XMesh=1000)):