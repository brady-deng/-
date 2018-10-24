function [ output_args ] = TFcal( input_args,T,FT,fs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[a,b] = size(input_args);
FTs = FT*fs;
num = T/FT;
d = zeros(num,b);
output_args = zeros(num-1,b);
for c = 1:num
    d(c,:) = sum(abs(input_args((c-1)*FTs+1:c*FTs,:)));
end
for c = 1:num-1
    output_args(c,:) = d(c+1,:)-d(c,:);
end
    
end

