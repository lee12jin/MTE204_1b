function [ X, B ] = lud( A, x, b )
%LUD Pass in an equation in the form of [A][x] = [b]
    
    [m, n] = size(A);
    L = zeros(n, n);
    U = zeros(n, n);
    d = zeros(n, 1);

    for i = 1:n
        L(i, 1) = A(i, 1);
        U(i, i) = 1;
        if i > 1
            U(1, i) = A(1, i);
        end
    end
    
    for j = 2:(n-1)
        for i = j:n
            L(i, j) = A(i, j) - sum(L(i, k) * U(k, j), k = 1..(j-1));
        end
        for k = (j+1):n
            U(j, k) = A(j, k) - sum(L(j, i) * U(i, k), i = 1..(j-1));
        end
    end
    
    L(n, n) = A(n, n) - sum(L(n, k) * U(k, n), k = 1..(n-1));
    
    for i = 1:n
        d(i, 1) = (b(i, 1) - sum(L(i, k) * d(k, 1), k = 1..(i-1))) / L(i, i);
    end
    
    
    
end

