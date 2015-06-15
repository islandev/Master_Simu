
function y=prodgamma(x,A)

%  The product of all terms except the poles of gamma(A).
% x    --- poles for v=1:n
%  gamma(aj+Aj*x); aj=A(1,:)  Aj=A(2,:);


delta=1e-5;

m=size(A,2);% number of terms for product
[n,k]=size(x);

if m==0
    y=1;
else
    for i=1:m
        tmp1=A(1,i)+A(2,i).*x;
        chk=(abs(tmp1-round(tmp1))<delta)& tmp1<1;
        tmp1(chk)=1;
        tmp(:,:,i)=gamma(tmp1);
    end
    y=prod(tmp,3);

end


end