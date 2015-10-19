clear all;
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
time_step = 0.01;

len = round(t / time_step) + 1;


% Create time vectors
    t_space = linspace(0, t, len);

    u = zeros(n * dof, len);
    v = zeros(n * dof, len);
    a = zeros(n * dof, len);
    f = zeros(n * dof, len);
    
    % Initial conditions
%     u(:, 1) = zeros(n
%     v(:, 1) = v0;
%     a(:, 1) = a0;
%     f(:, 1) = zeros(n * dof, 1); 
    
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
    
    [u_expl, v_expl, a_expl, f_expl] = apply_explicit_dynamic_formulation(M, K, C, u, v, a, f, u_unknown, f_unknown, t, time_step, n, 3, dof, omega(3));    

    postprocesser(coords(:,1).', coords(:,2).', sctr.', u_expl(:, 501))