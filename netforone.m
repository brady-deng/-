%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A script for training the neural net for pattern identification. The d is
% the features and annotations extracted before.
% Pay attention that this script is to build neural net for every seperate
% data, thus finally we will get 12 neural nets.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;


%% 数据准备
fs = 128;
T = 60;
N = 1;
n_sta = 20;




%% Here we use the Dreams data and the data here is derivaed into 9s
d = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\2f60.mat');

data2 = d.an;
data = d.f;



for i=1:N
%     s1 = ['input.in',num2str(i),'= data.t',num2str(i)];
%     s2 = ['output.ou',num2str(i),'= data2.a',num2str(i)];
    s2 = ['[input.in',num2str(i),',output.ou',num2str(i),'] = findtrain(data.f',num2str(i),',data2.a',num2str(i),');'];
    s3 = ['[data_size(',num2str(i),',1),data_size(',num2str(i),',2)] = size(input.in',num2str(i),');'];
    s4 = ['trainout.ou',num2str(i),'=zeros(2,data_size(',num2str(i),',2))'];
%     eval(s1);
%     eval(s2);
    eval(s2);
    eval(s3);
    eval(s4);
end

for a = 1:N
    for i=1:data_size(a,2)
        s1 = ['if output.ou',num2str(a),'(',num2str(i),')>0 trainout.ou',num2str(a),'(1,',num2str(i),') = 1;else trainout.ou',num2str(a),'(2,',num2str(i),') = 1;end'];
        eval(s1);

    end
end

