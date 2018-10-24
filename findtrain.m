function [ output1,output2 ] = findtrain( input1,input2 )
%   This function aims to find the real apnea period in the data and
%   exclude the apnea starting and ending time.

l = length(input2);
a = 1;

for i =1:l
    if input2(i) == 1 || input2(i) == 0
        label(a) = i;
        a = a+1;
    end
end
output1 = input1(:,label);
output2 = input2(label);

end

