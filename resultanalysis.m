clc;
clear;
close all;

N = 11;


res = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\result1-28(the result of a net for the whole dataset).mat');
[m,n] = size(res.stanwos.n1.data);
reswos = zeros(m,n);
resws = zeros(m,n);
for i = 1:N
    s1 = ['reswos(:,1:10) = res.stanwos.n',num2str(i),'.data(:,1:10) + reswos(:,1:10);'];
    s2 = ['resws(:,1:10) = res.stanws.n',num2str(i),'.data(:,1:10) + resws(:,1:10);'];
    
    eval(s1);
    eval(s2);
end

reswos(:,11) = 100*reswos(:,9)./(reswos(:,9)+reswos(:,10));
reswos(:,12) = 100*reswos(:,8)./reswos(:,6);
reswos(:,13) = 100*reswos(:,7)./reswos(:,5);

resws(:,11) = 100*resws(:,9)./(resws(:,9)+resws(:,10));
resws(:,12) = 100*resws(:,8)./resws(:,6);
resws(:,13) = 100*resws(:,7)./resws(:,5);
