function [ u, v, a, f ] = apply_implicit_dynamic_formulation( M, K, C, u, v, a, f, u_unknown, f_unknown, beta, gamma, t, time_step )
%APPLY_IMPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    [A_t, B_t, C_t, D_t] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step );
    
    for i = 1:(t / time_step)
        constant =  B_t * u(:, i) + C_t * v(:, i) + D_t * a(:, i);
        [u_known, f_known] = solver(A_t, u_unknown, f_unknown + constant);
        u(:, i + 1) = u_known;
        f(:, i + 1) = f_known;
        a(:, i + 1) = (2 / (beta * time_step)) * ((u(:, i + 1) - u(:, i)) / time_step) - (2 / (beta * time_step)) * v(:, i) - ((1 - beta) / beta) * a(:, i);
        v(:, i + 1) = time_step * ((1 - gamma) * a(:, i) + gamma * a(:, i + 1)) + v(:, i);
    end
    
end

