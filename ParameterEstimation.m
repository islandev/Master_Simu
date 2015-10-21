<<<<<<< HEAD
function [ k,sigma,v ,cov_hh,cov_hv,cov_vv] = ParameterEstimation( filePath,row,col )
=======
function [ k,sigma,v ,covchh,covchv,covcvv] = ParameterEstimation( filePath,row,col )
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
%UNTITLED Summary of this function goes here
%输入：数据的位置 ，数据的行 列
%输出：H-wishart的参数 k d  v 乘性噪声的方差

d=3;
L=4;
data = zeros(row,col,9);
<<<<<<< HEAD
%从文件夹读取数据
=======

>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
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
<<<<<<< HEAD
%对矩阵进行构造
=======

>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
c11=data(:,:,1); %c11
c22=data(:,:,2); %c22
c33=data(:,:,3); %c33

c12=data(:,:,4)+i*data(:,:,7); %c12
<<<<<<< HEAD
c13=data(:,:,5)+1i*data(:,:,8); %c13
=======
c13=data(:,:,5)+i*data(:,:,8); %c13
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
c23=data(:,:,6)+i*data(:,:,9); %c23
c21=data(:,:,4)-i*data(:,:,7); %c12
c31=data(:,:,5)-i*data(:,:,8); %c13
c32=data(:,:,6)-i*data(:,:,9); %c23
num=row*col;
<<<<<<< HEAD
%求基于矩阵的对数累积量
=======

>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
m1=0;
m2=0;
m3=0;
for s=1:row
    for j=1:col
        z_matrix=[c11(s,j),c12(s,j),c13(s,j);c21(s,j),c22(s,j),c23(s,j);c31(s,j),c32(s,j),c33(s,j)];
       
        m1=log(det(z_matrix))+m1;
        m2=log(det(z_matrix))^2+m2;
        m3=log(det(z_matrix))^3+m3;
    end
end

m1=m1/num
m2=m2/num
m3=m3/num


<<<<<<< HEAD
=======
%d_matrix=[c11,zmatrxi,zmatrxi;zmatrxi,c22,zmatrxi;zmatrxi,zmatrxi,c33];
%detd=det(d_matrix)

% 
% m1=(log(det(c11))+log(det(c22))+log(det(c33)))/3;
% m2=(log(det(c11))^2+log(det(c22))^2+log(det(c33))^2)/3;
% m3=(log(det(c11))^3+log(det(c22))^3+log(det(c33))^3)/3;
% 



% c1 =real( m1)
% c2 =real( m2 - m1^2)
% c3 = real(m3 - 3*m1*m2 + 2*m1^3)
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9


c2 =real( m2 - m1^2)-sumpsi(d,L,1)
c3 = real(m3 - 3*m1*m2 + 2*m1^3)-sumpsi(d,L,2)


val_left=c2^3/c3^2


f=@(k)norm(psi(1,k).^3/psi(2,k).^2-val_left).^2;
[k,err]=fminsearch(f,0);

v=(psi(1,k)/c2).^0.5*d;
<<<<<<< HEAD
if c3<0
=======
if c3>0
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9
    v=-v;
end
sigma=gamma(k)/gamma(k+(1/v));


<<<<<<< HEAD
m1_s=0;
m2_s=0;
m3_s=0;
for p=1:row
    for q=1:col
        
       m1_s=m1_s+log(c11(p,q));
       m2_s=m2_s+log(c22(p,q));
       m3_s=m3_s+log(c33(p,q));
    end
end

m1_s=m1_s/num
m2_s=m2_s/num
m3_s=m3_s/num
cov_hh=1/sigma*L*exp(m1_s-psi(0,k)/v-psi(0,L))
cov_hv=1/sigma*L*exp(m2_s-psi(0,k)/v-psi(0,L))
cov_vv=1/sigma*L*exp(m3_s-psi(0,k)/v-psi(0,L))
=======


%calculate the covariance of the noise


%cov=(gamma(k+1/real(v))*exp(real(c1)-psi(1)-psi(k)/real(v)))/gamma(k);
chh=0;
chv=0;
cvv=0;

for p=1:row
    for q=1:col
        chh=log(c11(p,q))+chh;
        chv=log(c22(p,q))+chv;
        cvv=log(c33(p,q))+cvv;
    end
end
chh=chh/num;
chv=chv/num;
cvv=cvv/num;





%calculate the k-s distance

covhh=exp(c11-sumpis(d,L,0)-logL+log(sigma)-psi(0,k)/v)


>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9


end

