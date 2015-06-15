W=[2,3,4;5,5,2;6,7,8]
Sigma=[2,3,4;5,5,2;6,7,8]
v=1;

d = length(Sigma);
B = -0.5*v*logdet(W)-0.5*v*d*log(2)-logmvgamma(0.5*v,d);
y = B+0.5*(v-d-1)*logdet(Sigma)-0.5*trace(W\Sigma);

figure(1);
plot(x,y);