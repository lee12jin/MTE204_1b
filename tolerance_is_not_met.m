function [ bool ] = tolerance_is_not_met(x, x_old, tolerance)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sum_of_error = 0;
bool = 0;
for i=1:length(x)
    sum_of_error = sum_of_error + (abs(x(i) - x_old(i))/abs(x(i)));
end
if(sum_of_error < tolerance)
    bool = 0;
else
    bool = 1;
end    
end

