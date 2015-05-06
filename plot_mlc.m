k= 9.1106;
v= 0.1249;
x1=(0:1:4);

y1=[];

for i=1:5
   y1(i)=psi(x1(i),k)/v^x1(i);
   
end
%plot(x1,y1);



rectangle('Position',[100,100,10,10],'Curvature',[1,1],  'FaceColor','r')