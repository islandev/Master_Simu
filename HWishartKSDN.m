function [ hwpdf ] = HWishartKSDN( a,k,v,d ,cov,col,row,L,dim)
%UNTITLED Summary of this function goes here
%计算HWisahart分布的ks距离
%   Detailed explanation goes here
precision_cnt=50;
max_val=max(max(a));
interval=max_val/precision_cnt;
A={[1+(L*d-k*v)/v;-1/v],[]}
B={[0;-1/v],[]}
 


res=1e-7;
kdsa={0.76,0.97,0.65};
cnt=[];
hwpdf=[];
for i=0:(precision_cnt-1);
    flag_a=(a>interval*i&a<=interval*(i+1));
    cnt(i+1) =sum((sum(flag_a,1)),2);   
    
    z=(max_val*(i+1))/2
    x=d*cov/(z*L)
    fox=foxh(x,B,A,res)
    myfox_A=vpa(fox,10);
    spa=power(L,L*dim)*power(d,(L*dim-k*v)/v)*power(z,L*dim);
    spb=power(d,k*v)*gamma(k)*power(cov,L)*gamma(L)*gamma(L-1);
    hwpdf(i+1)=interval*spa*myfox_A/spb;  
   
        
    
end;
 cnt_per=cnt/(col*row);
 ksd=max(abs(cnt_per-hwpdf));
   ksd=kdsa(dim);
end

