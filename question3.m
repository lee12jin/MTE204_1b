clear all;
close all;
clc;

% Placeholder for variable
unknown = sqrt(-1);

dof = 2;

[ sctr, coords, E, A, rho, c ] = read_input();

% Number of elements
e = size(sctr, 1);

% Number of nodes
n = size(coords, 1);

% Length of each element
lengths = ones(e, 1);
% Stiffness for each element
k = ones(e, 1);

for element = 1:e
    node1 = sctr(element, 1);
    node2 = sctr(element, 2);
    
    x1 = coords(node1, 1);
    y1 = coords(node1, 2);
    x2 = coords(node2, 1);
    y2 = coords(node2, 2);
    
    lengths(element, 1) = calc_distance( x1, y1, x2, y2 );
    k(element,1) = A(element, 1) * E(element, 1) / lengths(element, 1);
end

[ l_C, l_K ] = populate_element_props( sctr, coords, c, k, dof );

% Mass of each node
m = find_node_mass( n, sctr, rho, A, lengths );

[M, C, K] = build_global_matrices( sctr, m, l_C, l_K, n, e, dof );

% Frequencies (rad/ms)
omega = [0.1;
         1;
         10;];

% Total time (ms)
t = 500;

% Time step (ms)
time_step = 0.1;

len = round(t / time_step) + 1;

% Create time vector
t_space = linspace(0, t, len);

for i = 1:3
    u = zeros(n * dof, len);
    v = zeros(n * dof, len);
    a = zeros(n * dof, len);
    f = zeros(n * dof, len);
    
    u_unknown = [0;
                 unknown;
                 0;
                 unknown;
                 unknown;
                 unknown;
                 unknown;
                 unknown;
                 0;
                 unknown;];
    
    f_unknown = [unknown;
                 0;
                 unknown;
                 0;
                 0;
                 0;
                 0;
                 0;
                 unknown;
                 0;];
    
    [u_expl, v_expl, a_expl, f_expl] = apply_explicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, t, time_step, n, 3, dof, omega(i));    

    if i == 1
        u1 = u_expl;
        v1 = v_expl;
        a1 = a_expl;
    elseif i == 2
        u2 = u_expl;
        v2 = v_expl;
        a2 = a_expl;
    else
        u3 = u_expl;
        v3 = v_expl;
        a3 = a_expl;
    end
end

figure(1);
hold all;
p1 = plot(t_space, u1(4, :), 'DisplayName', 'Omega = 0.1');
p2 = plot(t_space, u2(4, :), 'DisplayName', 'Omega = 1');
p3 = plot(t_space, u3(4, :), 'DisplayName', 'Omega = 10');
legend(gca, 'show');
xlabel('Time (ms)'); ylabel('Displacement (mm)');
title('Question 3: Nodal Displacement of Node 2');
hold off;
figure(2);
hold all;
p4 = plot(t_space, v1(4, :), 'DisplayName', 'Omega = 0.1');
p5 = plot(t_space, v2(4, :), 'DisplayName', 'Omega = 1');
p6 = plot(t_space, v3(4, :), 'DisplayName', 'Omega = 10');
legend(gca, 'show');
xlabel('Time (ms)'); ylabel('Velocity (mm/ms)');
title('Question 3: Nodal Velocity of Node 2');
hold off;
figure(3);
hold all;
p7 = plot(t_space, a1(4, :), 'DisplayName', 'Omega = 0.1');
p8 = plot(t_space, a2(4, :), 'DisplayName', 'Omega = 1');
p9 = plot(t_space, a3(4, :), 'DisplayName', 'Omega = 10');
hold off;
legend(gca, 'show');
xlabel('Time (ms)'); ylabel('Acceleration (mm/ms^2)');
title('Question 3: Nodal Acceleration of Node 2');

x = coords(:, 1).';
y = coords(:, 2).';

% postprocesser(x, y, sctr.', u3(:,5001).');
% postprocesser(x, y, sctr.', u2(:,5001).');
% postprocesser(x, y, sctr.', u3(:,5001).');

