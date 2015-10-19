clear all;
clc; 

unknown = sqrt(-1);

% Solves dynamic loading of a generic 1D dynamic bar
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

u_unknown = [0;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;
             unknown;];   
       
         
v0 = zeros(dof * n, 1); % velocity [m/s]
a0 = zeros(dof * n, 1); % acceleration [m/s^2]

% f_unknown = [f_1;
%             %.. 2 - 10 are 0
%              10;]; % force [N]

% Part a - explicit

% [u_solved1, v_solved1, a_solved1, f_solved1] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(1), n * dof);
% [u_solved2, v_solved2, a_solved2, f_solved2] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(2), n * dof);
% [u_solved3, v_solved3, a_solved3, f_solved3] = apply_explicit_dynamic_formulation_b(M, C, K, u0, v0, a0, t, delta_t(3), n * dof);
% Part b - implicit




% Total time (seconds)
t = 5;

% Time increments
time_steps = [0.1;
              0.001;
              0.00001;];
time_expl = zeros(3, 1);
time_impl = zeros(3, 1);
gamma = 3 / 2;
beta = 8 / 5;          

for i = 1:3
    time_step = time_steps(i,1);
    len = round(t / time_step ) + 1;
    % Create time vectors
    t_space = linspace(0, t, len);

    u = zeros(n, len);
    v = zeros(n, len);
    a = zeros(n, len);
    f = zeros(n, len);
    
    % Initial conditions
    u(:, 1) = u0;
    v(:, 1) = v0;
    a(:, 1) = a0;
    f(:, 1) = zeros(n, 1); 
    
    f_unknown = [unknown;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;
                 0;];
    tic
    [u_expl, v_expl, a_expl, f_expl] = apply_explicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, t, time_step, n, 2);
    time_expl(i) = toc;
    tic
    [u_impl, v_impl, a_impl, f_impl] = apply_implicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, beta, gamma, t, time_step, n, 2);
    time_impl(i) = toc;
%     To store values on each iteration
    if i == 1
        u1_expl = u_expl;
        u1_impl = u_impl;
        t1 = t_space;
    elseif i == 2
        u2_expl = u_expl;
        u2_impl = u_impl;
        t2 = t_space;
    else
        u3_expl = u_expl;
        u3_impl = u_impl;
        t3 = t_space;
    end
        
end

% Part A

figure(1);
p1 = plot(t1, u1_expl(2, :), 'DisplayName', 'Time step = 0.1');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Explicit Dynamic Formulation');

figure(2);
p2 = plot(t2, u2_expl(2, :), 'DisplayName', 'Time step = 0.001');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Explicit Dynamic Formulation');

figure(3);
p3 = plot(t3, u3_expl(2, :), 'DisplayName', 'Time step = 0.00001');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Explicit Dynamic Formulation');

% Part B
figure(4);
p4 = plot(t1, u1_impl(2, :), 'DisplayName', 'Time step = 0.1');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Implicit Dynamic Formulation');

figure(5);
p5 = plot(t2, u2_impl(2, :), 'DisplayName', 'Time step = 0.001');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Implicit Dynamic Formulation');

figure(6);
p6 = plot(t3, u3_impl(2, :), 'DisplayName', 'Time step = 0.00001');
legend(gca, 'show');
xlabel('Time (seconds)'); ylabel('Displacement (meters)');
title('Question 2: Results of Implicit Dynamic Formulation');

