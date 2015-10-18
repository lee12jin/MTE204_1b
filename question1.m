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
time_steps = [0.01;
              0.1;
              1;];     
gamma = 3 / 2;
beta = 8 / 5;          

for i = 1:3
    time_step = time_steps(i,1);
    % Create time vectors
    t_space = linspace(0, t, t/time_step + 1);

    u = zeros(n, t / time_step + 1);
    v = zeros(n, t / time_step + 1);
    a = zeros(n, t / time_step + 1);
    f = zeros(n, t / time_step + 1);
    
    % Initial conditions
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1); 
    
    % Applied force
    f(2, :) = 10 * ones(1, t / time_step + 1);
    
    [u_expl, v_expl, a_expl, f_expl] = apply_explicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, t, time_step, n);
    [u_impl, v_impl, a_impl, f_impl] = apply_implicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, beta, gamma, t, time_step);
%     To store values on each iteration
    if i == 1
        u1_expl = u_expl;
        u1_impl = u_impl;
        t1 = t_space;
        label = 'Time step = 0.01';
    elseif i == 2
        u2_expl = u_expl;
        u2_impl = u_impl;
        t2 = t_space;
        label = 'Time step = 0.1';
    else
        u3_expl = u_expl;
        u3_impl = u_impl;
        t3 = t_space;
        label = 'Time step = 1';
    end
        
end

% Part A
hold all;

figure(1);
p1 = plot(t1, u1_expl(2, :), 'DisplayName', 'Time step = 0.01');
p2 = plot(t2, u2_expl(2, :), 'DisplayName', 'Time step = 0.1');
p3 = plot(t3, u3_expl(2, :), 'DisplayName', 'Time step = 1');

% Place all the diagrams within one plot
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 1: Results of Explicit Dynamic Formulation')

% Part B
hold off;
figure(2);
hold all;
p4 = plot(t1, u1_impl(2, :), 'DisplayName', 'Time step = 0.01');
p5 = plot(t2, u2_impl(2, :), 'DisplayName', 'Time step = 0.1');
p6 = plot(t3, u3_impl(2, :), 'DisplayName', 'Time step = 1');

% Place all the diagrams within one plot
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 1: Results of Implicit Dynamic Formulation')
