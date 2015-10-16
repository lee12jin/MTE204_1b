function [ m ] = find_node_mass( sctr, rho, A, L )
% Calculates the mass of each node of a bar split into e equal elements
% Returns a vector with the mass of each node

    % Number of elements of the bar
    e = size(sctr, 1);
    % Mass of a single element
    m_element = rho * A * (L/e);
    
    % Initialize a mass vector to 0
    m = zeros(e+1, 1);
    
    for i = 1:e
        node1 = sctr(i, 1);
        node2 = sctr(i, 2);
        
        % The mass of an element is split equally between its two nodes
        m(node1, 1) = m(node1, 1) + m_element/2;
        m(node2, 1) = m(node2, 1) + m_element/2;
    end

end

