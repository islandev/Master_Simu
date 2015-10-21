function [  k_array,sigma_a,v_array  ] = mlcparameter( filePath,row,col )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
data = zeros(row,col,9);
d=3;
L=9;
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
       m1_x=(log(c11(s,j))+log(c33(s,j)))/2+m1_x;
       m2_x=((log(c11(s,j)))^2+(log(c33(s,j)))^2)/2+m2_x;
       m3_x=((log(c11(s,j)))^3+(log(c33(s,j)))^3)/2+m3_x;
       m1_co=log(c22(s,j))+m1_co;
       m2_co=(log(c22(s,j)))^2+m2_co;
       m3_co=(log(c22(s,j))^3)+m3_co;
    end
end

m1_x=m1_x/num
m2_x=m2_x/num
m3_x=m3_x/num

m1_co=m1_co/num
m2_co=m2_co/num
m3_co=m3_co/num


%d_matrix=[c11,zmatrxi,zmatrxi;zmatrxi,c22,zmatrxi;zmatrxi,zmatrxi,c33];
%detd=det(d_matrix)

% 
% m1=(log(det(c11))+log(det(c22))+log(det(c33)))/3;
% m2=(log(det(c11))^2+log(det(c22))^2+log(det(c33))^2)/3;
% m3=(log(det(c11))^3+log(det(c22))^3+log(det(c33))^3)/3;
% 



c1_x =real( m1_x);
c2_x =real( m2_x - m1_x^2)-sumpsi(d,L,1);
c3_x = real(m3_x - 3*m1_x*m2_x + 2*m1_x^3)-sumpsi(d,L,2);






c1_co =real( m1_co);
c2_co =real( m2_co- m1_co^2)-sumpsi(d,L,1);
c3_co = real(m3_co - 3*m1_co*m2_co + 2*m1_co^3)-sumpsi(d,L,2);



val_left_co =c2_co ^3/c3_co^2;



f_co =@(k_co )norm(psi(1,k_co ).^3/psi(2,k_co ).^2-val_left_co ).^2;
[k_co ,err_co ]=fminsearch(f_co ,0);

v_co =(psi(1,k_co )/c2_co).^0.5*d;
if c3_co<0
    v_co=-v_co;
end
sigma_co =exp(real(c1_co )-psi(0,k_co )/real(v_co ));


val_left_x =c2_x ^3/c3_x^2;



f_x =@(k_x )norm(psi(1,k_x ).^3/psi(2,k_x ).^2-val_left_x ).^2;
[k_x ,err_x ]=fminsearch(f_x ,0);

v_x =(psi(1,k_x )/c2_x).^0.5*d;
if c3_x<0
    v_x=-v_x;
end
sigma_x =exp(real(c1_x )-psi(0,k_x )/real(v_x ));
k_array(1)=k_co;
k_array(2)=k_x;
v_array(1)=v_co;
v_array(2)=v_x;
sigma_a(1)=sigma_co;
sigma_a(2)=sigma_x;

end

