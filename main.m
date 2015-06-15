
clear all;clc;


% Case A, single pole
res=1e-8;
B={[1;1],[0.5;1]};
A={[1;1],[]};
x=2.9;

%H_m=1_n=1_q=2_p=0
fox=foxh(x,B,A,res);
myfox_A=vpa(fox,10) %display more bits

% Checking with the build-in meijerG function in mupad
meijer_A = evalin(symengine,'meijerG([[1], []], [[1], [1/2]], 2.9)')

%---------------------------------------------
% Case B, two poles
res=1e-8;
B={[1,0.3;1,1],[0.5;1]};
A={[1;1],[]};
x=2.9;

%H_m=2_n=1_q=3_p=0
fox=foxh(x,B,A,res);
myfox_B=vpa(fox,10) %display more bits

% Checking with the build-in meijerG function in mupad
meijer_B = evalin(symengine,'meijerG([[1], []], [[1,0.3], [1/2]], 2.9)')







