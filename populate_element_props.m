function [ l_C, l_K ] = populate_element_props( sctr, coords, c, k, dof )
%POPULATE_PHYSICAL_PROPS Summary of this function goes here
%   Detailed explanation goes here

    % Number of elements
    e = size(sctr, 1);
    
    % Angle of element with respect to global system
    theta = zeros(e, 1);
    
    % Size of the local matrices
    local_size = 2 * dof;
    % Local c matrix for each element
    l_C = zeros(local_size, local_size, e);
    % Local k matrix for each element
    l_K = zeros(local_size, local_size, e);
    
    
    for element = 1:e
        % Get the nodes of the element
        node1 = sctr(element, 1);
        node2 = sctr(element, 2);
        
        % Get the coordinates of each node
        x1 = coords(node1, 1);
        y1 = coords(node1, 2);
        x2 = coords(node2, 1);
        y2 = coords(node2, 2);
        
        % For the 1D case, all the forces are along the global reference
        if dof > 1
            theta(element, 1) = calc_angle(x1, y1, x2, y2);
        end
        
        % Get the local C matrix 
        l_C(:, :, element) = create_local_prop_matrix(c(element, 1), theta(element, 1), dof);
        % Get the local K matrix
        l_K(:, :, element) = create_local_prop_matrix(k(element, 1), theta(element, 1), dof);
   
    end
end

