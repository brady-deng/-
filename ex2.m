%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script is for training the neural net. Finally we can get a neural
% network for pattern recognition.
% This script can use the feature extracted both physionet and the dream.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;

%% 数据准备
fs = 100;
T = 60;



%% For the physionet derivaed by 1 min using the features extracted for testing
data1 = importdata('E:\文档\呼吸机\MATLAB程序\数据\optimized feature.mat');
data2 = importdata('E:\文档\呼吸机\MATLAB程序\数据\annotationtest.mat');

input = data1.feature;
output = data2.anno_test;



%%
%   The following codes are to do some work about k-fold-validation

% indices = crossvalind('Kfold',output,10);
% 
% for i = 1:10
%     test = (indices == i);
%     train = ~test;
%     data_train = input(:,train);
%     data_test = output(:,test);
%     out_train = output(train);
%     out_test = output(test);
% end

%%
%   Here is to transform the annotations to the data that can be used as
%   the neural network output.
[m,n] = size(output');
% output_data = output';

output_data = zeros(2*m,n);
for i=1:n
    if output(i)>0
        output_data(1,i) = 1;
    else
        output_data(2,i) = 1;
    end
end


%% 构造训练集测试集
p_train = 0.9;
n_train = fix(n*p_train);
n_test = n-n_train;


k = rand(m,n);
[a,b] = sort(k);
input_train = input(:,b(1:n_train));
output_train = output_data(:,b(1:n_train));
input_test = input(:,b(n_train+1:end));
output_test = output_data(:,b(n_train+1:end));

[inputn,inputps] = mapminmax(input_train);
% inputn = input_train;
[outputn,outputps] = mapminmax(output_train);



%% 数据分析
n_health = 0;
n_apnea = 0;
ntrain_h = 0;
ntrain_a = 0;
ntest_h = 0;
ntest_a = 0;
[m,n] = size(output);
for i=1:n
    if output(i)>0
        n_apnea = n_apnea+1;
    else
        n_health = n_health+1;
    end
end
[m,n] = size(output_train);
for i=1:n
    if output_train(1,i)>0
        ntrain_a = ntrain_a+1;
    else
        ntrain_h = ntrain_h+1;
    end
end
[m,n] = size(output_test);
for i=1:n
    if output_test(1,i)>0
        ntest_a = ntest_a+1;
    else
        ntest_h = ntest_h+1;
    end
end

%% BP网络训练
% %初始化网络结构
net=newff(minmax(inputn),[8,5,2]);
% feedforwardnet
net.trainParam.epochs=1000;      %%迭代次数
net.trainParam.lr=0.1;          %%学习率
net.trainParam.goal=0.000000001;    %%目标
net.trainParam.max_fail = 100;
net.trainParam.min_grad = 1e-11;

%网络训练
net=train(net,inputn,outputn);

%% BP网络预测
%预测数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
% inputn_test = input_test; 

%网络预测输出
an=sim(net,inputn_test);
 
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

[m,n] = size(BPoutput);
for i=1:n
    if BPoutput(1,i)>BPoutput(2,i)
        BPoutput(1,i) = 1;
        BPoutput(2,i) = 0;
    else
        BPoutput(1,i) = 0;
        BPoutput(2,i) = 1;
    end
end


%% 结果分析

figure(1)
plot(BPoutput(1,:),':og')
hold on
plot(output_test(1,:),'-*');
legend('预测输出','期望输出')
title('BP网络预测输出','fontsize',12)
ylabel('函数输出','fontsize',12)
xlabel('样本','fontsize',12)
%预测误差

n_error = 0;
t_positive = 0;
t_negative = 0;

for i=1:n
    if BPoutput(1,i)~=output_test(1,i)
        n_error = n_error+1;
    end
    if (BPoutput(1,i) == output_test(1,i) && BPoutput(1,i) == 0)
        t_negative = t_negative + 1;
    end
    if (BPoutput(1,i) == output_test(1,i) && BPoutput(1,i) == 1)
        t_positive = t_positive + 1;
    end
end

disp('正确率:');
disp((1-n_error/n_test)*100);
disp('真阳率:');
disp(100*t_positive/ntest_a);
disp('True negative:');
disp(100*t_negative/ntest_h);


