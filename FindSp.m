function [ out ] = FindSp( input_args,T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(input_args);
temp = round(input_args(1:5,:));
tempmax = max(temp);
% tempmax = mode(temp);
out = tempmax;
for i =  T:n
    cache = zeros(1,T);
    for k = 1:T
        cache(k) = tempmax(i-T+k);
    end
    out(i) = max(cache);
end


end

