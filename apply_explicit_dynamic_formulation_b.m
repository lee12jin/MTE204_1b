function [ u, v, a, f ] = apply_explicit_dynamic_formulation_b( M, C, K, u0, v0, a0, t, time_step, n )
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

    [A_t, B_t, D_t] = calc_expl_temp_matrices( M, K, C, time_step );
    
    len = t / time_step + 1;

    u = zeros(n, len);
    v = zeros(n, len);
    a = zeros(n, len);
    f = zeros(n, len);
    
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1);
    
    for i = 1:len
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
        
        eqn = (A_t * u_unknown) == (f_cur + B_t * u(:, i) + D_t * u(:, max(1, i-1)));
                        
        values = solve(eqn, f1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11);
        
        f_1 = double(values.f1);
        
        % Set the force
        f(1, i + 1) = f_1;
        
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
        
        % Calculate velocity
        v(:, i) = ( u(:, i + 1) - u(:, max(1, i - 1)) ) / (2 * time_step);
        % Calculate acceleration
        a(:, i) = ( u(:, i + 1) - 2 * u(:, i) + u(:, max(1, i - 1)) ) / (time_step ^ 2);
        
    end
end

