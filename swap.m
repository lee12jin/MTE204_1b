function M = swap(M, index1, index2)

% swap rows
temp = M(index2, :);
M(index2, :) = M(index1, :);
M(index1, :) = temp;

% swap columns
% temp = M(:, index2);
% M(:, index2) = M(:, index1);
% M(:, index1) = temp;

end

