function [ k,sigma,v ,covhh] = ParameterEstimationhh( filePath,row,col )
%UNTITLED Summary of this function goes here
%输入：数据的位置 ，数据的行 列
%输出：H-wishart的参数 k d  v 乘性噪声的方差

d=1;
L=4;
data = zeros(row,col);

fIn = fopen([filePath 'C11.bin'],'r');
data(:,:) = fread(fIn,[col,row],'float').';     fclose(fIn);
num=row*col;

c11=data;
tmp=reshape(c11,num,1);
var_1=std(tmp).^2


m1=ones(1,row)*log(c11)*ones(col,1)./num;
m2=ones(1,row)*(log(c11).^2)*ones(col,1)./num;
m3=ones(1,row)*(log(c11).^3)*ones(col,1)./num;


c2 =(m2 - m1^2)-sumpsi(d,L,1);
c3 =(m3 - 3*m1*m2 + 2*m1^3)-sumpsi(d,L,2);


val_left=c2^3/c3^2


f=@(x) (psi(1,x).^3/psi(2,x).^2-val_left)^2;
[x,err]=fminsearch(f,0);
f(x)
k=x
err
v=(psi(2,k)/c3).^(1/3)*d

sigma=gamma(k)/gamma(k+(1/v))
sigma_1=exp(m1-sumpsi(d,L,0)-log(var_1)+d*log(L)-psi(0,k)/v)
covhh=exp(m1-sumpsi(d,L,0)+log(L)-log(sigma)-psi(0,k)/v);




%calculate the k-s distance






end



