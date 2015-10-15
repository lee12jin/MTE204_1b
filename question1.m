clear all;
clc;

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

% Damper value for each node pair (N/s)
c = [1];

% Spring constant for each node pair (N/m)
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
