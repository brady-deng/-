function [ output_args ] = Findh( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(input_args);
output_args = zeros(1,n);
for i = 1:n
    for a = 1:m
        if abs(input_args(a,i))>5
            output_args(i) = output_args(i)+1;
        end
    end
end

end

