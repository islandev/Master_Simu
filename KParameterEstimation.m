function [v,b] = KParameterEstimation( filePath,row,col )
%UNTITLED Summary of this function goes here
%输入：数据的位置 ，数据的行 列
%输出：H-wishart的参数 k d  v 乘性噪声的方差

d=3;
L=4;
data = zeros(row,col,9);

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

c12=data(:,:,4)+i*data(:,:,7); %c12
c13=data(:,:,5)+1i*data(:,:,8); %c13
c23=data(:,:,6)+i*data(:,:,9); %c23
c21=data(:,:,4)-i*data(:,:,7); %c12
c31=data(:,:,5)-i*data(:,:,8); %c13
c32=data(:,:,6)-i*data(:,:,9); %c23
num=row*col;

m1_hh=0;
m2_hh=0;
m1_hv=0;
m2_hv=0;
m1_vv=0;
m2_vv=0;
for s=1:row
    for j=1:col
        
        m1_hh=log(c11(s,j))+m1_hh;
        m1_hv=log(c22(s,j))+m1_hv;
        m1_vv=log(c33(s,j))+m1_vv;
    end
end

m1_hh=m1_hh/num

m1_hv=m1_hv/num
m1_vv=m1_vv/num


for s=1:row
    for j=1:col
        
        m2_hh=(log(c11(s,j))-m1_hh)^2+m2_hh;
        m2_hv=(log(c11(s,j))-m1_hv)^2+m2_hv;
        m2_vv=(log(c11(s,j))-m1_vv)^2+m2_vv;
    end
end

m2_hh=m2_hh/(num-1)

m2_hv=m2_hv/(num-1)
m2_vv=m2_vv/(num-1)
f_hh=@(v_hh)norm(psi(1,v_hh)/4+pi^2/24-m2_hh);
[v_hh,err_hh]=fminsearch(f_hh,0);
b_hh=exp(psi(v_hh)-2*m1_hh-0.5772);

f_hv=@(v_hv)norm(psi(1,v_hv)/4+pi^2/24-m2_hv);
[v_hv,err_hv]=fminsearch(f_hv,0);
b_hv=exp(psi(v_hv)-2*m1_hv-0.5772);

f_vv=@(v_vv)norm(psi(1,v_vv)/4+pi^2/24-m2_vv);

[v_vv,err_vv]=fminsearch(f_vv,0);
b_vv=exp(psi(v_vv)-2*m1_vv-0.5772);

v(1)=v_hh;
v(2)=v_hv;
v(3)=v_vv;
b(1)=b_hh;
b(2)=b_hv;
b(3)=b_vv;




end

