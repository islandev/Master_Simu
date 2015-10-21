x=0.6:0.1:8;

y=psi(1,x);
z=psi(2,x);

plot(z,y,'r');
hold on;
plot(-z,y,'b');


hold on;
k=0.6:0.1:8;
yt=psi(2,k);
xt=sqrt(psi(1,k));
plot(yt,xt,'k')
hold on;
plot(-yt,xt,'k')
xlabel('三阶对数累积量'); %标记横坐标
ylabel('二阶对数累积量'); %标记纵坐标
legend('K-Wisahrt分布','G-Wishart分布','H-Wishart分布')

scatter(0.1416,2.2929)
text(0.1416,2.2929,'Obe-veg')

scatter(0.2578,4.5104)
text(0.2578,4.5104,'San-urban')

scatter(-2.6028,3.7008)
text(-2.8028,3.7008,'San-vege')

scatter(-2.23,3.42)
text(-2.23,3.42,'Obe-urban')

scatter(-3.72,2.13)
text(-3.72,2.13,'San-sea')


scatter(0.72,1.93)
text(0.72,1.93,'Obe-veg')

