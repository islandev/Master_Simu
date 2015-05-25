clc;
clear all;




  
filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\A\C3\';
row=161;
col=161;
[k,d,v,covhh,covhv,covvv,ksd_hh,ksd_hv,ksd_vv]=ParameterEstimation(filePath,row,col);




