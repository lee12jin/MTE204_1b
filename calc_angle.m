function [ theta ] = calc_angle( x1, y1, x2, y2 )
%CALC_ANGLE Summary of this function goes here
%   Detailed explanation goes here

    theta = atan((y2-y1)/(x2-x1));

end

