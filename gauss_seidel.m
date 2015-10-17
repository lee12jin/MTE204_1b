function [ x ] = gauss_seidel( A, x, b, tolerance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(b);

%make diagonally dominant
for i=1:n
    if(A(i,i) < (sum(A(i, :),2) - A(i,i)))
        j = i;
        while(j <= n && A(j,i) < (sum(A(j, :),2) - A(j,i)))
            j = j + 1;
        end
        if j ~= n+1
           A = swap(A, i, j);
           b = swap(b, i, j);
           x = swap(x, i, j);
        else
            'A is not diagonally dominant'
        end
    end
end
A
x_old = x;
sum_knowns = 0;
%run iteration
while(tolerance_is_not_met(x, x_old, tolerance))
    x_old = x;
    for i=n:-1:1
        for j=n:-1:(i+1)
            sum_knowns = sum_knowns + x(j)*A(i,j);
        end
        if i >= 2
            for k=1:(i-1)
                sum_knowns = sum_knowns + x(k)*A(i,k);
            end
        end       
        x(i) = (b(i) - sum_knowns)/A(i,i);
        sum_knowns = 0;
    end
end
end

