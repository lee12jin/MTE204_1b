function [ u, v, a, f ] = apply_implicit_dynamic_formulation( A_t, B_t, C_t, D_t, u0, u1, v0, a0, f1, beta, gamma, t, time_step, n )
%APPLY_IMPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    u = zeros(n, t / time_step);
    v = zeros(n, t / time_step);
    a = zeros(n, t / time_step);
    f = zeros(n, t / time_step);
    
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1);
    
    for i = 1:((t / time_step) - 1)
        syms u_2 f_1
        values = solve(A_t * u1 - f1 - B_t * u(:, i) - C_t * v(:, i) - D_t * a(:, i), u_2, f_1);
        f(:, i + 1) = [values.f_1; 10;];
        u(:, i + 1) = [0; values.u_2;];
        a(:, i + 1) = (2 / (beta * time_step)) * ((u(:, i + 1) - u(:, i)) / time_step) - (2 / (beta * time_step)) * v(:, i) - ((1 - beta) / beta) * a(:, i);
        v(:, i + 1) = time_step * ((1 - gamma) * a(:, i) + gamma * a(:, i + 1)) + v(:, i);
    end
end

