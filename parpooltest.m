clc;
clear;
close all;
a = 1000000;

tic;
for i = 1:a
    fprintf('%d\r\n',i);
end
toc;

startmatlabpool(4);
tic;
parfor i = 1:a
    fprintf('%d\r\n',i);
end
toc;
closematlabpool;