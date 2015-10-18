clear all;
clc;

syms f_1 u_2

% Scatter matrix
sctr = [1, 2];

% Node coordinates
coords = [0, 0;
          1, 0;];

% Number of nodes
n = size(coords, 1);

% Number of elements
e = size(sctr, 1);
      
% Degrees of freedom
dof = 1;
      
% Mass of each node (kg)
m = [0;
     10;];

% Damper value for each element (N/s)
c = [1];

% Spring constant for each element (N/m)
k = [10];
 
% Initial conditions for Node 2
u0 = [0;
      0;]; % displacement [m]
u_unknown = [0;
          u_2;]; % displacement after first timestep
v0 = [0;
      0;]; % velocity [m/s]
a0 = [0;
      0;];% acceleration [m/s^2]
f_unknown = [f_1;
          10;]; % force [N]

% Size of the global matrices
size = dof * n;

% Create the local C and K matrices
[l_C, l_K] = populate_element_props( sctr, coords, c, k, dof );

[M, C, K] = build_global_matrices( sctr, m, l_C, l_K, n, e, dof );

% Total time (seconds)
t = 5;

% Time increments
time_step1 = 0.01;
time_step2 = 0.1;
time_step3 = 1;

% Create time vectors
t1 = linspace(0, t, t/time_step1 + 1);
t2 = linspace(0, t, t/time_step2 + 1);
t3 = linspace(0, t, t/time_step3 + 1);

% Part a - explicit
[ A_t1, B_t1, D_t1 ] = calc_expl_temp_matrices( M, C, K, time_step1 );
[ A_t2, B_t2, D_t2 ] = calc_expl_temp_matrices( M, C, K, time_step2 );
[ A_t3, B_t3, D_t3 ] = calc_expl_temp_matrices( M, C, K, time_step3 );

[u_solved1, v_solved1, a_solved1, f_solved1] = apply_explicit_dynamic_formulation(A_t1, B_t1, D_t1, u0, u_unknown, v0, a0, f_unknown, t, time_step1, n);
[u_solved2, v_solved2, a_solved2, f_solved2] = apply_explicit_dynamic_formulation(A_t2, B_t2, D_t2, u0, u_unknown, v0, a0, f_unknown, t, time_step2, n);
[u_solved3, v_solved3, a_solved3, f_solved3] = apply_explicit_dynamic_formulation(A_t3, B_t3, D_t3, u0, u_unknown, v0, a0, f_unknown, t, time_step3, n);

% Part b
gamma = 3 / 2;
beta = 8 / 5;

% % Apply implicit dynamic formulation
% [ A_t1, B_t1, C_t1, D_t1 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step1 );
% [ A_t2, B_t2, C_t2, D_t2 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step2 );
% [ A_t3, B_t3, C_t3, D_t3 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step3 );
% 
% [u_solved1, v_solved1, a_solved1, f_solved1] = apply_implicit_dynamic_formulation(A_t1, B_t1, C_t1, D_t1, u0, v0, a0, f_unknown, beta, gamma, t, time_step1, n);
% [u_solved2, v_solved2, a_solved2, f_solved2] = apply_implicit_dynamic_formulation(A_t2, B_t2, C_t2, D_t2, u0, v0, a0, f_unknown, beta, gamma, t, time_step2, n);
% [u_solved3, v_solved3, a_solved3, f_solved3] = apply_implicit_dynamic_formulation(A_t3, B_t3, C_t3, D_t3, u0, v0, a0, f_unknown, beta, gamma, t, time_step3, n);

% Place all the diagrams within one plot
hold all;
% Plot each diagram based on time
plot(t1, u_solved1);
plot(t2, u_solved2);
plot(t3, u_solved3);
% xlabel('Time (seconds)'); ylabel('Dunno asdflkjdsalfjl;');
