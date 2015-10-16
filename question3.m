clear all;
clc;

% Placeholder for variable
unknown = 111111111;

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
