function [ k,sigma,v ,covhh] = ParameterEstimationhh( filePath,row,col )
%UNTITLED Summary of this function goes here

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
=======
data = zeros(row,col,9);

fIn = fopen([filePath 'C11.bin'],'r');
data(:,:,1) = fread(fIn,[col,row],'float').';     fclose(fIn);
% fIn = fopen([filePath 'C22.bin'],'r');
% data(:,:,2) = fread(fIn,[col,row],'float').';     fclose(fIn);
% fIn = fopen([filePath 'C33.bin'],'r');
% data(:,:,3) = fread(fIn,[col,row],'float').';     fclose(fIn);
% fIn = fopen([filePath 'C12_real.bin'],'r');
% data(:,:,4) = fread(fIn,[col,row],'float').';   fclose(fIn);
% fIn = fopen([filePath 'C13_real.bin'],'r');
% data(:,:,5) = fread(fIn,[col,row],'float').';   fclose(fIn);
% fIn = fopen([filePath 'C23_real.bin'],'r');
% data(:,:,6) = fread(fIn,[col,row],'float').';   fclose(fIn);
% fIn = fopen([filePath 'C12_imag.bin'],'r');
% data(:,:,7) = fread(fIn,[col,row],'float').';   fclose(fIn);
% fIn = fopen([filePath 'C13_imag.bin'],'r');
% data(:,:,8) = fread(fIn,[col,row],'float').';   fclose(fIn);
% fIn = fopen([filePath 'C23_imag.bin'],'r');
% data(:,:,9) = fread(fIn,[col,row],'float').';   fclose(fIn);

c11=data(:,:,1); %c11
% c22=data(:,:,2); %c22
% c33=data(:,:,3); %c33
%
% c12=data(:,:,4)+i*data(:,:,7); %c12
% c13=data(:,:,5)+i*data(:,:,8); %c13
% c23=data(:,:,6)+i*data(:,:,9); %c23
% c21=data(:,:,4)-i*data(:,:,7); %c12
% c31=data(:,:,5)-i*data(:,:,8); %c13
% c32=data(:,:,6)-i*data(:,:,9); %c23
num=row*col;

m1=0;
m2=0;
m3=0;
for s=1:row
    for j=1:col


        m1=log(c11(s,j))+m1;
        m2=log(c11(s,j))^2+m2;
        m3=log(c11(s,j))^3+m3;
    end
end

m1=m1/num
m2=m2/num
m3=m3/num


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


c2 =real( m2 - m1^2)-sumpsi(d,L,1)
c3 = real(m3 - 3*m1*m2 + 2*m1^3)-sumpsi(d,L,2)
>>>>>>> c6aeb1a21731875e96727aeb0dcad5739ec869c9


val_left=c2^3/c3^2


<<<<<<< HEAD
f=@(x) (psi(1,x).^3/psi(2,x).^2-val_left)^2;
[x,err]=fminsearch(f,0);
f(x)
k=x
err
v=(psi(2,k)/c3).^(1/3)*d

sigma=gamma(k)/gamma(k+(1/v))
sigma_1=exp(m1-sumpsi(d,L,0)-log(var_1)+d*log(L)-psi(0,k)/v)
=======
f=@(k)norm(psi(1,k).^3/psi(2,k).^2-val_left).^2;
[k,err]=fminsearch(f,0);
k
err
v=(psi(2,k)/c3).^(1/3)*d;

sigma=gamma(k)/gamma(k+(1/v));




%calculate the covariance of the noise


% %cov=(gamma(k+1/real(v))*exp(real(c1)-psi(1)-psi(k)/real(v)))/gamma(k);
% chh=0;
% chv=0;
% cvv=0;
%
% for p=1:row
%     for q=1:col
%         chh=log(c11(p,q))+chh;
%         chv=log(c22(p,q))+chv;
%         cvv=log(c33(p,q))+cvv;
%     end
% end
% chh=chh/num;
% chv=chv/num;
% cvv=cvv/num;



covhh=exp(m1-sumpsi(d,L,0)+log(L)-log(sigma)-psi(0,k)/v);




%calculate the k-s distance






end
