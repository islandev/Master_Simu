function [ yf ] = datatransfer( yp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
yf=zeros(1,size(yp,2));

for i=1:1001
    
yf(i)=yp(1001-i+1);
    
end
 for j=1:1001
     if(yf(j)<=0.02)
         yf(j)=abs(yf(j))+1/j;
     end
     
 end

end

