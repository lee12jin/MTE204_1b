function [ u_ ] = calc_u_dot( u1, u_1, t_delta )
    % calculates [u.]i for Explicit Dynamics
    % u1 = [u]i+1
    % u_1 = [u]i-1
    % t_delta = time step
   
    u_ = (u1 - u_1) / (2*t_delta);
end

