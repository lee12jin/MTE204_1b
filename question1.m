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

% External force applied at each node (N)
f = [0;
     10;];
 
% Initial velocity
v0 = 0;

% Size of the global matrices
size = dof * n;

% Initializing global matrices
M = zeros(size);
C = zeros(size);
K = zeros(size);

% Create the local C and K matrices
[l_C, l_K] = populate_element_props( sctr, coords, c, k, dof );

% Part b
time_step1 = 0.01;
time_step2 = 0.1;
time_step3 = 1;
gamma = 3 / 2;
beta = 8 / 5;

% Apply implicit dynamic formulation
[ A_t, B_t, C_t, D_t ] = calculate_implicit_temporary_matrices( M, K, C, beta, gamma, time_step1 );

% Create time vectors
t1 = linspace(0, 5, 5/time_step1);
t2 = linspace(0, 5, 5/time_step2);
t3 = linspace(0, 5, 5/time_step3);

% Place all the diagrams within one plot
hold all;
% Plot each diagram based on time
% plot(t1, y1);
% plot(t2, y2);
% plot(t3, y3);
xlabel('Time (seconds)'); ylabel('Dunno asdflkjdsalfjl;');
