clc;
clear;
close all;

d = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\resultofSVMwithoutSMOTE.mat');

N = 10;
svmot = zeros(24,13);
svmwt = zeros(1,13);
for i = 0:10
    s1 = ['svmot = svmot+d.svmor.r',num2str(i),';'];
    s2 = ['svmwt = svmwt+d.svmwr.r',num2str(i),';'];
    eval(s1);
    eval(s2);
end
svmot(:,11) = svmot(:,11)./11;
svmot(:,12) = svmot(:,12)./11;
svmot(:,13) = svmot(:,13)./11;
svmot(24,11) = 100*(svmot(24,9)+svmot(24,10))/svmot(24,8);
svmot(24,12) = 100*svmot(24,10)/svmot(24,6);
svmot(24,13) = 100*svmot(24,9)/svmot(24,5);

svmwt(1,11) = 100*svmwt(1,7)/(svmwt(1,5)+svmwt(1,6));
svmwt(1,12) = 100*svmwt(1,9)/svmwt(1,6);
svmwt(1,13) = 100*svmwt(1,10)/svmwt(1,5);