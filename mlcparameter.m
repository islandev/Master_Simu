function [  k_array,d_array,v_array  ] = mlcparameter( filePath,row,col )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
c13=data(:,:,5)+i*data(:,:,8); %c13
c23=data(:,:,6)+i*data(:,:,9); %c23
c21=data(:,:,4)-i*data(:,:,7); %c12
c31=data(:,:,5)-i*data(:,:,8); %c13
c32=data(:,:,6)-i*data(:,:,9); %c23
num=row*col;
m1_x=0;
m2_x=0;
m3_x=0;
m1_co=0;
m2_co=0;
m3_co=0;
for s=1:row
    for j=1:col
        z_matrix=[c11(s,j),c12(s,j),c13(s,j);c21(s,j),c22(s,j),c23(s,j);c31(s,j),c32(s,j),c33(s,j)];
        c_matrix=[c11(s,j),0,0;0,c22(s,j),0;0,0,c33(s,j)];
        m1_co=log(det(c_matrix))+m1_co;
        m2_co=log(det(c_matrix))^2+m2_co;
        m3_co=log(det(c_matrix))^3+m3_co;
        m1_x=log(det(z_matrix))-log(det(c_matrix))+m1_x;
        m2_x=log(det(z_matrix)-det(c_matrix))^2+m2_x;
        m3_x=log(det(z_matrix)-det(c_matrix))^3+m3_x;
    end
end

m1_x=m1_x/num
m2_x=m2_x/num
m3_x=m3_x/num




%d_matrix=[c11,zmatrxi,zmatrxi;zmatrxi,c22,zmatrxi;zmatrxi,zmatrxi,c33];
%detd=det(d_matrix)

% 
% m1=(log(det(c11))+log(det(c22))+log(det(c33)))/3;
% m2=(log(det(c11))^2+log(det(c22))^2+log(det(c33))^2)/3;
% m3=(log(det(c11))^3+log(det(c22))^3+log(det(c33))^3)/3;
% 



c1 =real( m1_x)
c2 =real( m2_x - m1_x^2)
c3 = real(m3_x - 3*m1_x*m2_x + 2*m1_x^3)





val_left=c2^3/c3^2;



f=@(k)norm(psi(1,k).^3/psi(2,k).^2-val_left).^2;
[k,err]=fminsearch(f,0);

v=(psi(1,k)/c2).^0.5;
if c3<0
    v=-v;
end
d=exp(real(c1)-psi(0,k)/real(v));




%calculate the covariance of the noise


%up_stat=(gamma(k+1/real(v))*exp(real(c1)-psi(1)-psi(k)/real(v)))/gamma(k);



m1_co=m1_co/num
m2_co=m2_co/num
m3_co=m3_co/num


c1_co =real( m1_co)
c2_co =real( m2_co- m1_co^2)
c3_co = real(m3_co - 3*m1_co*m2_co + 2*m1_co^3)



val_left_co =c2_co ^3/c3_co^2;



f_co =@(k_co )norm(psi(1,k_co ).^3/psi(2,k_co ).^2-val_left_co ).^2;
[k_co ,err_co ]=fminsearch(f_co ,0);

v_co =(psi(1,k_co )/c2).^0.5;
if c3_co<0
    v_co=-v_co;
end
d_co =exp(real(c1_co )-psi(0,k_co )/real(v_co ));


k_array(1)=k;
k_array(2)=k_co;

d_array(1)=d;
d_array(2)=d_co;

v_array(1)=v;
v_array(2)=v_co;

end

