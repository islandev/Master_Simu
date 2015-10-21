clc;
clear all;



%%filePath = 'H:\����\StOfGibraltar_R2_FineQuad3_HH_VV_HV_VH_SLC\PK6626_DK340_FQ3_20080331_181047_HH_VV_HV_VH_SLC_(StOfGibraltar_Promo)\C3\';
%%filePath = 'C:\Users\Administrator\Desktop\data_polsar\ESAR_Oberpfaffenhofen\T3\';
filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\sea\C3\\';
row= 127;
col=127 ;
data = zeros(row,col,9);
bean=200;

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

spc11=spc1(find(spc1<2));
spc22=spc2(find(spc2<2));
spc33=spc3(find(spc3<2));

hist(spc1,bean);
outc2=hist(spc22,bean);
outc3=hist(spc33,bean);

outc1=outc1/sum(outc1)*bean;

outc2=outc2/sum(outc2)*bean;

outc3=outc3/sum(outc3)*bean;

x=0:2/bean:2;

x=x(find(x<2));

figure;


plot(x,outc1);
