function [ k ] = calc_k( E, A, L )
% Calculates the stiffness of a vector of elements given their Elastic
% Modulus, cross sectional area, and length.

    k = E * (A) ./ (L);

end

