function [ splowind ] = durextern( splow,startp,endp,thre,templ )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l = length(startp);
rfs = 8;
st = startp;
et = endp;
splowind = [];
for i = 1:l
    if (splow(startp(i))-thre*rfs) > 0
        st(i) = splow(startp(i))-thre*rfs;
    else
        st(i) = 1;
    end
    if (splow(endp(i))+thre*rfs) < templ
        et(i) = splow(endp(i))+thre*rfs;
    else
        et(i) = templ;
    end
    splowind = [splowind,st(i):et(i)];
end
splowind = unique(splowind);

end

