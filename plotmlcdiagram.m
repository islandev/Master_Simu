x=0.6:0.1:8;
x=x(find(x>0));

y=psi(1,x);
z=psi(2,x);


plot(z,y);
hold on;
plot(-z,y);
