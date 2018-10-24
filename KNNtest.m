clc;
clear;
close all;


name = input('Please input the feature file''s name you want to recognize:');
% name = '3f30t';
s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
eval(s1);
t_p = 0;
t_n = 0;

[m,n] = size(d.ft);
train_p = 0.7;
n_train = fix(n*train_p);
n_test = n-n_train;
% k = rand(1,n);
% [k1,k2] = sort(k);
% 
% 
% input_train = d.ft(:,k2(1:n_train))';
% output_train = d.at(k2(1:n_train));
% input_test = d.ft(:,k2(n_train+1:end))';
% output_test = d.at(k2(n_train+1:end));
% 
% 
% [temp5,temp6] = ADASYN(input_train,output_train,1,5,5,false);
% input_train = [input_train;temp5];
% output_train = [output_train;temp6];
% 
% ntrain_a = sum(output_train);
% ntrain_h = sum(~output_train);
% ntest_a = sum(output_test);
% ntest_h = sum(~output_test);
res = zeros(250,12);
for co = 10:10
    for it = 1:10
        t_p = 0;
        t_n = 0;
        k = rand(1,n);
        [k1,k2] = sort(k);


        input_train = d.ft(:,k2(1:n_train))';
        output_train = d.at(k2(1:n_train));
        input_test = d.ft(:,k2(n_train+1:end))';
        output_test = d.at(k2(n_train+1:end));


%         [temp5,temp6] = ADASYN(input_train,output_train,1,5,5,false);
%         input_train = [input_train;temp5];
%         output_train = [output_train;temp6];

        ntrain_a = sum(output_train);
        ntrain_h = sum(~output_train);
        ntest_a = sum(output_test);
        ntest_h = sum(~output_test);
        s1 = ['mdl',num2str(co),'.m',num2str(it),' = ClassificationKNN.fit(input_train,output_train,''NumNeighbors'',',num2str(co),');'];
        s2 = ['knnpre',num2str(co),'.k',num2str(it),' = predict(mdl',num2str(co),'.m',num2str(it),',input_test);'];
        eval(s1);
        eval(s2);
        for i = 1:n_test
            s3 = ['if knnpre',num2str(co),'.k',num2str(it),'(i) == output_test(i)&&output_test(i) == 0 t_n = t_n+1;end'];
            s4 = ['if knnpre',num2str(co),'.k',num2str(it),'(i) == output_test(i)&&output_test(i) == 1 t_p = t_p+1;end'];
            eval(s3);
            eval(s4);
        end
        t_c = t_p+t_n;
        t_e = n_test - t_c;

        res((co-2)*5+it,1) = ntrain_h;
        res((co-2)*5+it,2) = ntrain_a;
        res((co-2)*5+it,3) = ntest_h;
        res((co-2)*5+it,4) = ntest_a;
        res((co-2)*5+it,5) = n_test;
        res((co-2)*5+it,6) = t_n;
        res((co-2)*5+it,7) = t_p;
        res((co-2)*5+it,8) = t_c;
        res((co-2)*5+it,9) = t_e;
        res((co-2)*5+it,10) = 100*t_c/n_test;
        res((co-2)*5+it,11) = 100*t_p/ntest_a;
        res((co-2)*5+it,12) = 100*t_n/ntest_h;

    end
end



% t_c = t_p+t_n;
% t_e = n_test - t_c;
% 
% res(1,1) = ntrain_h;
% res(1,2) = ntrain_a;
% res(1,3) = ntest_h;
% res(1,4) = ntest_a;
% res(1,5) = n_test;
% res(1,6) = t_n;
% res(1,7) = t_p;
% res(1,8) = t_c;
% res(1,9) = t_e;
% res(1,10) = 100*t_c/n_test;
% res(1,11) = 100*t_p/ntest_a;
% res(1,12) = 100*t_n/ntest_h;