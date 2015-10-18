clear all;
clc;

syms f_1 u_2
unknown = sqrt(-1);

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
          unknown;]; % displacement after first timestep
v0 = [0;
      0;]; % velocity [m/s]
a0 = [0;
      0;];% acceleration [m/s^2]
f_unknown = [unknown;
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
[u_solved1, v_solved1, a_solved1, f_solved1] = apply_explicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, t, time_step1, n);
[u_solved2, v_solved2, a_solved2, f_solved2] = apply_explicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, t, time_step2, n);
[u_solved3, v_solved3, a_solved3, f_solved3] = apply_explicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, t, time_step3, n);

% Part b
gamma = 3 / 2;
beta = 8 / 5;

% % Apply implicit dynamic formulation
% [u_solved1, v_solved1, a_solved1, f_solved1] = apply_implicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, beta, gamma, t, time_step1, n);
% [u_solved2, v_solved2, a_solved2, f_solved2] = apply_implicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, beta, gamma, t, time_step2, n);
% [u_solved3, v_solved3, a_solved3, f_solved3] = apply_implicit_dynamic_formulation(M, K, C, u0, u_unknown, v0, a0, f_unknown, beta, gamma, t, time_step3, n);

% Place all the diagrams within one plot
hold all;
% Plot each diagram based on time
p1 = plot(t1, u_solved1(2, :), 'DisplayName', 'Time step = 0.01');
p2 = plot(t2, u_solved2(2, :), 'DisplayName', 'Time step = 0.1');
p3 = plot(t3, u_solved3(2, :), 'DisplayName', 'Time step = 1');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 1: Results of Explicit Dynamic Formulation')
