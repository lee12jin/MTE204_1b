function [ g_displacements, g_forces, g_K, swaps_counter, swaps ] = swap_operations( size, g_displacements, swaps_counter, swaps, g_forces, g_K )
% Row swap and column swap the k global matrix

    % 2 indices to keep track of 2 rows in the k global matrix
    index = 1;

    % Row swap and column swap the k global matrix
    while index <= size

        % Check if the displacement value for the current row is known
        if ~isreal(g_displacements(index, 1))

            runner_index = index; % set runner_index to start from the same 
            % row as index

            % runner_index searches for the next row that has a known 
            % displacement value
            while runner_index <= size && ~isreal(g_displacements(runner_index, 1))
                runner_index = runner_index + 1;
            end

            if runner_index > size
                % Exit this while loop
                break
            end

            % Row swaps
            g_displacements([runner_index index], :) = g_displacements([index runner_index], :);
            g_forces([runner_index index], :) = g_forces([index runner_index], :);
            g_K([runner_index index], :) = g_K([index runner_index], :);

            % Column swaps
            g_K(:, [runner_index index]) = g_K(:, [index runner_index]);

            % to keep track of which rows were swapped
            swaps(swaps_counter + 1, 1) = index; 
            swaps(swaps_counter + 1, 2) = runner_index;

            swaps_counter = swaps_counter + 1;

        end

        index = index + 1; % move to next row

    end

end