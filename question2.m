clear all;
clc; 

% Solves dynamic loading of a generic 1D dynamic bar

% Placeholder for variable
unknown = 111111111;

dof = 2;

% === Material Properties ===
% Length of the bar (m)
L = 1;
% Young's Modulus (Pa)
E = 70 * 10^9;
% Density (kg/m^3)
rho = 2700;
% Poisson's Ratio
v = 0.30;
% Internal damping (N/s)
damping = 0.001;
% Cross sectional area (m^2)
A = 10^(-6);

% Number of elements (given)
e = 10;
% Number of nodes 
n = e+1;
% Total time (seconds)
t = 5;
% Gravitational acceleration (m/s^2)
g = 9.81;

% Build the scatter and coordinate matrix
[sctr, coords] = build_scatter(L, e);

% Internal damping for each element
c = damping * ones(e, 1);
% Stiffness for each element
k = (A * E) / (L / e) * ones(e, 1);
% Density for each element
rhos = rho * ones(e, 1);
% Length of each element
lengths = ( L / e ) * ones(e, 1);
% Cross sectional area of each element
areas = A * ones(e, 1);

% Create the local C and K matrices
[l_C, l_K] = populate_element_props( sctr, coords, c, k, dof );

% Calculate the mass for each node
m = find_node_mass( sctr, rhos, areas, lengths );

[M, C, K] = build_global_matrices( sctr, m, l_C, l_K, n, e, dof );


