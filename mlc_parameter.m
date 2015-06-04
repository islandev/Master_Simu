clc;
clear all;




  
filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\C3\';
row=900;
col=1024;
[k,sigma,v,covhh,covhv,covvv]=ParameterEstimation(filePath,row,col);










