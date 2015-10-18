function [ A_inv ] = lu_decomp_inv( A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(A);
A_inv = eye(n);
x = zeros(n);
for i=1:n
    A_inv(:,i) = lu_decomp(A, x(:,i), A_inv(:,i));
end
end

