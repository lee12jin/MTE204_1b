function [ A_t, B_t, C_t, D_t ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step )
%CALCULATE_IMPLICIT_TEMPORARY_MATRICES This function generates the A tilda,
%B tilda, C tilda, and D tilda as A_t, B_t, C_t, and D_t repectively

    A_t = (2 / (beta * time_step^2)) * M + K + (2 * gamma / (beta * time_step)) * C;
    B_t = (2 / (beta * time_step^2)) * M + (2 * gamma / (beta * time_step)) * C;
    C_t = (2 / (beta * time_step)) * M + (2 * gamma / beta - 1) * C;
    D_t = ((1 - beta) / beta) * M + time_step * C * ((gamma - 1) + (1 - beta) / beta * gamma);

end

