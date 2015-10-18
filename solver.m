function [ U, F  ] = solver( K, u, f )
%SOLVER Summary of this function goes here
%   Detailed explanation goes her

    [~, n] = size(K);
    number_unknowns = 0;
    for s = 1:n
        if ~isreal(u(s))
            number_unknowns = number_unknowns + 1;
        end
    end
    
    swaps_counter = 0;
    swaps = zeros(n, 2);
    [u, f, K, swaps_counter, swaps] = swap_operations(n, u, swaps_counter, swaps, f, K);
    [k_e, k_ef, k_fe, k_f, split_index] = splitK(K, n, number_unknowns);
    b_f = f(split_index:n, 1);
    u_e = u(1:(split_index-1), 1);
    [u_f] = lu_decomp(k_f, b_f - k_fe * u_e);
    u(split_index:n, 1) = u_f(:, 1);
    f = K * u;
    [swaps_counter, swaps, u, f] = unswap(swaps_counter, swaps, u, f);
    U = u;
    F = f;
    
end

