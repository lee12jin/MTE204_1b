function [ M, C, K ] = build_global_matrices( sctr, m, l_C, l_K, n, e, dof )
%BUILD_GLOBAL_MATRICES Summary of this function goes here
%   Detailed explanation goes here
    
    % Size of the global matrices
    global_size = n * dof;
    M = zeros(global_size);
    C = zeros(global_size);
    K = zeros(global_size);
    
    % Size of local matrices
    local_size = 2 * dof;
    
    for element = 1:e
        for i = 1:local_size
            for j =1:local_size                
                % Global row and column 
                g_row = sctr(element, (floor(i/3) + 1)) * 2 - mod(i,2);
                g_column = sctr(element, (floor(j/3) + 1)) * 2 - mod(j,2);
                
                % Update the global C matrix
                C(g_row, g_column) = C(g_row, g_column) + l_C(i, j, element);
                % Update the global K matrix
                K(g_row, g_column) = K(g_row, g_column) + l_K(i, j, element);
            end
        end
    end
    
    node = 1;
    for i = 1:n
        % Update the diagonals for the global mass matrix
        M(i, i) = m(node, 1);
        
        % For 1D, node mass appears once in the global matrix
        % For 2D, node mass appears twice in the global matrix
        if mod(i,dof) == 0
            node = node + 1;
        end
    end

end

