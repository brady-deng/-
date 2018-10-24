clc;
close all;
clear;


a = ones(1,10);
b = [1,2,3,4,5,0,0,0,0,1];
c = 0;
d = 0;
for i = 1:10
    if a(i) == b(i) == 1
      c = c+1;
    else d = d+1;
    end
end

