sigma=2;
v=1;
k1=2;
k2=4;
k3=6;
[y1]=genralGamma(k1,v,sigma);

[y2]=genralGamma(k2,v,sigma);

[y3]=genralGamma(k3,v,sigma);
x=0:0.1:25;
plot(x,y1,'r*');
hold on;
plot(x,y2,'b-')
hold on;
plot(x,y3,'k');

xlabel('x'); %标记横坐标
ylabel('f(x)'); %标记纵坐标
legend('k=2 ','k=4','k=6')
