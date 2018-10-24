function [ output_args ] = Findw( input_args,T,WT,fs )
%This function is for creating the seperated data with moving window.
%T is the data length;WT is the window length;fs is the sample prequence.

% m = T/WT;
l = length(input_args);
l2 = fix(l/fs);
l3 = fix((l2-T)/WT)+1;
output_args = zeros(T*fs,l3);
for i = 1:l3
    output_args(:,i) = input_args((i-1)*WT*fs+1:(i-1)*WT*fs+T*fs);
end

end