%% 构造训练集测试集
p_train = 0.7;
n_train = zeros(N,1);
n_test = zeros(N,1);
for i=1:N
    n_train(i) = fix(data_size(i,2)*p_train);
    n_test(i) = data_size(i,2)-n_train(i);
    s1 = ['k.k',num2str(i),'=rand(1,data_size(i,2))'];
    s2 = ['[a.a',num2str(i),',b.b',num2str(i),'] = sort(k.k',num2str(i),');'];
    s3 = ['input_train.in',num2str(i),' = input.in',num2str(i),'(:,b.b',num2str(i),'(1:n_train(i)))'];
    s4 = ['output_train.ou',num2str(i),' = trainout.ou',num2str(i),'(:,b.b',num2str(i),'(1:n_train(i)))'];
    s5 = ['input_test.in',num2str(i),' = input.in',num2str(i),'(:,b.b',num2str(i),'(n_train(i)+1:end))'];
    s6 = ['output_test.ou',num2str(i),' = trainout.ou',num2str(i),'(:,b.b',num2str(i),'(n_train(i)+1:end))'];
    s7 = ['[inputn.n',num2str(i),',inputps.s',num2str(i),'] = mapminmax(input_train.in',num2str(i),');'];
    s8 = ['[outputn.n',num2str(i),',outputps.s',num2str(i),'] = mapminmax(output_train.ou',num2str(i),');'];
    s9 = ['[data_size(',num2str(i),',3),data_size(',num2str(i),',4)] = size(input_train.in',num2str(i),');'];
    s10 = ['[data_size(',num2str(i),',5),data_size(',num2str(i),',6)] = size(input_test.in',num2str(i),');'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
    eval(s10);
end

% 
% k = rand(m,n);
% [a,b] = sort(k);
% input_train = input(:,b(1:n_train));
% output_train = output_data(:,b(1:n_train));
% input_test = input(:,b(n_train+1:end));
% output_test = output_data(:,b(n_train+1:end));
% 
% [inputn,inputps] = mapminmax(input_train);
% % inputn = input_train;
% [outputn,outputps] = mapminmax(output_train);



%% 数据分析
num.data = zeros(N+1,n_sta);
num.header{1,1} = 'totalnumber_healthy';
num.header{1,2} = 'totalnumber_ill';
num.header{1,3} = 'trainnumber_healthy';
num.header{1,4} = 'trainnumber_ill';
num.header{1,5} = 'testnumber_healthy';
num.header{1,6} = 'testnumber_ill';
num.header{1,7} = 'truenegative';
num.header{1,8} = 'truepositive';
num.header{1,9} = 'true-predict';
num.header{1,10} = 'false-predict';
num.header{1,11} = 'true-porpotion';
num.header{1,12} = 'true-positive';
num.header{1,13} = 'true-negative';

for i = 1:N
    for a = 1:data_size(i,2)
        s1 = ['if output.ou',num2str(i),'(a)>0 num.data(i,2) = num.data(i,2)+1;else num.data(i,1) = num.data(i,1)+1; end'];

        eval(s1);

    end
    for a = 1:data_size(i,4)
        s2 = ['if output_train.ou',num2str(i),'(1,a)>0 num.data(i,4) = num.data(i,4)+1;else num.data(i,3) = num.data(i,3)+1; end'];
        eval(s2);
    end
    for a = 1:data_size(i,6)
        s3 = ['if output_test.ou',num2str(i),'(1,a)>0 num.data(i,6) = num.data(i,6)+1; else num.data(i,5) = num.data(i,5)+1; end'];
        eval(s3);
    end
end
% n_health = 0;
% n_apnea = 0;
% ntrain_h = 0;
% ntrain_a = 0;
% ntest_h = 0;
% ntest_a = 0;
% [m,n] = size(output);
% for i=1:n
%     if output(i)>0
%         n_apnea = n_apnea+1;
%     else
%         n_health = n_health+1;
%     end
% end
% [m,n] = size(output_train);
% for i=1:n
%     if output_train(1,i)>0
%         ntrain_a = ntrain_a+1;
%     else
%         ntrain_h = ntrain_h+1;
%     end
% end
% [m,n] = size(output_test);
% for i=1:n
%     if output_test(1,i)>0
%         ntest_a = ntest_a+1;
%     else
%         ntest_h = ntest_h+1;
%     end
% end

%% BP网络训练
% %初始化网络结构

for i = 1:N
    s1 = ['net',num2str(i),'=newff(minmax(inputn.n',num2str(i),'),[5,5,2]);'];
    s2 = ['net',num2str(i),'.trainParam.epochs = 5000;'];
    s3 = ['net',num2str(i),'.trainParam.lr = 0.1000;'];
    s4 = ['net',num2str(i),'.trainParam.goal = 1e-15;'];
    s5 = ['net',num2str(i),'.trainParam.max_fail = 100;'];
    s6 = ['net',num2str(i),'.trainParam.min_grad = 1e-25;'];
    s8 = ['net',num2str(i),'.trainParam.mu_max = 1e9;'];
    s7 = ['net',num2str(i),' = train(net',num2str(i),',inputn.n',num2str(i),',outputn.n',num2str(i),');'];
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
end


% net=newff(minmax(inputn),[8,5,2]);
% % feedforwardnet
% net.trainParam.epochs=1000;      %%迭代次数
% net.trainParam.lr=0.1;          %%学习率
% net.trainParam.goal=0.000000001;    %%目标
% net.trainParam.max_fail = 100;
% net.trainParam.min_grad = 1e-11;
% 
% %网络训练
% net=train(net,inputn,outputn);

%% BP网络预测
%预测数据归一化

for i = 1:N
    s1 = ['inputn_test.n',num2str(i),' = mapminmax(''apply'',input_test.in',num2str(i),',inputps.s',num2str(i),');'];
    s2 = ['an.n',num2str(i),' = sim(net',num2str(i),',inputn_test.n',num2str(i),');'];
    s3 = ['Pout.n',num2str(i),' = mapminmax(''reverse'',an.n',num2str(i),',outputps.s',num2str(i),');'];
    
    eval(s1);
    eval(s2);
    eval(s3);
    
    for a = 1:data_size(i,6)
        s4 = ['if Pout.n',num2str(i),'(1,',num2str(a),')>Pout.n',num2str(i),'(2,',num2str(a),') Pout.n',num2str(i),'(1,',num2str(a),') = 1; Pout.n',num2str(i),'(2,',num2str(a),') = 0; else Pout.n',num2str(i),'(1,',num2str(a),') = 0; Pout.n',num2str(i),'(2,',num2str(a),') = 1; end'];
        eval(s4);
    end
        
end




% inputn_test=mapminmax('apply',input_test,inputps);
% % inputn_test = input_test; 
% 
% %网络预测输出
% an=sim(net,inputn_test);
%  
% %网络输出反归一化
% BPoutput=mapminmax('reverse',an,outputps);

% [m,n] = size(BPoutput);
% for i=1:n
%     if BPoutput(1,i)>BPoutput(2,i)
%         BPoutput(1,i) = 1;
%         BPoutput(2,i) = 0;
%     else
%         BPoutput(1,i) = 0;
%         BPoutput(2,i) = 1;
%     end
% end

% 
% for i=1:n
%     if BPoutput(1,i)>0
%         BPoutput(1,i) = 1;
% 
%     else
%         BPoutput(1,i) = 0;
% 
%     end
% end


% 
% [m,n] = size(BPoutput);
% 
% for i=1:n
%     if BPoutput(i)>0
%         BPoutput(i) = 5;
%     else
%         BPoutput(i) = -5;
%     end
% end


%% 结果分析

% figure(1)
% plot(BPoutput(1,:),':og')
% hold on
% plot(output_test(1,:),'-*');
% legend('预测输出','期望输出')
% title('BP网络预测输出','fontsize',12)
% ylabel('函数输出','fontsize',12)
% xlabel('样本','fontsize',12)
% %预测误差
% 
% n_error = 0;
% t_positive = 0;
% t_negative = 0;
% 
% for i=1:n
%     if BPoutput(1,i)~=output_test(1,i)
%         n_error = n_error+1;
%     end
%     if (BPoutput(1,i) == output_test(1,i) && BPoutput(1,i) == 0)
%         t_negative = t_negative + 1;
%     end
%     if (BPoutput(1,i) == output_test(1,i) && BPoutput(1,i) == 1)
%         t_positive = t_positive + 1;
%     end
% end
% 
% disp('正确率:');
% disp((1-n_error/n_test)*100);
% disp('真阳率:');
% disp(100*t_positive/ntest_a);
% disp('True negative:');
% disp(100*t_negative/ntest_h);

for i = 1:N
    for a = 1: data_size(i,6)
        s1 = ['if Pout.n',num2str(i),'(1,',num2str(a),')==output_test.ou',num2str(i),'(1,',num2str(a),')&&Pout.n',num2str(i),'(1,',num2str(a),')==1 num.data(',num2str(i),',8) = num.data(',num2str(i),',8)+1; end' ];
        s2 = ['if Pout.n',num2str(i),'(1,',num2str(a),')==output_test.ou',num2str(i),'(1,',num2str(a),')&&Pout.n',num2str(i),'(1,',num2str(a),')==0 num.data(',num2str(i),',7) = num.data(',num2str(i),',7)+1; end' ];
        s3 = ['if Pout.n',num2str(i),'(1,',num2str(a),')==output_test.ou',num2str(i),'(1,',num2str(a),') num.data(',num2str(i),',9) = num.data(',num2str(i),',9)+1; end' ];
        s4 = ['if Pout.n',num2str(i),'(1,',num2str(a),')~=output_test.ou',num2str(i),'(1,',num2str(a),') num.data(',num2str(i),',10) = num.data(',num2str(i),',10)+1; end' ];
        
        eval(s1);
        eval(s2);
        eval(s3);
        eval(s4);
    end
    num.data(i,11) = 100*num.data(i,9)/(num.data(i,5)+num.data(i,6));
    num.data(i,12) = 100*num.data(i,8)/num.data(i,6);
    num.data(i,13) = 100*num.data(i,7)/num.data(i,5);
end

if N == 1
    num.data(N+1,:) = num.data(1:N,:);
else
    num.data(N+1,:) = sum(num.data(1:N,:));
    num.data(N+1,11) = 100*num.data(N+1,9)/(num.data(N+1,5)+num.data(N+1,6));
    num.data(N+1,12) = 100*num.data(N+1,8)/num.data(N+1,6);
    num.data(N+1,13) = 100*num.data(N+1,7)/num.data(N+1,5);
end


disp('正确率：');
disp(num.data(N+1,11));
disp('正阳率：');
disp(num.data(N+1,12));
disp('正阴率：');
disp(num.data(N+1,13));



