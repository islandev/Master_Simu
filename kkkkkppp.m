b=0.5;
v=1;
x=0:0.01:10;

for i=0:1000
y(i+1)=(4*b)^((v+1)/2)*x(i+1)^v*besselk(v-1,2*x(i+1)*sqrt(b))/gamma(v);
end

plot(x,y)


