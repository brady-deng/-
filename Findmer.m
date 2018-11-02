function [ output_args ] = Findmer( input_args, inter, startp, endp, thre )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
l = length(inter);
output_args = [];
for i = 1:l
    if inter(i) < thre
        temp = input_args(startp(i)):input_args(endp(i+1));
        temp = reshape(temp,[],1);
        output_args = [output_args;temp];
    else
        temp1 = input_args(startp(i):endp(i));
        temp2 = input_args(startp(i+1):endp(i+1));
        temp1 = reshape(temp1,[],1);
        temp2 = reshape(temp2,[],1);
        temp = [temp1;temp2];
        output_args = [output_args;temp];
    end
end
output_args = unique(output_args);

end

