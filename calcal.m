



f=@(k)norm(psi(1,k).^3/psi(2,k).^2-val_left).^2;
[k,err]=fminsearch(f,0);
