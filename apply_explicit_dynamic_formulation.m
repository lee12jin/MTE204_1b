function [ u, v, a, f ] = apply_explicit_dynamic_formulation( M, K, C, u0, u_unknown, v0, a0, f_unknown, t, time_step, n, unknown )
%APPLY_EXPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    
    [ A_t, B_t, D_t ] = calc_expl_temp_matrices( M, C, K, time_step );
    
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
        constant =  - B_t * u(:, i) - D_t * u(:, max(1, i - 1));
        [u_known, f_known] = solver(A_t, u_unknown, f_unknown + constant);
        u(:, i + 1) = u_known;
        f(:, i + 1) = f_known;
        % Calculate velocity
        v(:, i) = ( u(:, i + 1) - u(:, max(1, i - 1)) ) / (2 * time_step);
        % Calculate acceleration
        a(:, i) = ( u(:, i + 1) - 2 * u(:, i) + u(:, max(1, i - 1)) ) / (time_step ^ 2);
        
    end
    
    u = u(:, 1:len);
    v = v(:, 1:len);
    a = a(:, 1:len);
    f = f(:, 1:len);

end

