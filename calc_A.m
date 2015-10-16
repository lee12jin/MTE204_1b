function [ A ] = calc_A( M, C, t_delta )
    % calculates [A] matrix for Explicit Dynamics
    A = (M/(t_delta*t_delta)) + (C/(2*t_delta));
end

