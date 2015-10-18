clear all;
clc; 

% Solves dynamic loading of a generic 1D dynamic bar

% Placeholder for variable
unknown = 111111111;

dof = 1;

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
% Time increments
delta_t = [0.1;
           0.001;
           0.00001;];
       
t_1 = linspace(0, t, t/0.1 + 1);

% Build the scatter and coordinate matrix
[sctr, coords] = build_scatter(L, e);

% Density for each element
rhos = rho * ones(e, 1);
% Initial length of each element
lengths = ( L / e ) * ones(e, 1);
% Initial cross sectional area of each element
areas = A * ones(e, 1);
% Internal damping for each element
c = damping * ones(e, 1);
% Initial stiffness for each element
k = calc_k( E, areas, lengths );

% Create the local C and K matrices
[l_C, l_K] = populate_element_props( sctr, coords, c, k, dof );

% Calculate the mass for each node
m = find_node_mass( n, sctr, rhos, areas, lengths );

[M, C, K] = build_global_matrices( sctr, m, l_C, l_K, n, e, dof );

% Initial conditions for Node 2
u0 = zeros(dof * n, 1); % displacement [m]

syms u_2 u_3 u_4 u_5 u_6 u_7 u_8 u_9 u_10 u_11
u_unknown = [0;
             u_2;
             u_3;
             u_4;
             u_5;
             u_6;
             u_7;
             u_8;
             u_9;
             u_10;
             u_11;]; 
         
v0 = zeros(dof * n, 1); % velocity [m/s]
a0 = zeros(dof * n, 1); % acceleration [m/s^2]

% f_unknown = [f_1;
%             %.. 2 - 10 are 0
%              10;]; % force [N]

% Part a - explicit

% [u_solved1, v_solved1, a_solved1, f_solved1] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(1), n);
% [u_solved2, v_solved2, a_solved2, f_solved2] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(2), n);
% [u_solved3, v_solved3, a_solved3, f_solved3] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(3), n);
% Part b - implicit

gamma = 3 / 2;
beta = 8 / 5;

[u_solved1, v_solved1, a_solved1, f_solved1] = apply_implicit_dynamic_formulation_b(M, C, K, u0, u_unknown, v0, a0, beta, gamma, t, delta_t(1), n);

plot(t_1, u_solved1(11,1:51));


