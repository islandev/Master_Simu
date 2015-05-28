clc;
clear all;
clear; clc;tic;
close all;



filePath = 'C:\Users\Administrator\Desktop\data_polsar\AIRSAR_SanFrancisco\C3\';
row=900;
col=1024;
data = zeros(row,col,9);
fIn = fopen([filePath 'C11.bin'],'r');
data(:,:,1) = fread(fIn,[col,row],'float').';     fclose(fIn);
% SarPowerHisteq(data(:,:,1));
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


c_data(:,:,1)=data(:,:,1); %c11
c_data(:,:,2)=data(:,:,2); %c22
c_data(:,:,3)=data(:,:,3); %c33

% c_data(:,:,4)=sqrt(data(:,:,4).^2+data(:,:,7).^2); %c12
% c_data(:,:,4)=sqrt(data(:,:,5).^2+data(:,:,8).^2); %c13
% c_data(:,:,4)=sqrt(data(:,:,6).^2+data(:,:,9).^2); %c23
% c_data(:,:,4)=sqrt(data(:,:,4).^2+data(:,:,7).^2); %c21
% c_data(:,:,4)=sqrt(data(:,:,5).^2+data(:,:,8).^2); %c31
% c_data(:,:,4)=sqrt(data(:,:,6).^2+data(:,:,9).^2); %c32


c_data(:,:,4)=data(:,:,4)+1i*data(:,:,7); %c12
c_data(:,:,5)=data(:,:,5)+1i*data(:,:,8); %c13
c_data(:,:,6)=data(:,:,6)+1i*data(:,:,9); %c23
c_data(:,:,7)=data(:,:,4)-1i*data(:,:,7); %c21
c_data(:,:,8)=data(:,:,5)-1i*data(:,:,8); %c31
c_data(:,:,9)=data(:,:,6)-1i*data(:,:,9); %c32
m1=0;
m2=0;
m3=0;
for i=1:9
    m1=log(det(c_data(:,:,i)))+m1;   
    m2=log(det(c_data(:,:,i)))^2+m2;
    m3=log(det(c_data(:,:,i)))^3+m3;
end
 m1=m1/9;
 m2=m2/9;
 m3=m3/9;
 
 



% Num = numel(x); 
% 
% m1 = sum(log(x))/Num;
% m2 = sum(log(x).^2)/Num;
% m3 = sum(log(x).^3)/Num;
c1 = m1;
c2 = m2 - m1^2;
c3 = m3 - 3*m1*m2 + 2*m1^3;

val_left=c2^3/c3^2;

% 
f=@(k)norm(psi(1,k).^3/psi(2,k).^2-val_left).^2;
[k,err]=fminsearch(f,1e-5);









