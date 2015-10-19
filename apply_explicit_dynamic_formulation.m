function [ u, v, a, f ] = apply_explicit_dynamic_formulation( M, K, C, u, v, a, f, u_unknown, f_unknown, t, time_step, n, question, dof, omega )
%APPLY_EXPLICIT_DYNAMIC_FORMULATION Summary of this function goes here
%   Detailed explanation goes here
    
    [ A_t, B_t, D_t ] = calc_expl_temp_matrices( M, C, K, time_step );
    
    len = round(t / time_step) + 1;
    
    for i = 1:len
        if question == 2
            f_unknown(n, 1) = i * time_step;
        elseif question == 3
            cur_time = i * time_step;
            % Displacement of node 5 (y direction)
            u5 = 50 * sin(omega * cur_time);
            u(5 * dof, i) = u5;
            u_unknown(5 * dof, 1) = u5;
            % Velocity of node 5 (y direction)
            v(5 * dof, i) = 50 * omega * cos(omega * cur_time);
            % Acceleration of node 5 (y direction)
            a(5 * dof, i) = - 50 * omega * omega * sin(omega * cur_time);
            % Mass of node 5
            m5 = M(n*dof, n*dof);
            % Force of node 5 (y direction)
            f5 = m5 * a(5 * dof, i);
            f(5 * dof, i) = f5;
            f_unknown(5 * dof, 1) = f5;
            
        end
        constant = B_t * u(:, i) + D_t * u(:, max(1, i - 1));
        [u_known, f_known] = solver(A_t, u_unknown, f_unknown - constant);
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

