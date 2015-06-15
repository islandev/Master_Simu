function [ r_array ] = keyGen( c_array )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% r_array=zeros( 1,size(c_array,2));
step=3;

r_array=c_array;
val_sum=0;
for i=1:step
    val_sum=val_sum+c_array(i);
end

for i=1: size(c_array,2)-step
    r_array(i)=val_sum/step;
    val_sum=val_sum-c_array(i)+c_array(i+step)
end

end

