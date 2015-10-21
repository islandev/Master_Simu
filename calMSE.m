function [ mse_val ] = calMSE( c1,c2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    m_size=size(c1,2);
    
    mse_val=0;
    for i=1:m_size
        mse_val=mse_val+(c1(i)-c2(i))^2;
    end
    mse_val=(mse_val/m_size)^3;
end

