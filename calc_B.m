function [ B ] = calc_B( k, M, t_delta )
    % calculates [B] matrix for Explicit Dynamics
    B = k - 2*M/(t_delta*t_delta);
end


