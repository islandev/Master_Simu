x=0.6:0.1:8;
x=x(find(x>0));

z=psi(1,x);
y=psi(2,x);

plot(y,z);
hold on;

plot(-y,z);

hold on;
