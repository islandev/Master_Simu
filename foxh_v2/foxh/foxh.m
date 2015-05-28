function [y,P]=foxh(x,B,A,res)
% This is a toy implementation for the Fox's H-function.
% 20150523 by Liu Chi
%---------------------------------
% Variables
% x -- The x is a value.
% B -- The parameters B in Fox's H-function. 
%      B{1}(:,:) is 1~m; B{2}(:,:) is m+1~q.
% A -- The parameters A in Fox's H-function
%      A{1}(:,:) is 1~n; A{2}(:,:) is n+1~p.
% res--resolution.
%------------------------------------
% Notes:
% 1. Until performing this function, the existance condition must be guaranteed. 
% 2. Only 1-order residues are taken into consideration in this function.

%--------------------------------------------
% Preprocessing
%--------------------------------------------

if nargin<4
    res=1e-7;
end

delta=1e-10;

m=size(B{1},2);
q=size(B{2},2);

n=size(A{1},2);
p=size(A{2},2);

B_tmp=B;
B_tmp{2}(1,:)=1-B{2}(1,:);
B_tmp{2}(2,:)= -B{2}(2,:);

A_tmp=A;
A_tmp{1}(1,:)=1-A{1}(1,:);
A_tmp{1}(2,:)= -A{1}(2,:);


%--------------------------------------------
% Evaluation
%--------------------------------------------
N=size(x,2);
maxitr=100;

converged=false;
maxitr=1000;
v=0;
t=0;
y_old=0;
y_new=0;

while ~converged && t<maxitr
    
    Poles_B=-bsxfun( @rdivide, bsxfun(@plus,B{1}(1,:),v')...
        , (B{1}(2,:)+delta) );
    
    
    C=bsxfun(@rdivide,  ((-1).^v./factorial(v))'...
        ,  B{1}(2,:) )  ;
    B_num=prodgamma(Poles_B,B_tmp{1});
    A_num=prodgamma(Poles_B,A_tmp{1});
    B_den=prodgamma(Poles_B,B_tmp{2});
    A_den=prodgamma(Poles_B,A_tmp{2});
    Z=x.^(-Poles_B);
    
    tmp=C.*(B_num.*A_num)./(B_den.*A_den).*Z;
    gap=sum( sum(tmp,1) ,2);
    
    converged=abs(gap)<res;
    
    y_new=y_old+gap;
    y_old=y_new;
    
    v=v+1;
    t=t+1;

end

%-------------------
%output
%--------------------

if converged
    fprintf('Fox H function is converged in %d steps.\n',v);
else
    fprintf('Fox H function is NOT converged in %d steps.\n',maxitr);
end

y=y_new;





end

