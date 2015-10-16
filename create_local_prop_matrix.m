function [ l_prop ] = create_local_prop_matrix( prop, theta, dof )
%CREATE_LOCAL_PROP_MATRIX Summary of this function goes here
%   Detailed explanation goes her

    % Create local property matrix

    % 2D case
    if dof > 1
        a = cos(theta);
        b = sin(theta);
    
        l_prop_temp  = [(a^2), (a * b);
                        (a * b), (b^2);];
                           
        l_prop = prop * [l_prop_temp, -l_prop_temp;
                         -l_prop_temp, l_prop_temp;];
                     
    % 1D case
    else
        l_prop = prop * [1, -1;
                         -1, 1;];
    end
        
end

