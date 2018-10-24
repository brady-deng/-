clc;
clear;
close all;

d = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\resultofknn.mat');


[m,n] = size (d);
N = 10;
num = m/N;
res = zeros(num,12);
for i = 1:num
    res(i,:) = sum(d(N*(i-1)+1:N*i,:));
    res(i,10) = 100*res(i,8)/res(i,5);
    res(i,11) = 100*res(i,7)/res(i,4);
    res(i,12) = 100*res(i,6)/res(i,3);
end