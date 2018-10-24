function [ out1,out2 ] = Findmax( input_args,T )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(input_args);
ob = sort(input_args);
msx = ob(end - 1,:);
msn = ob(2,:);
% msx = prctile(input_args,95);
% msn = prctile(input_args,5);
% msx = max(input_args(1:floor(m/2),:));
% msn = min(input_args(1:floor(m/2),:));
out1 = msx;
out2 = msn;
for i = T:n
    tempmax = zeros(1,T);
    tempmin = zeros(1,T);
    for k = 1:T
        tempmax(k) = msx(i-T+k);
        tempmin(k) = msn(i-T+k);
    end
    out1(i) = max(tempmax);
    out2(i) = min(tempmin);
end



end

