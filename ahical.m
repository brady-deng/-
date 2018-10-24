function [ output_args,start,endcache ] = ahical( label )
%   计算标签中的总的事件数目，返回的output_args是总的事件数目
%   start是时间开始时间，endcache是时间结束时间，label输入是
%   输入的标签
%   Detailed explanation goes here
l = length(label);
startflag = 0;
endflag = 0;
aha = 0;
start = zeros(1,400);
endcache = zeros(1,400);
c = 1;
for i = 1:l-1
    if label(i) == 0 && label(i+1) == 1
        startflag = 1;
        endflag = 0;
        tempstart = i;
    end
    if label(i) == 1&& label(i+1) == 0
        startflag = 0;
        endflag = 1;
        tempend = i;
    end
    if endflag == 1&&startflag == 0
        aha = aha+1;
        start(c) = tempstart;
        endcache(c) = tempend;
        c = c+1;
        startflag = 0;
        endflag = 0;
    end
end
output_args = aha;
        


end

