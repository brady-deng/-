%% 12-23
%   SVM for classify apnea for each subject
%   brady deng
%   Last editted by Brady deng in 2-28.
%   Use 5-fold cross validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear;
close all;

%% load data
startmatlabpool(4);


%% Initial settings
N = 1;
P = 0.2;
K = 1/P;
% K = 1;
name = input('Please input the feature file you want to train:');
name2 = input('Please input the annotation file:');
% T = input('Please input the T:');
% ST = input('Please input the ST:');
% testnum = fix((3600+T)/ST);
% box = input('Please input the boxconstriant:');
box = 1;
% sigma = input('Please input the rbg_sigma:');
% box = 0.5;
sigma = 1;
ker1 = 'linear';
ker2 = 'quadratic';
ker3 = 'polynomial';
ker4 = 'rbf';
ker5 = 'mlp';


s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];
s2 = ['d2 = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name2,'.mat'');'];

eval(s1); 
eval(s2);




% for i = 1:N
%     s1 = ['l(i,1) = length(d.an.a',num2str(i),');'];
%     s2 = ['l(i,2) = fix(P*l(i,1));'];
%     s3 = ['l(i,3) = l(i,1)-l(i,2);'];
%     s4 = ['index{i} = 1:l(i,2)*K;'];
%     s5 = ['in{i} = zeros(K,l(i,2)*K);'];
%     s6 = ['ran{i} = rand(1,l(i,2)*K);'];
%     s7 = ['[temp1,temp2] = sort(ran{i});'];
%     s8 = ['index{i} = temp2;'];
%     
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
%     eval(s5);
%     eval(s6);
%     eval(s7);
%     eval(s8);
%     clear temp1 temp2;
%     
% end
% for i = 1:N
%     for a = 1:K
% %         ind{i}{a} = zeros(1,l(i,2));
%         indte{i}{a} = index{i}((a-1)*l(i,2)+1:a*l(i,2));
% %         indtr{i}{a} = index{i}(1:(a-1)*l(i,2),a*l(i,2)+1:end);
%         s1 = ['ftest{i}{a} = d.f.f',num2str(i),'(:,indte{i}{a});'];
%         s2 = ['antest{i}{a} = d.an.a',num2str(i),'(indte{i}{a});'];
%         eval(s1);
%         eval(s2);
%         
%         in{i}(a,(a-1)*l(i,2)+1:a*l(i,2)) = 1;
%         
%     end
% %     in{i} = ~in{i};
%     for a = 1:K
%         in{i}(a,:) = ~in{i}(a,:);
%         indtr{i}{a} = index{i}.*in{i}(a,:);
%         indtr{i}{a}(find(indtr{i}{a} == 0)) = [];
%         s1 = ['ftrain{i}{a} = d.f.f',num2str(i),'(:,indtr{i}{a});'];
%         s2 = ['antrain{i}{a} = d.an.a',num2str(i),'(indtr{i}{a});'];
%         eval(s1);
%         eval(s2);
%     end
%     for a = 1:K
%         s1 = ['ftrain{i}{a} = ftrain{i}{a}'';'];
%         s2 = ['ftest{i}{a} = ftest{i}{a}'';'];
%         s3 = ['antrain{i}{a} = antrain{i}{a}'';'];
%         s4 = ['antest{i}{a} = antest{i}{a}'';'];
%         eval(s1);
%         eval(s2);
%         eval(s3);
%         eval(s4);
%     end
%     s1 = ['ftotal{i} = d.f.f',num2str(i),';'];
%     s2 = ['antotal{i} = d.an.a',num2str(i),';'];
%     eval(s1);
%     eval(s2);
%     s3 = ['ftotal{i} = ftotal{i}'';'];
%     s4 = ['antotal{i} = antotal{i}'';'];
%     eval(s3);
%     eval(s4);
%         
% end


% Building the training set and testing set
for i = 1:N
    s1 = ['indices{i} = crossvalind(''Kfold'',d2.an.a',num2str(i),',K);'];
    s2 = ['l(i,1) = length(d2.an.a',num2str(i),');'];
    s3 = ['l(i,2) = fix(P*l(i,1));'];
    s4 = ['l(i,3) = l(i,1)-l(i,2);'];
    s5 = ['temp1 = rand(1,l(i,1));'];
    s6 = ['[temp2,temp3] = sort(temp1);'];
    s7 = ['outorf{i} = d.Sp',num2str(i),'(:,temp3);'];
    s8 = ['outora{i} = d2.an.a',num2str(i),'(temp3);'];
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    
    clear temp1 temp2 temp3;
    
    for a = 1:K
        indte{i}{a} = find(indices{i}==a);
        indtr{i}{a} = find(indices{i}~=a);
        s1 = ['ftest{i}{a} = outorf{i}(:,indte{i}{a});'];
        s2 = ['antest{i}{a} = outora{i}(indte{i}{a});'];
        eval(s1);
        eval(s2);
        s1 = ['ftrain{i}{a} = outorf{i}(:,indtr{i}{a});'];
        s2 = ['antrain{i}{a} = outora{i}(indtr{i}{a});'];
        eval(s1);
        eval(s2);
        s1 = ['ftrain{i}{a} = ftrain{i}{a}'';'];
        s2 = ['ftest{i}{a} = ftest{i}{a}'';'];
        s3 = ['antrain{i}{a} = antrain{i}{a}'';'];
        s4 = ['antest{i}{a} = antest{i}{a}'';'];
        eval(s1);
        eval(s2);
        eval(s3);
        eval(s4);
    end
