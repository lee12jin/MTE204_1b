function [ x ] = sum_l(j, i, L, U )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = 0;
for k=1:j-1
    x = x + L(i,k)*U(k,j);
end
end

