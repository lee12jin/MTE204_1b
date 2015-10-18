function [ u, v, a, f ] = apply_explicit_dynamic_formulation( A_t, B_t, D_t, u0, u_unknown, v0, a0, f_unknown, t, time_step, n )
%APPLY_EXPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    syms u_2 f_1;
    
    len = t / time_step + 1;
    
    u = zeros(n, len);
    v = zeros(n, len);
    a = zeros(n, len);
    f = zeros(n, len);
    
    % Time zero conditions
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = [0;
               10;];
    
    for i = 1:len
        eqn = (A_t * u_unknown) == (f_unknown - B_t * u(:, i) - D_t * u(:, max(1, i - 1)));
        
        values = solve(eqn, u_2, f_1);
                
        % Next displacement
        u(:, i + 1) = [0;
                       values.u_2;];
                   
        % Set the reaction force
        f(:, i) = [values.f_1;
                   10;];
        
        % Calculate velocity
        v(:, i) = ( u(:, i + 1) - u(:, max(1, i - 1)) ) / (2 * time_step);
        % Calculate acceleration
        a(:, i) = ( u(:, i + 1) - 2 * u(:, i) + u(:, max(1, i - 1)) ) / (time_step ^ 2);
        
    end
    
    u = u(:, 1:(len-1));
    v = v(:, 1:(len-1));
    a = a(:, 1:(len-1));
    f = f(:, 1:(len-1));

end

