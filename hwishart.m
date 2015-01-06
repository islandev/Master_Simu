%H-wishart probability distribution function
%概率密度函数曲线

clear all
clc


%%%%%
kappa=1;


axis([0 12 0 0.6]);


m=1;

while m<=3
    p_i=@(i,k,g,v)
