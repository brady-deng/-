clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for using SVM to recognize the apnea and health.
%   Finally we will get 23 SVM models for each subject.
%   And SMOTE is used to balance the health data and apnea data.
%   Pay attention to s25&s26&s27 to see whether the SMOTE technique is used
%   in this script.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% load data
fs = 128;
N = 23;
p_train = 0.8;
numa = 13;
% ite_count = ite_count+1;
name = input('Please input the feature file you want to train:');
% name = '3f30t';

s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
eval(s1);
s25 = ['num = zeros(N+1,numa);'];
eval(s25);

options = statset('MaxIter',1e7);
for i = 1:N
    s1 = ['input.i',num2str(i),' = d.f.f',num2str(i),';'];
    s2 = ['output.o',num2str(i),' = d.an.a',num2str(i),';'];
    s3 = ['[siz(i,1),siz(i,2)] = size(input.i',num2str(i),');'];
    s4 = ['num(i,2) = sum(output.o',num2str(i),');'];
    s5 = ['num(i,1) = siz(i,2) - num(i,2);'];
    s6 = ['numte(i) = fix(siz(i,2)*p_train);'];
    s7 = ['k.k',num2str(i),' = rand(1,siz(i,2));'];
    s8 = ['[a.a',num2str(i),',b.b',num2str(i),'] = sort(k.k',num2str(i),');'];
    s9 = ['input_train.i',num2str(i),' = input.i',num2str(i),'(:,b.b',num2str(i),'(1:numte(i)));'];
    s10 = ['output_train.o',num2str(i),' = output.o',num2str(i),'(b.b',num2str(i),'(1:numte(i)));'];
    s11 = ['input_test.i',num2str(i),' = input.i',num2str(i),'(:,b.b',num2str(i),'(numte(i)+1:end));'];
    s12 = ['output_test.o',num2str(i),' = output.o',num2str(i),'(b.b',num2str(i),'(numte(i)+1:end));'];
    s17 = ['input_train.i',num2str(i),' = input_train.i',num2str(i),''';'];
    s18 = ['output_train.o',num2str(i),' = output_train.o',num2str(i),''';'];
    s19 = ['input_test.i',num2str(i),' = input_test.i',num2str(i),''';'];
    s20 = ['output_test.o',num2str(i),' = output_test.o',num2str(i),''';'];
%     s25 = ['[temp1,temp2] = ADASYN(input_train.i',num2str(i),',output_train.o',num2str(i),',1,5,5,false);'];
%     s26 = ['input_train.i',num2str(i),' = [input_train.i',num2str(i),';temp1];'];
%     s27 = ['output_train.o',num2str(i),' = [output_train.o',num2str(i),',temp2''];'];
    s13 = ['num(i,4) = sum(output_train.o',num2str(i),');'];
    s14 = ['num(i,3) = sum(~output_train.o',num2str(i),');'];
    s15 = ['num(i,6) = sum(output_test.o',num2str(i),');'];
    s16 = ['num(i,5) = sum(~output_test.o',num2str(i),');'];
    s21 = ['svmModel = svmtrain(input_train.i',num2str(i),',output_train.o',num2str(i),',''kernel_function'',''rbf'',''showplot'',false,''options'',options);'];
    s22 = ['svm_pre.p',num2str(i),' = svmclassify(svmModel,input_test.i',num2str(i),');'];
    s23 = ['num(i,7) = num(i,3)+num(i,4);'];
    s24 = ['num(i,8) = num(i,5)+num(i,6);'];
        
    
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
    eval(s17);
    eval(s18);
    eval(s19);
    eval(s20);
%     eval(s25);
%     eval(s26);
%     eval(s27);
    eval(s13);
    eval(s14);
    eval(s15);
    eval(s16);
    eval(s21);
    eval(s22);
    eval(s23);
    eval(s24);
    for count = 1:num(i,8)
        s25 = ['if svm_pre.p',num2str(i),'(count) == output_test.o',num2str(i),'(count)&&svm_pre.p',num2str(i),'(count) == 0 num(i,9) = num(i,9)+1;end'];
        s26 = ['if svm_pre.p',num2str(i),'(count) == output_test.o',num2str(i),'(count)&&svm_pre.p',num2str(i),'(count) == 1 num(i,10) = num(i,10)+1;end'];
        
        eval(s25);
        eval(s26);
    end
    
    num(i,11) = 100*(num(i,9)+num(i,10))/num(i,8);
    num(i,12) = 100*(num(i,10))/num(i,6);
    num(i,13) = 100*num(i,9)/num(i,5);
end

% for i = 1:N
%     s1 = ['temp{i} = svm_pre.p',num2str(i),'''-output_test.o',num2str(i),';'];
%     eval(s1);
% end
num(N+1,:) = sum(num(1:N,:));
num(N+1,11) = 100*(num(N+1,9)+num(N+1,10))/num(N+1,8);
num(N+1,12) = 100*(num(N+1,10))/num(N+1,6);
num(N+1,13) = 100*num(N+1,9)/num(N+1,5);












