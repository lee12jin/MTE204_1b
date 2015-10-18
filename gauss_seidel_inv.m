function [ A_inv ] = gauss_seidel_inv( A, inv_guess, tolerance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(A);
A_inv = eye(n);
for i=1:n
    A_inv(:,i) = gauss_seidel(A, inv_guess(:,i), A_inv(:,i), tolerance);
end
end

