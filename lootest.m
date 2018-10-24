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
% startmatlabpool(4);


fs = 100;
T = 60;
N = 23;
N_TR = 5;
N_CR = 5;
TO = 50000;
name = input('Please input the feature file you want to train:');
% name = '3f30t';

s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
eval(s1);
index = 1:23;
temp = repmat(index,N,1);
temp2 = ones(23,23);

for i = 1:N
    temp2(i,i) = 0;
end
temp = temp.*temp2;
temp(find(temp == 0)) = [];
temp = reshape(temp,23,22);
test_i = 24-index;
for i = 1:N
    s1 = ['ftrain.t',num2str(i),' = [];'];
    s2 = ['atrain.t',num2str(i),' = [];'];
    s3 = ['ftest.t',num2str(i),' = [];'];
    s4 = ['atest.t',num2str(i),' = [];'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
end
for i = 1:N
    for a = 1:N-1
        s1 = ['ftrain.t',num2str(i),' = [ftrain.t',num2str(i),',d.f.f',num2str(temp(i,a)),'];'];
        s2 = ['atrain.t',num2str(i),' = [atrain.t',num2str(i),';d.an.a',num2str(temp(i,a)),'];'];

        eval(s1);
        eval(s2);
        
    end
    s3 = ['ftest.t',num2str(i),' = [ftest.t',num2str(i),',d.f.f',num2str(test_i(i)),'];'];
    s4 = ['atest.t',num2str(i),' = [atest.t',num2str(i),';d.an.a',num2str(test_i(i)),'];'];
    eval(s3);
    eval(s4);
    s5 = ['l(i,1) = length(ftrain.t',num2str(i),'(1,:));'];
    s6 = ['l(i,2) = length(ftest.t',num2str(i),'(1,:));'];
    
    eval(s5);
    eval(s6);
    s7 = ['ftrain.t',num2str(i),' = ftrain.t',num2str(i),''''];
    s8 = ['ftest.t',num2str(i),' = ftest.t',num2str(i),''''];
    eval(s7);
    eval(s8);
    
    s9 = ['l(i,3) = sum(atrain.t',num2str(i),');'];
    s10 = ['l(i,4) = l(i,1)-l(i,3);'];
    s11 = ['l(i,5) = sum(atest.t',num2str(i),');'];
    s12 = ['l(i,6) = l(i,2)-l(i,5);'];
    eval(s9);
    eval(s10);
    eval(s11);
    eval(s12);
end

clear temp temp2;



% for i = 1:N
%     train_n = fix(l(1,i)/N_TR
%     for a = 1:N_TR
%         s1 = ['
% input = d.ft;
% output = d.at';
% 
% 
% [m,n] = size(output);
% 
% output_data = zeros(m,n);
% for i=1:n
%     if output(i)>0
%         output_data(1,i) = 1;
% 
%     end
% end
% 
% %% construct the training_data and testing_data
% 
% p_test = 0.2;
% k_f = 1/p_test;
% n_test = fix(n*p_test);
% n_train = n-n_test;
% 
% N_s = 10;
% T_s = 10;
% k = rand(m,n);
% [a,b] = sort(k);
% 
% for i = 1:k_f
%     s1 = ['input_test.t',num2str(i),' = input(:,b((i-1)*n_test+1:i*n_test));'];
%     s2 = ['output_test.t',num2str(i),' = output_data(:,b((i-1)*n_test+1:i*n_test));'];
%     s3 = ['input_train.t',num2str(i),' = input(:,[b(1:(i-1)*n_test),b(i*n_test+1:end)]);'];
%     s4 = ['output_train.t',num2str(i),' = output_data(:,[b(1:(i-1)*n_test),b(i*n_test+1:end)]);'];
%     s5 = ['inputn_test.t',num2str(i),' = input_test.t',num2str(i),';'];
%     s6 = ['inputn.t',num2str(i),' = input_train.t',num2str(i),';'];
%     s7 = ['inputn_test.t',num2str(i),' = inputn_test.t',num2str(i),''';'];
%     s8 = ['inputn.t',num2str(i),' = inputn.t',num2str(i),''';'];
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
%     eval(s5);
%     eval(s6);
%     eval(s7);
%     eval(s8);
% end
% temp = inputn_test;
% temp2 = inputn;
% temp3 = output_train;
% N_ts = fix(n_test/N_s);
% N_ns = fix(n_train/T_s);
% for i = 1:k_f
%     for a = 1:N_s
%         s1 = ['inputn_test.t',num2str(i),'.t',num2str(a),' = temp.t',num2str(i),'((a-1)*N_ts+1:a*N_ts,:);'];
%         eval(s1);
%     end
% end
% for i = 1:k_f
%     s1 = ['output_test.t',num2str(i),' = output_test.t',num2str(i),'(1:N_s*N_ts);'];
%     eval(s1);
% end
% 
% 
% for i = 1:k_f
%     for a = 1:T_s
%         s1 = ['inputn.t',num2str(i),'.t',num2str(a),' = temp2.t',num2str(i),'((a-1)*N_ns+1:a*N_ns,:);'];
%         s2 = ['output_train.t',num2str(i),'.t',num2str(a),' = temp3.t',num2str(i),'((a-1)*N_ns+1:a*N_ns);'];
%         eval(s1);
%         eval(s2);
%     end
% end
% 
% 


%% SVM Training
options = statset('MaxIter',1e7);
clear input output input_train input_test output_data output;

for i = 1:N
    train_num(i) = floor(l(i,1)/TO);
    index1 = rand(1,l(i,1));
    [a1,b1] = sort(index1);
    s1 = ['ftrain.t',num2str(i),' = ftrain.t',num2str(i),'(b1,:);'];
    s2 = ['atrain.t',num2str(i),' = atrain.t',num2str(i),'(b1,:);'];
    eval(s1);
    eval(s2);
    for a = 1:train_num(i) 
        s1 = ['temp.t',num2str(a),' = ftrain.t',num2str(i),'((a-1)*TO+1:(a*TO),:);'];
        s2 = ['temp2.t',num2str(a),' = atrain.t',num2str(i),'((a-1)*TO+1:(a*TO),:);'];
        eval(s1);
        eval(s2);
    end
    s2 = ['temp.t',num2str(train_num(i)+1),' = ftrain.t',num2str(i),'(train_num(i)*TO+1:end,:);'];
    s3 = ['temp2.t',num2str(train_num(i)+1),' = atrain.t',num2str(i),'(train_num(i)*TO+1:end,:);'];
    eval(s2);
    eval(s3);
    s3 = ['ftrain.t',num2str(i),' = temp;'];
    s4 = ['atrain.t',num2str(i),' = temp2;'];
    eval(s3);
    eval(s4);
    clear temp temp2;
end
train_num = train_num+1;
for i = 1:N
        for a = 1:train_num(i)
            s1 = ['svmModel',num2str(i),' = svmtrain(ftrain.t',num2str(i),'.t',num2str(a),',atrain.t',num2str(i),'.t',num2str(a),',''kernel_function'',''rbf'',''options'',options);'];
            eval(s1);
        end


        s2 = ['svm_pre.p',num2str(i),' = svmclassify(svmModel',num2str(i),',ftest.t',num2str(i),');'];
        eval(s2);

end


for i = 1:N
    s1 = ['temp = svm_pre.p',num2str(i),' - atest.t',num2str(i),';'];
    s2 = ['temp2 = abs(temp);'];
    eval(s1);
    eval(s2);
    s2 = ['l(i,7) = sum(~temp2);'];
    s3 = ['l(i,8) = sum(temp2);'];
    eval(s2);
    eval(s3);
    s4 = ['[t1,t2] = find(temp == 1);'];
    s5 = ['[t3,t4] = find(temp == -1);'];
    eval(s4);
    eval(s5);
    
    l(i,9) = l(i,5)-sum(t4);
    l(i,10) = l(i,6)-sum(t2);
    
    l(i,11) = 100*l(i,7)/l(i,2);
    l(i,12) = 100*l(i,9)/l(i,5);
    l(i,13) = 100*l(i,10)/l(i,6);
    clear temp temp2;
end



l(N+1,:) = sum(l(1:N,:));
l(N+1,11) = 100*l(N+1,7)/l(N+1,2);
l(N+1,12) = 100*l(N+1,9)/l(N+1,5);
l(N+1,13) = 100*l(N+1,10)/l(N+1,6);




l2 = l;
for i = 1:N
    temp = zeros(l(i,2),5);
    for a = 3:l(i,2)-2
        s1 = ['temp(a,1) = sum(svm_pre.p',num2str(i),'(a-1:a+1));'];
        s2 = ['temp(a,2) = sum(svm_pre.p',num2str(i),'(a-2:a+2));'];
        s3 = ['temp(a,3) = svm_pre.p',num2str(i),'(a);'];
        eval(s1);
        eval(s2);
        eval(s3);
        temp(a,4) = temp(a,2)*100+temp(a,1)*10+temp(a,3);
        if temp(a,4) == 111
            s4 = ['svm_pre.p',num2str(i),'(a) = 0;'];
            eval(s4);
        end
        temp(a,5) = temp(a,1)*10+temp(a,3);
        if temp(a,5) == 20
            s5 = ['svm_pre.p',num2str(i),'(a) = 1;'];
            eval(s5);
        end
    end
    clear temp;
end

for i = 1:N
    s1 = ['temp = svm_pre.p',num2str(i),' - atest.t',num2str(i),';'];
    s2 = ['temp2 = abs(temp);'];
    eval(s1);
    eval(s2);
    s2 = ['l2(i,7) = sum(~temp2);'];
    s3 = ['l2(i,8) = sum(temp2);'];
    eval(s2);
    eval(s3);
    s4 = ['[t1,t2] = find(temp == 1);'];
    s5 = ['[t3,t4] = find(temp == -1);'];
    eval(s4);
    eval(s5);
    
    l2(i,9) = l2(i,5)-sum(t4);
    l2(i,10) = l2(i,6)-sum(t2);
    
    l2(i,11) = 100*l2(i,7)/l2(i,2);
    l2(i,12) = 100*l2(i,9)/l2(i,5);
    l2(i,13) = 100*l2(i,10)/l2(i,6);
    
    clear temp temp2;
end



l2(N+1,:) = sum(l2(1:N,:));
l2(N+1,11) = 100*l2(N+1,7)/l2(N+1,2);
l2(N+1,12) = 100*l2(N+1,9)/l2(N+1,5);
l2(N+1,13) = 100*l2(N+1,10)/l2(N+1,6);



% closematlabpool;
