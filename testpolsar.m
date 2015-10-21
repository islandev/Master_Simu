clc;
clear all;



%%filePath = 'H:\±œ…Ë\StOfGibraltar_R2_FineQuad3_HH_VV_HV_VH_SLC\PK6626_DK340_FQ3_20080331_181047_HH_VV_HV_VH_SLC_(StOfGibraltar_Promo)\C3\';
%%filePath = 'C:\Users\Administrator\Desktop\data_polsar\ESAR_Oberpfaffenhofen\T3\';
filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\ttttttttt\C3\';
% row= 97;
% col=105 ;



fIn = fopen([filePath 'C11.bin'],'r');
% data(:,:,1) = fread(fIn,[col,row],'float').';  
data(:,:) = fread(fIn,'float').'; 
fclose(fIn);

