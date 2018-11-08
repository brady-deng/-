function [ ind ] = Findflow( input_args,T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
count = 0;
startflag = 0;
endflag = 0;
% indstart = [];
% indend = [];
ind = [];
templ = length(input_args);
fs = 8;
for i = 2: length(input_args)
    if abs(input_args(i))<0.05 && abs(input_args(i-1)) > 0.05
        startflag = 1;
        tempstart = i;
    elseif abs(input_args(i))>0.05 && abs(input_args(i-1))<0.05
        tempend = i;
        endflag = 1;
    end
    if startflag == 1 && endflag == 1
        count = tempend - tempstart;
        startflag = 0;
        endflag = 0;
        if count > 240
            if tempstart > T*fs && tempend < templ - T*fs
                ind = [ind,tempstart-T*fs:tempend+T*fs];
            elseif tempstart < T*fs
                ind = [ind,1:tempend+T*fs];
            elseif tempend > templ - T*fs
                ind = [ind,1:tempstart-T*fs:templ];
            end
        end
    end
end
tempind = find(input_args>18.5);
indflow = zeros(1,templ);
for k = 1:length(tempind)
    if tempind(k) > T*fs && tempind(k) < (templ - T*fs)
        indflow(tempind(k)-T*fs:tempind(k)+T*fs) = 1;
    end
end
flowdel = find(indflow == 1);
ind = union(ind,flowdel);
[startp,endp] = Finddur(ind);
inter = Findint(ind,startp,endp);
ind = Findmer(ind,inter,startp,endp,120*8);



end

