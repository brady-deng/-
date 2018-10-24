function [ output_args ] = Findpeak( input_args )
%Find the number of the peak of the signal
%   Detailed explanation goes here

temp = diff(input_args);
[m,n] = size(temp);
output_args = zeros(1,n);
for i =1:n
    for k = 2:m-1
        if temp(k-1,i)>0 && temp(k,i)<0
            output_args(i) = output_args(i)+1;
        end
    end
end

end

