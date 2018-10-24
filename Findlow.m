function [ output_args ] = Findlow( input_args,threshold )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[m,n] = size(input_args);
output_args = zeros(1,n);
if length(threshold) == 1
    temp1 = zeros(m,n)+threshold;
else
    
    temp1 = zeros(m,n)+repmat(threshold,m,1);
end
temp2 = input_args-temp1;
for i = 1:n
    [~,count2] = find(temp2(:,i)<0);
    output_args(i) = sum(count2);
end


end

