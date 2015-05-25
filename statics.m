clc;
clear all;
row =83;     col =83 ;     data = zeros(row,col,9);
precision_cnt=50;
filePath = 'C:\Users\Administrator\Desktop\polsardata\C3\';
%filePath = 'C:\Users\Administrator\Desktop\AIRSAR_SanFrancisco\C3\';
fIn = fopen([filePath 'C11.bin'],'r');
c11(:,:) = fread(fIn,[col,row],'float').';     fclose(fIn);
cnt=[];
spa=reshape(c11,83,83);
max_val=max(max(c11))/precision_cnt;
    
for i=0:(precision_cnt-1);
    flag_c11=(c11>max_val*i&c11<=max_val*(i+1));
    cnt(i+1) =sum((sum(flag_c11,1)),2);
   
end;
cnt_per=cnt/(col*row);
cnt_per;

sum(cnt_per);






x=0:max_val:max(max(c11))-max_val;
plot(x,cnt_per,'*-');










