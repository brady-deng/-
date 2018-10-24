%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   result analysis. last editted 9-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;

N = 1;
rea = load('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\result99.mat');
for i = 1:N
    reasult(i,:) = sum(rea.rea{i});
    reasult(i,10) = 100*reasult(i,6)/reasult(i,3);
    reasult(i,11) = 100*reasult(i,8)/reasult(i,4);
    reasult(i,12) = 100*reasult(i,9)/reasult(i,5);
end
reasult(N+1,:) = sum(reasult);
reasult(N+1,10) = 100*reasult(N+1,6)/reasult(N+1,3);
reasult(N+1,11) = 100*reasult(N+1,8)/reasult(N+1,4);
reasult(N+1,12) = 100*reasult(N+1,9)/reasult(N+1,5);
