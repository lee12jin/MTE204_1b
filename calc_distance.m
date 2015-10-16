function [ d ] = calc_distance( x1, y1, x2, y2 )
% Calculates the distance between 2 nodes

    d = sqrt((x2-x1)^2 + (y2-y1)^2);

end

