function [ u__ ] = calc_u_dotdot( u1, u, u_1, t_delta )
    % calculates [u..]i for Explicit Dynamics
    % u1 = [u]i+1
    % u = [u]i
    % u_1 = [u]i-1
    % t_delta = time step
    u__ = (u1 - 2*u + u_1) / (t_delta*t_delta);
end

