clc;
clear;
close all;


load fisheriris
indices = crossvalind('Kfold',species,10); 
cp = classperf(species); 
for i = 1:10
      test = (indices == i); train = ~test;    %分别取第1、2、...、10份为测试集，其余为训练集
      class = classify(meas(test,:),meas(train,:),species(train,:));
      classperf(cp,class,test);
end
cp.ErrorRate     %查询错误分类率