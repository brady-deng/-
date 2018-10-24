clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for combining all subjects' features into one mat file
%   and can be used for train one net to overcome the unbalanced
%   subdataset.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 23;
T = input('Please input the feature file''s name you want to combine:');

s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',T,'.mat'');'];
eval(s1);
d.ft = [];
d.at = [];
for i = 1:N
    s2 = ['d.ft = [d.ft,d.f.f',num2str(i),'];'];
    s3 = ['d.at = [d.at;d.an.a',num2str(i),'];'];
    eval(s2);
    eval(s3);
end

name = input('Please input the feature file name you want to save:');
s4 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'',''d'');'];
eval(s4);
