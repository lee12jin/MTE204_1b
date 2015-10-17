function [ x ] = sum_u(j, k, L, U )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x = 0;
for i=1:j-1
    x = x + L(j,i)*U(i,k);
end
end

