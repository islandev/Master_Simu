clc;
clear all;
clear; clc;tic;
close all;



row =83;     col =83 ;     data = zeros(row,col,9);
filePath = 'C:\Users\Administrator\Desktop\polsardata\C3\';
%filePath = 'C:\Users\Administrator\Desktop\AIRSAR_SanFrancisco\C3\';
fIn = fopen([filePath 'C11.bin'],'r');
data(:,:,1) = fread(fIn,[col,row],'float').';     fclose(fIn);
fIn = fopen([filePath 'C22.bin'],'r');
data(:,:,2) = fread(fIn,[col,row],'float').';     fclose(fIn);
fIn = fopen([filePath 'C33.bin'],'r');
data(:,:,3) = fread(fIn,[col,row],'float').';     fclose(fIn);
fIn = fopen([filePath 'C12_real.bin'],'r');
data(:,:,4) = fread(fIn,[col,row],'float').';   fclose(fIn);
fIn = fopen([filePath 'C13_real.bin'],'r');
data(:,:,5) = fread(fIn,[col,row],'float').';   fclose(fIn);
fIn = fopen([filePath 'C23_real.bin'],'r');
data(:,:,6) = fread(fIn,[col,row],'float').';   fclose(fIn);
fIn = fopen([filePath 'C12_imag.bin'],'r');
data(:,:,7) = fread(fIn,[col,row],'float').';   fclose(fIn);
fIn = fopen([filePath 'C13_imag.bin'],'r');
data(:,:,8) = fread(fIn,[col,row],'float').';   fclose(fIn);
fIn = fopen([filePath 'C23_imag.bin'],'r');
data(:,:,9) = fread(fIn,[col,row],'float').';   fclose(fIn); 






