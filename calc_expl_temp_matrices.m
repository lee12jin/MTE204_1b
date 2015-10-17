function [ A, B, D ] = calc_expl_temp_matrices( M, C, K, t_delta )
    % calculates [A] matrix for Explicit Dynamics
    A = (M/(t_delta*t_delta)) + (C/(2*t_delta));
    B = K - 2*M/(t_delta*t_delta);
    D = (M/(t_delta*t_delta)) - (C/(2*t_delta));
    
end

