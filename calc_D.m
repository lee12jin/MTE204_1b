function [ D ] = calc_D( M, C, t_delta )
    % calculates [D] matrix for Explicit Dynamics
    D = (M/(t_delta*t_delta)) - (C/(2*t_delta));
end

