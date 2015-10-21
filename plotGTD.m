sigma1=2;
sigma2=4;
sigma3=8;

k=2;
v=2;

[y1]=genralGamma(k,v,sigma1);

[y2]=genralGamma(k,v,sigma2);

[y3]=genralGamma(k,v,sigma3);
x=0:0.1:25;
plot(x,y1,'r*');
hold on;
plot(x,y2,'b-')
hold on;
plot(x,y3,'k');

xlabel('x'); %标记横坐标
ylabel('f(x)'); %标记纵坐标
legend('sigma=2 ','sigma=4','sigma=8')
