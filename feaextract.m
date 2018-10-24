clc;
clear;
close all;
N = 23;
feafile = input('Please input the feature file you want to extract:');
s971 = ['f = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',feafile,'.mat'');'];
eval(s971);
temp3 = [3,6,15,16,17,18];
for i = 1:N
    s1 = ['f.f.f',num2str(i),'(temp3,:) = [];'];
    eval(s1);
end
s972 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',feafile,'.mat'',''f'');'];
eval(s972);
