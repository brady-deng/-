function [ tempind,tempans ] = breathphse( input_args )
%segment the phase of the flow signal
%   Detailed explanation goes here
[m,n] = size(input_args);
temp = diff(input_args);
rfs = 8;
waitsec = 0.4;
waittime = floor(waitsec*rfs);
numcount = 50;
for i = 1:n
    c = 1;
    for count = 3:m-2
        if numcount < waittime
            numcount = numcount+1;
            continue
        else
%             if temp(count-1,i)<=0 && temp(count-2,i)<=0 &&temp(count-3,i)<=0 &&temp(count-4,i)<=0 && temp(count-5,i)<=0 && temp(count,i)>=0 && temp(count+1,i)>=0 && temp(count+2,i)>=0 && temp(count+3,i)>=0
%             if temp(count-1,i)<=0 && temp(count-2,i)<=0 &&temp(count-3,i)<=0 && temp(count,i)>=0 && temp(count+1,i)>=0 && temp(count+2,i)>=0
            if temp(count-1,i)<=0 && temp(count-2,i)<=0 && temp(count,i)>=0 && temp(count+1,i)>=0
                tempind{i}(c) = count;
                tempans(c,i) = input_args(count,i);
    %             tempans{i}(c) = input_args(count,i);
                c = c+1;
                numcount = 0;
            end
%             if temp(count-1,i)>=0 &&temp(count-2,i)>=0  &&temp(count-3,i)>=0 && temp(count,i)<=0&& temp(count+1,i)<=0 && temp(count+2,i)<=0
            if temp(count-1,i)>=0 &&temp(count-2,i)>=0 && temp(count,i)<=0&& temp(count+1,i)<=0
                tempind{i}(c) = count;
                tempans(c,i) = input_args(count,i);
    %             tempans{i}(c) = input_args(count,i);
                c = c+1;
                numcount = 0;
            end
        end
%         numcount = numcount+1;
    end
end



end

