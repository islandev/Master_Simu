function [ pdfx ] = genralGamma( k,v,sigma )
%UNTITLED3 Summary of this function goes here

x=0:0.1:25;
for i=0:250
    y(i+1)=abs(v)*(x(i+1)/sigma)^(k*v-1)*exp(-(x(i+1)/sigma)^v)/(sigma*gamma(k));
end
plot(x,y);
pdfx=y;

end

