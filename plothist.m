clc;
clear all;



filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\C3\';
row=900;
col=1024;
data = zeros(row,col,9);
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


c11=data(:,:,1); %c11
c22=data(:,:,2); %c22
c33=data(:,:,3); %c33


spc1=reshape(c11,row*col,1);
spc2=reshape(c22,row*col,1);
spc3=reshape(c33,row*col,1);

spc11=spc1(find(spc1<1));
spc22=spc2(find(spc2<1));
spc33=spc3(find(spc3<1));

outc1=hist(spc11,1000);
outc2=hist(spc22,1000);
outc3=hist(spc33,1000);

outc1=outc1/sum(outc1);

outc2=outc2/sum(outc2);

outc3=outc3/sum(outc3);

x=0:0.001:1;

x=x(find(x<1));

figure;
plot(x,outc1);

figure;
plot(x,outc2);

figure;
plot(x,outc3);



