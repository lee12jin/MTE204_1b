clear all;
clc;

% Placeholder for variable
unknown = 111111111;

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
      1;]; % displacement [m]
v0 = [0;
      0;]; % velocity [m/s]
a0 = [0;
      0;];% acceleration [m/s^2]
f0 = [unknown;
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
t1 = linspace(0, t, t/time_step1);
t2 = linspace(0, t, t/time_step2);
t3 = linspace(0, t, t/time_step3);

% Part b
gamma = 3 / 2;
beta = 8 / 5;

% Apply implicit dynamic formulation
[ A_t1, B_t1, C_t1, D_t1 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step1 );
[ A_t2, B_t2, C_t2, D_t2 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step2 );
[ A_t3, B_t3, C_t3, D_t3 ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step3 );
[u1, v1, a1] = apply_implicit_dynamic_formulation(A_t1, B_t1, C_t1, D_t1, u0, v0, a0, f0, beta, gamma, t, time_step1);
[u2, v2, a2] = apply_implicit_dynamic_formulation(A_t2, B_t2, C_t2, D_t2, u0, v0, a0, f0, beta, gamma, t, time_step2);
[u3, v3, a3] = apply_implicit_dynamic_formulation(A_t3, B_t3, C_t3, D_t3, u0, v0, a0, f0, beta, gamma, t, time_step3);

% Place all the diagrams within one plot
hold all;
% Plot each diagram based on time
% plot(t1, u1);
% plot(t2, u2);
% plot(t3, u3);
xlabel('Time (seconds)'); ylabel('Dunno asdflkjdsalfjl;');
