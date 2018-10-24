%% 12-23
%   SVM for classify apnea for each subject
%   brady deng
%   Last editted by Brady deng in 2-28.
%   Use 5-fold cross validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear;
% close all;

%% load data
startmatlabpool(4);


%% Initial settings
N = 23;
P = 0.2;
K = 1/P;
% K = 1;
name = input('Please input the feature file you want to train:');
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

eval(s1); 

% d.f.f1(4,:) = [];
% temp3 = [3,6,15,16,17,18];
% for i = 1:N
%     s1 = ['d.f.f',num2str(i),'(temp3,:) = [];'];
%     eval(s1);
% end
tempk = 0.8;
%   保证数据集的双盲性
for i = 1:N
    % 数据集总数目
    s961 = ['templ(i,1) = length(d.an.a',num2str(i),');'];
    % 训练集数目
    s962 = ['templ(i,2) = floor(templ(i,1)*tempk);'];
    % 测试集数目
    s963 = ['templ(i,3) = templ(i,1) - templ(i,2);'];
    eval(s961);
    eval(s962);
    eval(s963);
    s964 = ['dtrain{i} = d.f.f',num2str(i),'(:,1:templ(i,2));'];
    s965 = ['dtest{i} = d.f.f',num2str(i),'(:,templ(i,2)+1:end);'];
    s966 = ['latrain{i} = d.an.a',num2str(i),'(1:templ(i,2));'];
    s967 = ['latest{i} = d.an.a',num2str(i),'(templ(i,2)+1:end);'];
    s968 = ['d.f.f',num2str(i),' = dtrain{i};'];
    s969 = ['d.an.a',num2str(i),' = latrain{i};'];
    eval(s964);
    eval(s965);
    eval(s966);
    eval(s967);
    eval(s968);
    eval(s969);
    % 测试集阳性数目
    templ(i,4) = sum(latest{i});
    % 测试集阴性数目
    templ(i,5) = templ(i,3)-templ(i,4);
    templ(i,13) = sum(latrain{i});
    templ(i,14) = templ(i,2) - templ(i,13);
    dtest{i} = dtest{i}';
    dtrain{i} = dtrain{i}';
    
end
% temp3 = [1,4,5,6];
% for i = 1:N
%     s1 = ['d.f.f',num2str(i),'(temp3,:) = [];'];
%     eval(s1);
% end
for i = 1:N
    s1 = ['l(i,1) = length(d.an.a',num2str(i),');'];
    s2 = ['l(i,2) = fix(P*l(i,1));'];
    s3 = ['l(i,3) = l(i,1)-l(i,2);'];
    s4 = ['index{i} = 1:l(i,2)*K;'];
    s5 = ['in{i} = zeros(K,l(i,2)*K);'];
    s6 = ['ran{i} = rand(1,l(i,2)*K);'];
    s7 = ['[temp1,temp2] = sort(ran{i});'];
    s8 = ['index{i} = temp2;'];
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
%     eval(s6);
%     eval(s7);
%     eval(s8);
    clear temp1 temp2;
    
end
for i = 1:N
    for a = 1:K
%         ind{i}{a} = zeros(1,l(i,2));
        indte{i}{a} = index{i}((a-1)*l(i,2)+1:a*l(i,2));
%         indtr{i}{a} = index{i}(1:(a-1)*l(i,2),a*l(i,2)+1:end);
        s1 = ['ftest{i}{a} = d.f.f',num2str(i),'(:,indte{i}{a});'];
        s2 = ['antest{i}{a} = d.an.a',num2str(i),'(indte{i}{a});'];
        eval(s1);
        eval(s2);
        
        in{i}(a,(a-1)*l(i,2)+1:a*l(i,2)) = 1;
        
    end
%     in{i} = ~in{i};
    for a = 1:K
        in{i}(a,:) = ~in{i}(a,:);
        indtr{i}{a} = index{i}.*in{i}(a,:);
        indtr{i}{a}(find(indtr{i}{a} == 0)) = [];
        s1 = ['ftrain{i}{a} = d.f.f',num2str(i),'(:,indtr{i}{a});'];
        s2 = ['antrain{i}{a} = d.an.a',num2str(i),'(indtr{i}{a});'];
        eval(s1);
        eval(s2);
    end
    for a = 1:K
        s1 = ['ftrain{i}{a} = ftrain{i}{a}'';'];
        s2 = ['ftest{i}{a} = ftest{i}{a}'';'];
        s3 = ['antrain{i}{a} = antrain{i}{a}'';'];
        s4 = ['antest{i}{a} = antest{i}{a}'';'];
        eval(s1);
        eval(s2);
