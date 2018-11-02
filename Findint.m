function [ dur ] = Findint( input_args,startp,endp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
l = length(startp);
dur = zeros(1,l-1);
for i = 1:l-1
    dur(i) = input_args(startp(i+1)) - input_args(endp(i));
end

end

