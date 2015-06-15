
function F=myFCSJiaoZheng(a,t)
F=a(1)+a(4)*(1+a(2)*exp(-a(3)*t)).* ((1./(1+a(5)*a(6)*t)).^0.5) ./ (1+a(5).*t);
end