%     s1 = ['ftotal{i} = d.f.f',num2str(i),';'];
%     s2 = ['antotal{i} = d.an.a',num2str(i),';'];
%     eval(s1);
%     eval(s2);
%     s3 = ['ftotal{i} = ftotal{i}'';'];
%     s4 = ['antotal{i} = antotal{i}'';'];
%     eval(s3);
%     eval(s4);
end



% Analyze the result.
for i = 1:N
    num{i} = zeros(K,12);
    for a = 1:K
%         num{i}(a,1) = l(i,2)*(K-1);
%         num{i}(a,2) = sum(antrain{i}{a});
%         num{i}(a,3) = num{i}(a,1)-num{i}(a,2);
%         num{i}(a,4) = l(i,2);
%         num{i}(a,5) = sum(antest{i}{a});
%         num{i}(a,6) = num{i}(a,4)-num{i}(a,5);
        num{i}(a,1) = length(antrain{i}{a});
        num{i}(a,2) = sum(antrain{i}{a});
        num{i}(a,3) = num{i}(a,1)-num{i}(a,2);
        num{i}(a,4) = length(antest{i}{a});
        num{i}(a,5) = sum(antest{i}{a});
        num{i}(a,6) = num{i}(a,4)-num{i}(a,5);
    end
%     num2(i,1) = l(i,1);
%     num2(i,2) = sum(antotal{i});
%     num2(i,3) = l(i,1)-num2(i,2);
end


% Training the model
options = statset('MaxIter',1e7);

parfor i = 1:N
        for a = 1:K
            tic;
            svmModel = svmtrain(ftrain{i}{a},antrain{i}{a},'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
            p{i}{a} = svmclassify(svmModel,ftest{i}{a});
            toc;
            
        end 
%         pt{i} = svmclassify(svmModel,ftotal{i});
end



% Analyze the result
for i = 1:N
    for a = 1:K
        s1 = ['temp = p{i}{a} - antest{i}{a}'';'];
        s2 = ['temp2 = abs(temp);'];
        eval(s1);
        eval(s2);
        s2 = ['num{i}(a,7) = sum(~temp2);'];
        s3 = ['num{i}(a,8) = sum(temp2);'];
        eval(s2);
        eval(s3);
        s4 = ['[t1,t2] = find(temp == 1);'];
        s5 = ['[t3,t4] = find(temp == -1);'];
        eval(s4);
        eval(s5);
    
        num{i}(a,9) = num{i}(a,5)-sum(t4);
        num{i}(a,10) = num{i}(a,6)-sum(t2);
    
        num{i}(a,11) = 100*num{i}(a,7)/num{i}(a,4);
        num{i}(a,12) = 100*num{i}(a,9)/num{i}(a,5);
        num{i}(a,13) = 100*num{i}(a,10)/num{i}(a,6);
    
        clear temp temp2 t1 t2 t3 t4;
    end
    num{i}(K+1,:) = sum(num{i});
    num{i}(K+1,11) = 100*num{i}(K+1,7)/num{i}(K+1,4);
    num{i}(K+1,12) = 100*num{i}(K+1,9)/num{i}(K+1,5);
    num{i}(K+1,13) = 100*num{i}(K+1,10)/num{i}(K+1,6);
    res(i,:) = num{i}(K+1,:);
end
res(N+1,:) = sum(res);
res(N+1,11) = 100*res(N+1,7)/res(N+1,4);
res(N+1,12) = 100*res(N+1,9)/res(N+1,5);
res(N+1,13) = 100*res(N+1,10)/res(N+1,6);






% for i = 1:N
%         temp = zeros(l(i,2),5);
%         for a = 3:l(i,2)-2
%             s1 = ['temp(a,1) = sum(pt{i}(a-1:a+1));'];
%             s2 = ['temp(a,2) = sum(pt{i}(a-2:a+2));'];
%             s3 = ['temp(a,3) = pt{i}(a);'];
%             eval(s1);
%             eval(s2);
%             eval(s3);
%             temp(a,4) = temp(a,2)*100+temp(a,1)*10+temp(a,3);
%             if temp(a,4) == 111
%                 s4 = ['pt{i}(a) = 0;'];
%                 eval(s4);
%             end
%             temp(a,5) = temp(a,1)*10+temp(a,3);
%             if temp(a,5) == 20
%                 s5 = ['pt{i}(a) = 1;'];
%                 eval(s5);
%             end
%         end
%         clear temp;
% 
% end
% for i = 1:N
%         s1 = ['temp = pt{i} - antotal{i}'';'];
%         s2 = ['temp2 = abs(temp);'];
%         eval(s1);
%         eval(s2);
%         s2 = ['num2(i,4) = sum(~temp2);'];
%         s3 = ['num2(i,5) = sum(temp2);'];
%         eval(s2);
%         eval(s3);
%         s4 = ['[t1,t2] = find(temp == 1);'];
%         s5 = ['[t3,t4] = find(temp == -1);'];
%         eval(s4);
%         eval(s5);
%     
%         num2(i,6) = num2(i,2)-sum(t4);
%         num2(i,7) = num2(i,3)-sum(t2);
%     
%         num2(i,8) = 100*num2(i,4)/num2(i,1);
%         num2(i,9) = 100*num2(i,6)/num2(i,2);
%         num2(i,10) = 100*num2(i,7)/num2(i,3);
%     
%         clear temp temp2 t1 t2 t3 t4;
% 
% end
% num2(N+1,:) = sum(num2);
% num2(N+1,8) = 100*num2(N+1,4)/num2(N+1,1);
% num2(N+1,9) = 100*num2(N+1,6)/num2(N+1,2);
% num2(N+1,10) = 100*num2(N+1,7)/num2(N+1,3);

% tic;
% tiktest = ftotal{1}(1:2000,:);
% tikan = antotal{1}(1:2000);
% p = svmclassify(svmModel,tiktest);
% toc;

