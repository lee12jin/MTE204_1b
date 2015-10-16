function [ sctr, coords ] = build_scatter( L, e )
% Builds the scatter and coordinate matrix for a bar of length L
% consisting of e equal bar elements.
    
    sctr = zeros(e, 2);
    
    % Build a scatter matrix of adjacent elements
    for i = 1:e
        sctr(i, 1) = i;
        sctr(i, 2) = i+1;
    end
    
    % There is one more node than there are elements
    coords = zeros(e+1, 2);
    
    % Length of an individual element
    element_length = L / e;
    
    % Loop from 0 to L, incrementing element_length each iteration
    node = 1;
    for i = 0:element_length:L
        coords(node, 1) = i;
        coords(node, 2) = 0; % All along the x-axis
        node = node + 1;
    end

end

