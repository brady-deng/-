function [ output_args ] = antotra( input_args )
%This function can transfor the annotation with 0&1 to the annotation for
%neural network training 01&10.
%Last editted by Brady Deng

l = length(input_args);
output_args = zeros(2,l);
for i = 1:l
    if input_args(i)>0
        output_args(1,i) = 1;
    else
        output_args(2,i) = 1;
    end
end

end

