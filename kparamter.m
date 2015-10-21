function [ k ,v] = kparamter( filePath,row,col )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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

m1=real(m1/num)
m2=real(m2/num)
m3=real(m3/num)


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


c2 =real( m2 - m1^2);







f=@(k)norm(d^2*psi(1,k)-c2-sumpsi(d,L,1)).^2;
[k,err]=fminsearch(f,0);


err


%calculate the covariance of the noise
v=exp(real(m1)+log(k)+d*log(L)-psi(0,k)-sumpsi(d,L,0));

%cov=(gamma(k+1/real(v))*exp(real(c1)-psi(1)-psi(k)/real(v)))/gamma(k);



end

