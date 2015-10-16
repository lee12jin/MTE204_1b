function [ m ] = find_node_mass( n, sctr, rhos, areas, lengths )
% Calculates the mass of each node given the properties of the elements
% Returns a vector with the mass of each node

    % Number of elements of the bar
    e = size(sctr, 1);
    
    % Initialize a mass vector to 0
    m = zeros(n, 1);
    
    for i = 1:e
        % Mass of the element: density * area * length
        m_element = rhos(e, 1) * areas(e, 1) * lengths(e, 1);
        
        node1 = sctr(i, 1);
        node2 = sctr(i, 2);
        
        % The mass of an element is split equally between its two nodes
        m(node1, 1) = m(node1, 1) + m_element/2;
        m(node2, 1) = m(node2, 1) + m_element/2;
    end

end

