function [ k_e, k_ef, k_fe, k_f, split_index ] = splitK( g_K, size, c )

    % Set the index from which we split the matrix
    split_index = size - c + 1;

    % Build [k_e], [k_ef], [k_fe], and [k_f] matrices
    k_e = g_K(1:(split_index-1), 1:(split_index-1));
    k_ef = g_K(1:(split_index-1), split_index:size);
    k_fe = g_K(split_index:size, 1:(split_index-1));
    k_f = g_K(split_index:size, split_index:size);

end

