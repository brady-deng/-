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
% startmatlabpool(4);


%% Initial settings
N = 1;
P = 0.2;
trainP = 0.8;
K = 1/P;
% K = 1;
name = input('Please input the feature file you want to train:');
% T = input('Please input the T:');
% ST = input('Please input the ST:');
% testnum = fix((3600+T)/ST);
% box = input('Please input the boxconstriant:');
box = 0.05;
% sigma = input('Please input the rbg_sigma:');
% box = 0.5;
sigma = 1.0;
ker1 = 'linear';
ker2 = 'quadratic';
ker3 = 'polynomial';
ker4 = 'rbf';
ker5 = 'mlp';


s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];

eval(s1); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%下述训练方法采用阳性与阴性分别取样训练的方法，但是在时间上并没有打三
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = statset('MaxIter',1e7);
% for i = 1:N
%     s1 = ['inda = find(d.an.a',num2str(i),' == 1);'];
%     s2 = ['indn = find(d.an.a',num2str(i),' == 0);'];
%     s3 = ['dataa = d.f.f',num2str(i),'(:,inda);'];
%     s4 = ['datan = d.f.f',num2str(i),'(:,indn);'];
%     s5 = ['templ = length(d.an.a',num2str(i),');'];
%     s6 = ['labela = d.an.a',num2str(i),'(inda);'];
%     s7 = ['labeln = d.an.a',num2str(i),'(indn);'];
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
%     eval(s5);
%     eval(s6);
%     eval(s7);
%     
%     templtrn = ceil(length(indn)*trainP);
%     templtra = ceil(length(inda)*trainP);
%     templten = length(indn) - templtrn;
%     templtea = length(inda) - templtra;
%     templtr = templtrn+templtra;
%     templte = templten+templtea;
%     for k = 1:K
%         tempindn = ones(1,(templtrn+templten));
%         tempinda = ones(1,(templtra+templtea));
%         indten = (k-1)*templten+1:k*templten;
%         indtea = (k-1)*templtea+1:k*templtea;
%         tempindn(indten) = 0;
%         tempinda(indtea) = 0;
%         indtrn = find(tempindn == 1);
%         indtra = find(tempinda == 1);
%         datatr = [datan(:,indtrn),dataa(:,indtra)];
%         datate = [datan(:,indten),dataa(:,indtea)];
%         labeltr = [labeln(indtrn);labela(indtra)];
%         labelte = [labeln(indten);labela(indtea)];
%         datatr = datatr';
%         datate = datate';
%         svmModel = svmtrain(datatr,labeltr,'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
%         temppre =svmclassify(svmModel,datate);
%         rea{i}(k,1) = templ;
%         rea{i}(k,2) = templtr;
%         rea{i}(k,3) = templte;
%         rea{i}(k,4) = sum(labelte);
%         rea{i}(k,5) = templte - rea{i}(k,4);
%         cache = temppre - labelte;
%         cache2 = abs(cache);
%         rea{i}(k,6) = sum(~cache2);
%         rea{i}(k,7) = sum(cache2);
%         [t1,t2] = find(cache == 1);
%         [t3,t4] = find(cache == -1);
%         rea{i}(k,8) = rea{i}(k,4) - sum(t4);
%         rea{i}(k,9) = rea{i}(k,5) - sum(t2);
%         % 正确率
%         rea{i}(k,10) = 100*rea{i}(k,6)/rea{i}(k,3);
%         % 正阳率
%         rea{i}(k,11) = 100*rea{i}(k,8)/rea{i}(k,4);
%         % 正阴率
%         rea{i}(k,12) = 100*rea{i}(k,9)/rea{i}(k,5);
%         rea{i}(k,13) = sum(labeltr);
%         rea{i}(k,14) = rea{i}(k,2) - rea{i}(k,13);
%         clear tempindn tempinda indten indtea indtrn indtra datatr datate labeltr labelte temppre cache cache2 t1 t2 t3 t4 svmModel
%     end
%     rea{i}(K+1,:) = sum(rea{i});
%     rea{i}(K+1,10) = 100*rea{i}(K+1,6)/rea{i}(K+1,3);
%     rea{i}(K+1,11) = 100*rea{i}(K+1,8)/rea{i}(K+1,4);
%     rea{i}(K+1,12) = 100*rea{i}(K+1,9)/rea{i}(K+1,5);
%     clear indn inda datan dataa templ labela labeln templtrn templtra templten templtea templtr templte
% end
% 
% result_ind = rea;
% clear rea;

% options = statset('MaxIter',1e7);
% for k = 1:K
%     datatr_total = [];
%     datate_total = [];
%     labeltr_total = [];
%     labelte_total = [];
%     for i = 1:N
%         s1 = ['inda = find(d.an.a',num2str(i),' == 1);'];
%         s2 = ['indn = find(d.an.a',num2str(i),' == 0);'];
%         s3 = ['dataa = d.f.f',num2str(i),'(:,inda);'];
%         s4 = ['datan = d.f.f',num2str(i),'(:,indn);'];
%         s5 = ['templ = length(d.an.a',num2str(i),');'];
%         s6 = ['labela = d.an.a',num2str(i),'(inda);'];
%         s7 = ['labeln = d.an.a',num2str(i),'(indn);'];
%         eval(s1);
%         eval(s2);
%         eval(s3);
%         eval(s4);
%         eval(s5);
%         eval(s6);
%         eval(s7);
%         templtrn = ceil(length(indn)*trainP);
%         templtra = ceil(length(inda)*trainP);
%         templten = length(indn) - templtrn;
%         templtea = length(inda) - templtra;
%         templtr = templtrn+templtra;
%         templte = templten+templtea;
%         tempindn = ones(1,(templtrn+templten));
%         tempinda = ones(1,(templtra+templtea));
%         indten = (k-1)*templten+1:k*templten;
%         indtea = (k-1)*templtea+1:k*templtea;
%         tempindn(indten) = 0;
%         tempinda(indtea) = 0;
%         indtrn = find(tempindn == 1);
%         indtra = find(tempinda == 1);
%         datatr = [datan(:,indtrn),dataa(:,indtra)];
%         datate = [datan(:,indten),dataa(:,indtea)];
%         labeltr = [labeln(indtrn);labela(indtra)];
%         labelte = [labeln(indten);labela(indtea)];
%         
%         datatr_total = [datatr_total,datatr];
%         datate_total = [datate_total,datate];
%         labeltr_total = [labeltr_total;labeltr];
%         labelte_total = [labelte_total;labelte];
%         clear inda indn data datan templ templtr templte tempind indte indtr datatr datate labeltr labelte templtrn templtra templten templtea tempinda tempindn indten indtrn indtea indtrn
%     end
%     datatr_total = datatr_total';
%     temp_indn = find(labeltr_total == 0);
%     temp_dsn = temp_indn(1:2:end);
%     datatr_total(temp_dsn,:) = [];
%     labeltr_total(temp_dsn) = [];
%     datate_total = datate_total';
%     svmModel = svmtrain(datatr_total,labeltr_total,'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',box,'rbf_sigma',sigma);
%     temppre =svmclassify(svmModel,datate_total);
%     rea(k,1) = length(labeltr_total)+length(labelte_total);
%     rea(k,2) = length(labeltr_total);
%     rea(k,3) = rea(k,1) - rea(k,2);
%     rea(k,4) = sum(labelte_total);
%     rea(k,5) = rea(k,3) - rea(k,4);
%     cache = temppre - labelte_total;
%     cache2 = abs(cache);
%     rea(k,6) = sum(~cache2);
%     rea(k,7) = sum(cache2);
%     [t1,t2] = find(cache == 1);
%     [t3,t4] = find(cache == -1);
%     rea(k,8) = rea(k,4) - sum(t4);
%     rea(k,9) = rea(k,5) - sum(t2);
%     % 正确率
%     rea(k,10) = 100*rea(k,6)/rea(k,3);
%     % 正阳率
%     rea(k,11) = 100*rea(k,8)/rea(k,4);
%     % 正阴率
%     rea(k,12) = 100*rea(k,9)/rea(k,5);
%     rea(k,13) = sum(labeltr_total);
%     rea(k,14) = rea(k,2) - rea(k,13);
%     clear datatr_total datate_total labeltr_total labelte_total temppre svmModel temp_indn temp_dsn
% end
% save('rea.mat','rea');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%911 train，时间上进行打散在进行训练
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin = [2,4,5,6,7,8,9];
% bin = [2,4,5,6,8,9]; %使用特征集合中的1、3、7号特征进行训练
bin = [2,4,6,8,9]; %使用特征集合中的1、3、5、7号特征进行训练
d.f.f1(bin,:) = [];
for i = 1:N
    s911 = ['templ = length(d.f.f',num2str(i),');'];
    eval(s911);
    templk = floor(templ*P);
    templktrain = floor(templk*trainP);
    templktest = templk - templktrain;

    for k = 1:K
        s912 = ['temp{k} = d.f.f',num2str(i),'(:,templk*(k-1)+1:templk*k);'];
        s913 = ['label{k} = d.an.a',num2str(i),'(templk*(k-1)+1:templk*k);'];
        eval(s912);
        eval(s913);
    end
    for iter = 1:K
        datatrain = [];
        labeltrain = [];
        datatest = [];
        labeltest = [];
%         obn{i}{iter} = [];
%         oba{i}{iter} = [];
        tempind = zeros(1,templk);
        tempind((iter-1)*templktest+1:iter*templktest) = 1;
        indte = find(tempind == 1);
%         tempind = ~tempind;
        indtr = find(tempind == 0);
        for k = 1:K


            temptrain = temp{k}(:,indtr);
            temptest = temp{k}(:,indte);
            templatr = label{k}(indtr);
            template = label{k}(indte);
            datatrain = [datatrain,temptrain];
            datatest = [datatest,temptest];
            labeltrain = [labeltrain;templatr];
            labeltest = [labeltest;template];

            clear temptrain temptest templatr template
        end
        datatrain = datatrain';
        datatest = datatest';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   测试标准化的影响，913
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [dtrain,mu,st] = zscore(datatrain);
%         dtest = zscore(datatest);
        mu = repmat(mu,length(labeltest),1);
        st = repmat(st,length(labeltest),1);
        dtest = (datatest-mu)./st;
        
%         svmModel = svmtrain(datatrain,labeltrain,'kernel_function',ker4,'options',options,'autoscale',true,'boxconstraint',1.15,'rbf_sigma',sigma,'showplot',false);
        svmModel = svmtrain(dtrain,labeltrain,'kernel_function',ker4,'options',options,'autoscale',false,'boxconstraint',1.15,'rbf_sigma',sigma,'showplot',false);
%         temppre = svmclassify(svmModel,datatest);
        temppre =svmclassify(svmModel,dtest);
        rea{i}(iter,1) = templ;
        rea{i}(iter,2) = length(labeltrain);
        rea{i}(iter,3) = length(labeltest);
        rea{i}(iter,4) = sum(labeltest);
        rea{i}(iter,5) = rea{i}(iter,3) - rea{i}(iter,4);
        cache = temppre - labeltest;
        cache2 = abs(cache);
        
        rea{i}(iter,6) = sum(~cache2);
        rea{i}(iter,7) = sum(cache2);
        [t1,t2] = find(cache == 1);
        [t3,t4] = find(cache == -1);
        obn{i}{iter} = t1;
        oba{i}{iter} = t3;
        rea{i}(iter,8) = rea{i}(iter,4) - sum(t4);
        rea{i}(iter,9) = rea{i}(iter,5) - sum(t2);
        % 正确率
        rea{i}(iter,10) = 100*rea{i}(iter,6)/rea{i}(iter,3);
        % 正阳率
        rea{i}(iter,11) = 100*rea{i}(iter,8)/rea{i}(iter,4);
        % 正阴率
        rea{i}(iter,12) = 100*rea{i}(iter,9)/rea{i}(iter,5);
        rea{i}(iter,13) = sum(labeltrain);
        rea{i}(iter,14) = rea{i}(iter,2) - rea{i}(iter,13);
        clear tempind indte indtr;

    end
    rea{i}(K+1,:) = sum(rea{i});
    rea{i}(K+1,10) = 100*rea{i}(K+1,6)/rea{i}(K+1,3);
    % 正阳率
    rea{i}(K+1,11) = 100*rea{i}(K+1,8)/rea{i}(K+1,4);
    % 正阴率
    rea{i}(K+1,12) = 100*rea{i}(K+1,9)/rea{i}(K+1,5);
        
    
    
    
end
    