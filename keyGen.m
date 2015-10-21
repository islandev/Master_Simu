function [ r_array ] = keyGen( c_array )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% r_array=zeros( 1,size(c_array,2));
<<<<<<< HEAD
step=3;
=======
step=10;
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9

r_array=c_array;
val_sum=0;
for i=1:step
    val_sum=val_sum+c_array(i);
end

for i=1: size(c_array,2)-step
<<<<<<< HEAD
    r_array(i)=val_sum/step;
    val_sum=val_sum-c_array(i)+c_array(i+step);
end
r_array(1)=0;
=======
    r_array(i+step)=val_sum/step;
    val_sum=val_sum-c_array(i)+c_array(i+step)
end

>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
end

