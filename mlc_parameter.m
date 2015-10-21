clear all;clc;

filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\sea\C3\';

row=127;
col=127 ;
%调用函数 求基于矩阵的对数累积量的参数
[k,sigma,v,covhh,covhv,covvv]=ParameterEstimation(filePath,row,col); %单通道
%[k,sigma,v,covhh]=ParameterEstimationhh(filePath,row,col); 



%[k,sigma,v]= mlcparameter( filePath,row,col ) %异质纹理

    




