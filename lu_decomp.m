function [ x ] = lu_decomp( A, b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(A);
L = zeros(n);
U = zeros(n);
x = zeros(n,1);
d = zeros(n,1);
for i=1:n
    L(i,1) = A(i,1);
end
for j=2:n
    U(1,j) = A(1,j)/L(1,1);
end
for j=2:n-1
    for i=j:n
        L(i,j) = A(i,j)  - sum_l(j, i, L, U);
    end
    for k=j+1:n
        U(j,k) = (A(j,k) - sum_u(j, k, L, U))/L(j,j);
    end
end
sum = 0;
for i=1:n-1
    sum = sum + L(n,i)*U(i,n);
end
L(n,n) = A(n,n) - sum;
for i=1:n
    U(i,i) = 1;
end
L
U
d(1) = b(1)/L(1,1);
sum_knowns = 0;
for i=2:n
    for j=1:(i-1)
        sum_knowns = sum_knowns + d(j)*L(i,j);
        d(i) = (b(i) - sum_knowns)/L(i,i);
    end
    sum_knowns = 0;
end
d
x(n) = d(n)/U(n,n);
sum_knowns = 0;
for i=n-1:-1:1
    for j=n:-1:(i+1)
        sum_knowns = sum_knowns + x(j)*U(i,j);
        x(i) = (d(i) - sum_knowns)/U(i,i);
    end
    sum_knowns = 0;
end
x
end

