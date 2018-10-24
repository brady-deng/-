function [ output_args ] = Findse( input_args )
%   This function is to find the starting and ending period in the
%   respiratory nasal flow signal.
l = length(input_args);
output_args = input_args;
for i = 2:l-1
    if input_args(i) == 0&&input_args(i+1) == 1
        output_args(i) = 2;
    else if input_args(i) == 0&&input_args(i-1) == 1
        output_args(i) = 2;
        end
    end
end

end

