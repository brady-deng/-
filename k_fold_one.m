clc;
clear;
close all;

%% 12-23
%   SVM for classify apnea for the whole dataset
%   brady deng
%   Last editted by Brady deng in 3-31.
%   Use 5-fold cross validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear;
close all;

%% load data
startmatlabpool(4);


%% Initial settings
N = 23;
P = 0.2;
K = 1/P;

name = input('Please input the feature file you want to train:');
box = input('Please input the boxconstriant:');
T = 30;

sigma = 1;

ker4 = 'rbf';



s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];

eval(s1); 


indices = crossvalind('Kfold',d.at,K);
l(1) = length(d.at);
l(2) = fix(P*l(1));
l(3) = l(1)-l(2);
temp1 = rand(1,l(1));
[temp2,temp3] = sort(temp1);
outorf = d.ft(:,temp3);
outora = d.at(temp3);
clear temp1 temp2 temp3;

for a = 1:K
    indte{a} = find(indices == a);
    indtr{a} = find(indices ~= a);
    ftest{a} = outorf(:,indte{a});
    antest{a} = outora(indte{a});
    ftrain{a} = outorf(:,indtr{a});
    antrain{a} = outora(indtr{a});
    ftrain{a} = ftrain{a}';
    ftest{a} = ftest{a}';
    antrain{a} = antrain{a}';
    antest{a} = antest{a}';
    num(a,1) = length(antrain{a});
    num(a,2) = sum(antrain{a});
    num(a,3) = sum(~antrain{a});
    num(a,4) = length(antest{a});
    num(a,5) = sum(antest{a});
    num(a,6) = sum(~antest{a});
end

options = statset('MaxIter',1e7);


parfor a = 1:K
     svmModel = svmtrain(ftrain{a},antrain{a},'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
     p{a} = svmclassify(svmModel,ftest{a});
end 



for a = 1:K
        s1 = ['temp = p{a} - antest{a}'';'];
        s2 = ['temp2 = abs(temp);'];
        eval(s1);
        eval(s2);
        s2 = ['num(a,7) = sum(~temp2);'];
        s3 = ['num(a,8) = sum(temp2);'];
        eval(s2);
        eval(s3);
        s4 = ['[t1,t2] = find(temp == 1);'];
        s5 = ['[t3,t4] = find(temp == -1);'];
        eval(s4);
        eval(s5);
    
        num(a,9) = num(a,5)-sum(t4);
        num(a,10) = num(a,6)-sum(t2);
    
        num(a,11) = 100*num(a,7)/num(a,4);
        num(a,12) = 100*num(a,9)/num(a,5);
        num(a,13) = 100*num(a,10)/num(a,6);
    
        clear temp temp2 t1 t2 t3 t4;
end
    num(K+1,:) = sum(num);
    num(K+1,11) = 100*num(K+1,7)/num(K+1,4);
    num(K+1,12) = 100*num(K+1,9)/num(K+1,5);
    num(K+1,13) = 100*num(K+1,10)/num(K+1,6);
    
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\res',num2str(T),'-1.mat'',''num'');'];
eval(s13);
