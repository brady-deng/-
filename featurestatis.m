clc;
clear;
close all;

name = input('Please input the feature name you want to analyze:');
s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
eval(s1);
N = 23;
for i = 1:N
    s1 = ['l(i,1) = length(d.an.a',num2str(i),');'];
    s2 = ['l(i,2) = sum(d.an.a',num2str(i),');'];
    s3 = ['l(i,3) = sum(~d.an.a',num2str(i),');'];
    eval(s1);
    eval(s2);
    eval(s3);
end

l(N+1,:) = sum(l);
l(N+2,:) = l(N+1,:)./N;
       