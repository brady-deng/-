clc;
clear;
close all;

N = 11;


res = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\result1-28(the result of a net for the whole dataset).mat');
[m,n] = size(res.stanwos.n1);
reswos = zeros(N+1,n);
resws = zeros(N+1,n);
for i = 1:N
    s1 = ['reswos(i,:) = res.stanwos.n',num2str(i),'(:,:);'];
    s2 = ['resws(i,:) = res.stanws.n',num2str(i),'(:,:);'];
    
    eval(s1);
    eval(s2);
end

reswos(N+1,:) = sum(reswos(1:N,:));
resws(N+1,:) = sum(resws(1:N,:));

reswos(N+1,11) = 100*reswos(N+1,7)./(reswos(N+1,5)+reswos(N+1,6));
reswos(N+1,12) = 100*reswos(N+1,9)./reswos(N+1,6);
reswos(N+1,13) = 100*reswos(N+1,10)./reswos(N+1,5);

resws(N+1,11) = 100*resws(N+1,7)./(resws(N+1,5)+resws(N+1,6));
resws(N+1,12) = 100*resws(N+1,9)./resws(N+1,6);
resws(N+1,13) = 100*resws(N+1,10)./resws(N+1,5);
