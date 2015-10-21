x=0.6:0.1:8;

y=psi(1,x);
z=psi(2,x);

plot(z,y);
hold on;
plot(-z,y);


hold on;
k=0.6:0.1:8;
yt=psi(2,k);
xt=sqrt(psi(1,k));
plot(yt,xt)
hold on;
plot(-yt,xt)
xlabel('k3{C}'); %标记横坐标
ylabel('k2{C}'); %标记纵坐标


scatter(0.1416,2.2929)
text(0.1416,2.2929,'SanF sea')

scatter(0.2578,4.5104)
text(0.2578,4.5104,'SanF urban')

scatter(-2.6028,4.9008)
text(-2.6028,4.9008,'SanF vege')