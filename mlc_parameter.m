clc;
clear all;




  
filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\C3\';
row=900;
col=1024;
[k,d,v,covhh,covhv,covvv]=ParameterEstimation(filePath,row,col);


[k_a,d_a,v_a]=mlcparameter(filePath,row,col);







