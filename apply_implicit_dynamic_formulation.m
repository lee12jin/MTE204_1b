function [ u, v, a, f ] = apply_implicit_dynamic_formulation( A_t, B_t, C_t, D_t, u0, v0, a0, f0, beta, gamma, t, time_step )
%APPLY_IMPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    u = zeros(2, t / time_step);
    v = zeros(2, t / time_step);
    a = zeros(2, t / time_step);
    f = zeros(2, t / time_step);
    
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = f0;
    
    for i = 1:((t / time_step) - 1)
        f(:, i + 1) = [unknown;
                       10;];
        % TODO: solve for both u[:, i+1] and f[:, i+1] within the following
        % equation
        u(:, i + 1) = A_t \ (f(:, i + 1) + B_t * u(:, i) + C_t * v(:, i) + D_t * a(:, i);
        a(:, i + 1) = (2 / (beta * time_step)) * ((u(:, i + 1) - u(:, i) / time_step) - (2 / (beta * time_step)) * v(:, i) - ((1 - beta) / beta) * a(:, i);
        v(:, i + 1) = time_step * ((1 - gamma) * a(:, i) + gamma * a(:, i + 1)) + v(:, i);
    end
end

