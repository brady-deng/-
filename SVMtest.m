%% 12-23
%   SVM for classify apnea
%   brady deng
%   Last editted by Brady deng in 2-2.
%   Use 5-fold cross validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear;
close all;

%% load data
fs = 100;
T = 60;


% name = input('Please input the feature file you want to train:');
% name = '3f30t';
name = 'f25-1';

s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
eval(s1);


input = d.ft;
output = d.at';


[m,n] = size(output);

output_data = zeros(m,n);
for i=1:n
    if output(i)>0
        output_data(1,i) = 1;

    end
end

%% construct the training_data and testing_data

p_test = 0.2;
k_f = 1/p_test;
n_test = fix(n*p_test);
n_train = n-n_test;

N_s = 10;
T_s = 10;
k = rand(m,n);
[a,b] = sort(k);

for i = 1:k_f
    s1 = ['input_test.t',num2str(i),' = input(:,b((i-1)*n_test+1:i*n_test));'];
    s2 = ['output_test.t',num2str(i),' = output_data(:,b((i-1)*n_test+1:i*n_test));'];
    s3 = ['input_train.t',num2str(i),' = input(:,[b(1:(i-1)*n_test),b(i*n_test+1:end)]);'];
    s4 = ['output_train.t',num2str(i),' = output_data(:,[b(1:(i-1)*n_test),b(i*n_test+1:end)]);'];
    s5 = ['inputn_test.t',num2str(i),' = input_test.t',num2str(i),';'];
    s6 = ['inputn.t',num2str(i),' = input_train.t',num2str(i),';'];
    s7 = ['inputn_test.t',num2str(i),' = inputn_test.t',num2str(i),''';'];
    s8 = ['inputn.t',num2str(i),' = inputn.t',num2str(i),''';'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
end
temp = inputn_test;
temp2 = inputn;
temp3 = output_train;
N_ts = fix(n_test/N_s);
N_ns = fix(n_train/T_s);
for i = 1:k_f
    for a = 1:N_s
        s1 = ['inputn_test.t',num2str(i),'.t',num2str(a),' = temp.t',num2str(i),'((a-1)*N_ts+1:a*N_ts,:);'];
        eval(s1);
    end
end
for i = 1:k_f
    s1 = ['output_test.t',num2str(i),' = output_test.t',num2str(i),'(1:N_s*N_ts);'];
    eval(s1);
end


for i = 1:k_f
    for a = 1:T_s
        s1 = ['inputn.t',num2str(i),'.t',num2str(a),' = temp2.t',num2str(i),'((a-1)*N_ns+1:a*N_ns,:);'];
        s2 = ['output_train.t',num2str(i),'.t',num2str(a),' = temp3.t',num2str(i),'((a-1)*N_ns+1:a*N_ns);'];
        eval(s1);
        eval(s2);
    end
end


%%  Here is using the SMOTE technique to balance the training data.
% [temp5,temp6] = ADASYN(input_train',output_train,1,5,5,false);
% input_train = [input_train,temp5'];
% output_train = [output_train,temp6'];

% 
% inputn_test = input_test;
% inputn = input_train;
% 
% 
% 
% 
% inputn_test = inputn_test';
% inputn = inputn';



%%  Here the 6 rows codes are for mapminmaxing the training data.
% temp2 = inputn';
% temp1 = mapminmax(temp2);
% temp3 = inputn_test';
% temp4 = mapminmax(temp3);
% inputn = temp1';
% inputn_test = temp4';


%% data analyzing

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
%     if output_train(i)>0
%         ntrain_a = ntrain_a+1;
%     else
%         ntrain_h = ntrain_h+1;
%     end
% end
% [m,n] = size(output_test);
% for i=1:n
%     if output_test(i)>0
%         ntest_a = ntest_a+1;
%     else
%         ntest_h = ntest_h+1;
%     end
% end


%% SVM Training
options = statset('MaxIter',1e7);
clear input output input_train input_test output_data output;
for i = 1:k_f
    for a = 1:T_s
        s1 = ['svmModel',num2str(i),' = svmtrain(inputn.t',num2str(i),'.t',num2str(a),',output_train.t',num2str(i),'.t',num2str(a),',''kernel_function'',''rbf'',''options'',options);'];
        eval(s1);
    end
    for a = 1:N_s
        s2 = ['svm_pre.p',num2str(i),'.p',num2str(a),' = svmclassify(svmModel',num2str(i),',inputn_test.t',num2str(i),'.t',num2str(a),');'];
        eval(s2);
    end
end

%% SVM Predicting
temp = svm_pre;
for i = 1:k_f
    s1 = ['svm_pre.p',num2str(i),' = [];'];
    eval(s1);
    for a = 1:N_s
        s2 = ['svm_pre.p',num2str(i),' = [svm_pre.p',num2str(i),';temp.p',num2str(i),'.p',num2str(a),'];'];
        eval(s2);
    end
    s3 = ['svm_pre.p',num2str(i),' = svm_pre.p',num2str(i),''';'];
    eval(s3);
end


%% statical analysis of SVM prediction

% [m,n] = size(svm_pre);
% n_error = 0;
% t_positive = 0;
% t_negative = 0;
% for i=1:m*n
%     if svm_pre(i)~= output_test(i);
%         n_error = n_error+1;
%     end
%     if svm_pre(i) == output_test(i) && svm_pre(i) == 1;
%         t_positive = t_positive+1;
%     end
%     if svm_pre(i) == output_test(i) && svm_pre(i) == 0;
%         t_negative = t_negative+1;
%     end
% end
% 
% disp('错误率');
% disp(n_error*100/(m*n));
% disp('正确率');
% disp((1-n_error/(m*n))*100);
% disp('真阳率：');
% disp(t_positive*100/ntest_a);
% disp('true negative:');
% disp(t_negative*100/ntest_h);
% 
% 
% result2(1,1) = n_health;
% result2(1,2) = n_apnea;
% result2(1,3) = ntrain_h;
% result2(1,4) = ntrain_a;
% result2(1,5) = ntest_h;
% result2(1,6) = ntest_a;
% result2(1,7) = n_test-n_error;
% result2(1,8) = n_error;
% result2(1,9) = t_positive;
% result2(1,10) = t_negative;
% result2(1,11) = 100*result2(1,7)/(result2(1,5)+result2(1,6));
% result2(1,12) = 100*result2(1,9)/result2(1,6);
% result2(1,13) = 100*result2(1,10)/result2(1,5);
%    


for i = 1:k_f
    s1 = ['r(i,:) = svm_pre.p',num2str(i),' - output_test.t',num2str(i),';'];
    s2 = ['res(i,2) = sum(abs(r(i,:)));'];
    s3 = ['res(i,1) = n_test - res(i,2);'];
    s4 = ['res(i,3) = sum(~output_test.t',num2str(i),');'];
    s5 = ['res(i,4) = sum(output_test.t',num2str(i),');'];
    s6 = ['[temp1,temp2] = find(r(i,:)==1);'];
    s7 = ['[temp3,temp4] = find(r(i,:)==-1);'];
    s8 = ['res(i,5) = res(i,3)-sum(temp1);'];
    s9 = ['res(i,6) = res(i,4)-sum(temp3);'];
    s10 = ['res(i,7) = 100*res(i,1)/n_test;'];
    s11 = ['res(i,8) = 100*res(i,6)/res(i,4);'];
    s12 = ['res(i,9) = 100*res(i,5)/res(i,3);'];
    
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
    eval(s11);
    eval(s12);
end
res(6,:) = sum(res);
res(6,7) = 100*(res(6,5)+res(6,6))/(res(6,3)+res(6,4));
res(6,8) = 100*res(6,6)/res(6,4);
res(6,9) = 100*res(6,5)/res(6,3);
% res = zeros(k_f,13);
% for i = 1:k_f
%     s1 = ['res(i,1) = n;'];
%     s2 = ['res(i,2) = n_train;'];
%     s3 = ['res(i,3) = n_test;'];
%     s4 = ['res(i,4) = sum(~output_train.t',num2str(i),');'];
%     s5 = ['res(i,5) = sum(output_train.t',num2str(i),');'];
%     s6 = ['res(i,6) = sum(~output_test.t',num2str(i),');'];
%     s7 = ['res(i,7) = sum(output_test.t',num2str(i),');'];
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
%     eval(s5);
%     eval(s6);
%     eval(s7);
% end
% 
% for i = 1:k_f
%     for a=1:res(i,3)
%         s1 = ['if svm_pre.p',num2str(i),'(a)~= output_test.t',num2str(i),'(a) res(i,8) = res(i,8)+1;end'];
%         s2 = ['if svm_pre.p',num2str(i),'(a) == output_test.t',num2str(i),'(a) && svm_pre.p',num2str(i),'(a) == 1;res(i,9) = res(i,9)+1;end'];
%         s3 = ['if svm_pre.p',num2str(i),'(a) == output_test.t',num2str(i),'(a) && svm_pre.p',num2str(i),'(a) == 0;res(i,10) = res(i,10)+1;end'];
%         eval(s1);
%         eval(s2);
%         eval(s3);
%         s4 = ['res(i,11) = 100*res(i,9)/res(i,7);'];
%         s5 = ['res(i,12) = 100*res(i,10)/res(i,6);'];
%         s6 = ['res(i,13) = 100*(res(i,9)+res(i,10))/res(i,3);'];
%         eval(s4);
%         eval(s5);
%         eval(s6);
%     end
% end