%         eval(s3);
%         eval(s4);
    end
    s1 = ['ftotal{i} = d.f.f',num2str(i),';'];
    s2 = ['antotal{i} = d.an.a',num2str(i),';'];
    eval(s1);
    eval(s2);
    s3 = ['ftotal{i} = ftotal{i}'';'];
    s4 = ['antotal{i} = antotal{i}'';'];
    eval(s3);
%     eval(s4);
        
end


% Building the training set and testing set
% for i = 1:N
%     s1 = ['indices{i} = crossvalind(''Kfold'',d.an.a',num2str(i),',K);'];
%     s2 = ['l(i,1) = length(d.an.a',num2str(i),');'];
%     s3 = ['l(i,2) = fix(P*l(i,1));'];
%     s4 = ['l(i,3) = l(i,1)-l(i,2);'];
%     s5 = ['temp1 = rand(1,l(i,1));'];
%     s6 = ['[temp2,temp3] = sort(temp1);'];
%     s7 = ['outorf{i} = d.f.f',num2str(i),'(:,temp3);'];
%     s8 = ['outora{i} = d.an.a',num2str(i),'(temp3);'];
%     
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
% %     eval(s5);
% %     eval(s6);
% %     eval(s7);
% %     eval(s8);
%     
%     clear temp1 temp2 temp3;
%     
%     for a = 1:K
%         indte{i}{a} = find(indices{i}==a);
%         indtr{i}{a} = find(indices{i}~=a);
% %         s1 = ['ftest{i}{a} = outorf{i}(:,indte{i}{a});'];
% %         s2 = ['antest{i}{a} = outora{i}(indte{i}{a});'];
%         s1 = ['ftest{i}{a} = d.f.f',num2str(i),'(:,indte{i}{a});'];
%         s2 = ['antest{i}{a} = d.an.a',num2str(i),'(indte{i}{a});'];
%         eval(s1);
%         eval(s2);
% %         s1 = ['ftrain{i}{a} = outorf{i}(:,indtr{i}{a});'];
% %         s2 = ['antrain{i}{a} = outora{i}(indtr{i}{a});'];
%         s1 = ['ftrain{i}{a} = d.f.f',num2str(i),'(:,indtr{i}{a});'];
%         s2 = ['antrain{i}{a} = d.an.a',num2str(i),'(indtr{i}{a});'];
%         eval(s1);
%         eval(s2);
%         s1 = ['ftrain{i}{a} = ftrain{i}{a}'';'];
%         s2 = ['ftest{i}{a} = ftest{i}{a}'';'];
%         s3 = ['antrain{i}{a} = antrain{i}{a}'';'];
%         s4 = ['antest{i}{a} = antest{i}{a}'';'];
%         eval(s1);
%         eval(s2);
% %         eval(s3);
% %         eval(s4);
%     end
%     s1 = ['ftotal{i} = d.f.f',num2str(i),';'];
%     s2 = ['antotal{i} = d.an.a',num2str(i),';'];
%     eval(s1);
%     eval(s2);
%     s3 = ['ftotal{i} = ftotal{i}'';'];
%     s4 = ['antotal{i} = antotal{i}'';'];
%     eval(s3);
%     eval(s4);
% end



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
%       训练集总数
        num{i}(a,1) = length(antrain{i}{a});
%       训练集阳性总数
        num{i}(a,2) = sum(antrain{i}{a});
%       训练集阴性总数
        num{i}(a,3) = num{i}(a,1)-num{i}(a,2);
%       测试集总数
        num{i}(a,4) = length(antest{i}{a});
%       测试集阳性总数
        num{i}(a,5) = sum(antest{i}{a});
%       测试集阴性总数
        num{i}(a,6) = num{i}(a,4)-num{i}(a,5);
    end
    num2(i,1) = l(i,1);
    num2(i,2) = sum(antotal{i});
    num2(i,3) = l(i,1)-num2(i,2);
end


