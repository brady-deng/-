function [ startp,endp ] = Finddur( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tempdif = diff(input_args);
tempob = find(tempdif ~= 1);
tempob = reshape(tempob,[],1);
startp = [1;tempob+1];
endp = [tempob;length(input_args)];


end

