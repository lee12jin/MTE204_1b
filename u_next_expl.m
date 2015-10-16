function [ u_i1 ] = u_next_expl( A_1, F, B, u, D, u_ )
    % calculates [u]i+1 for Explicit Dynamics
    % A_1 = [A]-1 (Inverse of A)
    % F = [F]i
    % B = [B]
    % u = [u]i
    % D = [D]
    % u_ = [u]i-1    
    u_i1 = A_1*( F - B*u - D*u_ );
end

