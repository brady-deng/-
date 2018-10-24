function [ output_args ] = Findre( input_args )
%There are some unreliable periods in the UCD dataset. Sometimes the SpO2
%signal even goes down to 50%. So This script is for wiping off the
%unreliable periods. This function will return a matric with 1&0 to show
%whether this period is reliable. 1 indicates unreliable and 0 indicates
%reliable.
[m,n] = size(input_args);
temp = zeros(n,1);
%切除了信号开始600s的数据，因为该段信号可能不稳定
starttime = 600;
temp(1:starttime) = 1;
for i = 1:n
    for a = 1:m
        if input_args(a,i) < 50 || input_args(a,i) > 99.5
            temp(i) = 1;
        end
    end
end

output_args = temp;

end

