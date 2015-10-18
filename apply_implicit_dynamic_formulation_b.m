function [ u, v, a, f ] = apply_implicit_dynamic_formulation_b( M, C, K, u0, u_unknown, v0, a0, beta, gamma, t, time_step, n )
%APPLY_IMPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    
    syms f1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11
    
    u_unknown = [0;
                 u2;
                 u3;
                 u4;
                 u5;
                 u6;
                 u7;
                 u8;
                 u9;
                 u10;
                 u11;];

    [A_t, B_t, C_t, D_t] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step );

    size = t / time_step + 1;
    
    u = zeros(n, size);
    v = zeros(n, size);
    a = zeros(n, size);
    f = zeros(n, size);
    
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1);
    
    for i = 1:(size - 1)
        f_cur = [f1;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 i * time_step;];        
        
        % Applied force
        f(n, i + 1) = i * time_step;
        
        eqn = (A_t * u_unknown) == (f_cur + B_t * u(:, i) + C_t * v(:, i) + D_t * a(:, i));
        
        values = solve(eqn, f1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11);
        
        % Set the force
        f(1, i + 1) = values.f1;
        
        % Set the displacements
        u(:, i + 1) = [0;
                       values.u2;
                       values.u3;
                       values.u4;
                       values.u5;
                       values.u6;
                       values.u7;
                       values.u8;
                       values.u9;
                       values.u10;
                       values.u11;];
        
        a(:, i + 1) = (2 / (beta * time_step)) * ((u(:, i + 1) - u(:, i)) / time_step) - (2 / (beta * time_step)) * v(:, i) - ((1 - beta) / beta) * a(:, i);
        v(:, i + 1) = time_step * ((1 - gamma) * a(:, i) + gamma * a(:, i + 1)) + v(:, i);
    end
end

