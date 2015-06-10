clc;

clear all;



filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\sea\C3\';
row= 127;

col=127 ;
% [k,sigma,v,covhh,covhv,covvv]=ParameterEstimation(filePath,row,col);
[k,sigma,v,cov]=ParameterEstimationhh(filePath,row,col);





    




