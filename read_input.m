function [ sctr, coords, E, A, rho, c ] = read_input( )
% Reads the input data from the given txt files

    % Directory of the input files
    base_dir = 'ProjectIb_Student_Package';

    sctr = csvread(sprintf('%s/sctr.txt', base_dir));

    coords = csvread(sprintf('%s/nodes.txt', base_dir));
    % Removing the extra column created when reading file
    coords = coords(:,1:2);
    
    % Temporarily changed 1E2.00000 -> 1E2 to read input
    props = csvread(sprintf('%s/props.txt', base_dir));
    
    % Elastic modulus (MPa)
    E = props(:, 1);
    % Cross sectional area (mm^2)
    A = props(:, 2);
    % Density (g/mm^3)
    rho = props(:, 3);
    % Damping (N/msec)
    c = props(:, 4);

end

