function [ swaps_counter, swaps, g_displacements, g_forces ] = unswap( swaps_counter, swaps, g_displacements, g_forces )
% Transforming rows back to maintain original order
   
    % Iterate through all swaps to unswap
    for unswaps_counter = swaps_counter:-1:1

        % Keep track of which rows were swapped
        first_row = swaps(unswaps_counter, 1);
        second_row = swaps(unswaps_counter, 2);
        
        % Perform row swaps to return to original orientation
        g_displacements([first_row second_row], :) = g_displacements([second_row first_row], :);
        g_forces([first_row second_row], :) = g_forces([second_row first_row], :);
    
    end
    
end