% Training the model
options = statset('MaxIter',1e7);
% svmModel = {};
% parfor i = 1:N
%         for a = 1:K
%             tic;
%             svmModel = svmtrain(ftrain{i}{a},antrain{i}{a},'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
%             ssave{i}{a} = svmModel;
% %             s95 = ['svmsave.m',num2str(i),'.m',num2str(a),' = svmModel;'];
% %             eval(s95);
%             p{i}{a} = svmclassify(svmModel,ftest{i}{a});
%             tempp{i} =svmclassify(svmModel,dtest{i});
%             toc;
%             
%         end 
% %         pt{i} = svmclassify(svmModel,ftotal{i});
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%9-9训练
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parfor i = 1:N
        
    tic;
    svmModel = svmtrain(dtrain{i},latrain{i},'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
    ssave{i} = svmModel;
%             s95 = ['svmsave.m',num2str(i),'.m',num2str(a),' = svmModel;'];
%             eval(s95);
%     p{i}{a} = svmclassify(svmModel,ftest{i}{a});
    tempp{i} =svmclassify(svmModel,dtest{i});
    toc;
            
        
%         pt{i} = svmclassify(svmModel,ftotal{i});
end
% save('model.mat','ssave');
% save('model.mat',svmsave);

% Analyze the result
% for i = 1:N
%     for a = 1:K
%         s1 = ['temp = p{i}{a} - antest{i}{a};'];
%         s2 = ['temp2 = abs(temp);'];
%         eval(s1);
%         eval(s2);
%         % 分类正确总数
%         s2 = ['num{i}(a,7) = sum(~temp2);'];
%         % 分类错误总数
%         s3 = ['num{i}(a,8) = sum(temp2);'];
%         eval(s2);
%         eval(s3);
%         s4 = ['[t1,t2] = find(temp == 1);'];
%         s5 = ['[t3,t4] = find(temp == -1);'];
%         eval(s4);
%         eval(s5);
%         % 真阳数目
%         num{i}(a,9) = num{i}(a,5)-sum(t4);
%         % 真阴数目
%         num{i}(a,10) = num{i}(a,6)-sum(t2);
%     
%         num{i}(a,11) = 100*num{i}(a,7)/num{i}(a,4);
%         num{i}(a,12) = 100*num{i}(a,9)/num{i}(a,5);
%         num{i}(a,13) = 100*num{i}(a,10)/num{i}(a,6);
%     
%         clear temp temp2 t1 t2 t3 t4;
%     end
%     num{i}(K+1,:) = sum(num{i});
%     % 正确率
%     num{i}(K+1,11) = 100*num{i}(K+1,7)/num{i}(K+1,4);
%     % 正阳率
%     num{i}(K+1,12) = 100*num{i}(K+1,9)/num{i}(K+1,5);
%     % 正阴率
%     num{i}(K+1,13) = 100*num{i}(K+1,10)/num{i}(K+1,6);
%     res(i,:) = num{i}(K+1,:);
% end
% res(N+1,:) = sum(res);
% res(N+1,11) = 100*res(N+1,7)/res(N+1,4);
% res(N+1,12) = 100*res(N+1,9)/res(N+1,5);
% res(N+1,13) = 100*res(N+1,10)/res(N+1,6);



for i = 1:N
    
    s1 = ['temp = tempp{i} - latest{i};'];
    s2 = ['temp2 = abs(temp);'];
    eval(s1);
    eval(s2);
    % 分类正确数目
    s2 = ['templ(i,6) = sum(~temp2);'];
    % 分类错误数目
    s3 = ['templ(i,7) = sum(temp2);'];
    eval(s2);
    eval(s3);
    s4 = ['[t1,t2] = find(temp == 1);'];
    s5 = ['[t3,t4] = find(temp == -1);'];
    eval(s4);
    eval(s5);
    % 真阳数目
    templ(i,8) = templ(i,4)-sum(t4);
    % 真阴数目
    templ(i,9) = templ(i,5)-sum(t2);
    % 正确率
    templ(i,10) = 100*templ(i,6)/templ(i,3);
    % 正阳率
    templ(i,11) = 100*templ(i,8)/templ(i,4);
    % 正阴率
    templ(i,12) = 100*templ(i,9)/templ(i,5);

    clear temp temp2 t1 t2 t3 t4;
    
   
end
templ(N+1,:) = sum(templ);
templ(N+1,10) = 100*templ(N+1,6)/templ(N+1,3);
templ(N+1,11) = 100*templ(N+1,8)/templ(N+1,4);
templ(N+1,12) = 100*templ(N+1,9)/templ(N+1,5);

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
%         s1 = ['temp = pt{i} - antotal{i};'];
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

