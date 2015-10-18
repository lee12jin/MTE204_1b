function [ u, v, a, f ] = apply_explicit_dynamic_formulation( A_t, B_t, D_t, u0, u_next, v0, a0, t, time_step, n )
%APPLY_EXPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    syms u_2 f_1;
    
    u = zeros(n, t / time_step);
    v = zeros(n, t / time_step);
    a = zeros(n, t / time_step);
    f = zeros(n, t / time_step);
    
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1);
    
    for i = 1:(t / time_step)
        if (i > 1)
            u_prev = u(:, i - 1);
        else
            u_prev = u(:, 1);
        end
        
        f_cur = [f_1;
                 10;];
        
        eqn = (A_t * u_next) == (f_cur - B_t * u(:, i) - D_t * u_prev);
        
        values = solve(eqn, u_2, f_1);
        
        u2 = double(values.u_2);
        f1 = double(values.f_1);
        
        % Next displacement
        u(:, i + 1) = [0;
                       values.u_2;];
                   
        % Set the reaction force
        f(:, i) = [values.f_1;
                   10;];
        
        % Calculate velocity
        v(:, i) = ( u(:, i + 1) - u_prev ) / (2 * time_step);
        % Calculate acceleration
        a(:, i) = ( u(:, i + 1) - 2 * u(:, i) + u_prev ) / (time_step ^ 2);
        
    end

end

