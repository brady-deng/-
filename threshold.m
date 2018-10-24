%% 12-23
%   SVM for classify apnea for each subject
%   brady deng
%   Last editted by Brady deng in 2-28.
%   Use 5-fold cross validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
% clear;
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
box = 1;
% sigma = input('Please input the rbg_sigma:');
% box = 0.5;
sigma = 1;
ker1 = 'linear';
ker2 = 'quadratic';
ker3 = 'polynomial';
ker4 = 'rbf';
ker5 = 'mlp';


s1 = ['dob = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'');'];


eval(s1); 

index = input('Please input the index of the subject you want to train:');
if index == 0
    s1015 = ['num_fea = length(dob.f.f',num2str(index+1),'(:,1));'];
    eval(s1015);
else
    s1015 = ['num_fea = length(dob.f.f',num2str(index),'(:,1));'];
    eval(s1015);
end
areas = zeros(23+1,num_fea);
if index == 0
    for index = 1:23
        s1015 = ['tempsig = dob.f.f',num2str(index),';'];
        eval(s1015);
        s1015 = ['tempan = dob.an.a',num2str(index),';'];
        eval(s1015);
        standx = [0,100];
        standy = [0,100];

        for i = 1:num_fea
            sen{i} = [];
            spe{i} = [];
            num = 200;
            tempmax = max(tempsig(i,:));
            tempmin = min(tempsig(i,:));
        %     dur = tempmax - tempmin;
        %     tempmin = tempmin - 0.01*dur;
        %     tempmax = tempmax + 0.01*dur;
            step = (tempmax-tempmin)/num;

            for thre = tempmin:step:tempmax
                rea(1) = length(tempsig(1,:));
                rea(2) = sum(tempan);
                rea(3) = rea(1)-rea(2);
                temp = tempsig(i,:) - thre;
                temp2 = find(temp >= 0);
                temppre = zeros(rea(1),1);
                temppre(temp2) = 1;
                temp3 = temppre-tempan;
                temp4 = abs(temp3);
                temp5 = ~temp4;
                rea(4) = sum(temp5);
                rea(5) = rea(1)-rea(4);
                [t1,t2] = find(temp3 == 1);
                [t3,t4] = find(temp3 == -1);
                rea(6) = rea(2)-sum(t4);
                rea(7) = rea(3) - sum(t2);
                rea(8) = 100*rea(4)/rea(1);
                rea(9) = 100*rea(6)/rea(2);
                rea(10) = 100*rea(7)/rea(3);
                sen{i} = [sen{i};rea(9)];
                spe{i} = [spe{i};100-rea(10)];
            end
            for k = 1:num
                areas(index,i) = areas(index,i)+(sen{i}(k)+sen{i}(k+1))*(abs(spe{i}(k+1)-spe{i}(k)))/2;
            end
            areas(index,i) = areas(index,i)/10000;
            if areas(index,i)<0.5
                areas(index,i) = 1 - areas(index,i);
            end
    %         if areas(index,i) > 0.5
    %             figure(),plot(spe{i},sen{i});
    %             grid on;
    %             hold on;
    %             plot(standx,standy,'--');
    %             xlabel('100-Specificity');
    %             ylabel('Sensitivity');
    %             hold on;
    %             plot(20,0:100,'--');
    %             hold on;
    %             plot(0:100,80,'--');
    %             hold on;
    %             plot([100,0],[0,100],'--');
    %             name = ['feature:',num2str(i)];
    %             title(name);
    %         else
    %             figure(),plot(sen{i},spe{i});
    %             grid on;
    %             hold on;
    %             plot(standx,standy,'--');
    %             xlabel('100-Specificity');
    %             ylabel('Sensitivity');
    %             hold on;
    %             plot(20,0:100,'--');
    %             hold on;
    %             plot(0:100,80,'--');
    %             hold on;
    %             plot([100,0],[0,100],'--');
    %             name = ['feature:',num2str(i)];
    %             title(name);
    %             areas(index,i) = 1 - areas(index,i);
    %         end

        end
    end
    

    areas(end,:) = mean(areas(1:end-1,:));
else
    s1015 = ['tempsig = dob.f.f',num2str(index),';'];
    eval(s1015);
    s1015 = ['tempan = dob.an.a',num2str(index),';'];
    eval(s1015);
    standx = [0,100];
    standy = [0,100];

    for i = 1:num_fea
        sen{i} = [];
        spe{i} = [];
        num = 200;
        tempmax = max(tempsig(i,:));
        tempmin = min(tempsig(i,:));
        step = (tempmax-tempmin)/num;

        for thre = tempmin:step:tempmax
            rea(1) = length(tempsig(1,:));
            rea(2) = sum(tempan);
            rea(3) = rea(1)-rea(2);
            temp = tempsig(i,:) - thre;
            temp2 = find(temp >= 0);
            temppre = zeros(rea(1),1);
            temppre(temp2) = 1;
            temp3 = temppre-tempan;
            temp4 = abs(temp3);
            temp5 = ~temp4;
            rea(4) = sum(temp5);
            rea(5) = rea(1)-rea(4);
            [t1,t2] = find(temp3 == 1);
            [t3,t4] = find(temp3 == -1);
            rea(6) = rea(2)-sum(t4);
            rea(7) = rea(3) - sum(t2);
            rea(8) = 100*rea(4)/rea(1);
            rea(9) = 100*rea(6)/rea(2);
            rea(10) = 100*rea(7)/rea(3);
            sen{i} = [sen{i};rea(9)];
            spe{i} = [spe{i};100-rea(10)];
        end
        for k = 1:num
            areas(index,i) = areas(index,i)+(sen{i}(k)+sen{i}(k+1))*(abs(spe{i}(k+1)-spe{i}(k)))/2;
        end
        areas(index,i) = areas(index,i)/10000;
        if areas(index,i)<0.5
            areas(index,i) = 1 - areas(index,i);
        end
        if areas(index,i) > 0.5
            figure(),plot(spe{i},sen{i});
            grid on;
            hold on;
            plot(standx,standy,'--');
            xlabel('100-Specificity');
            ylabel('Sensitivity');
            hold on;
            plot(20,0:100,'--');
            hold on;
            plot(0:100,80,'--');
            hold on;
            plot([100,0],[0,100],'--');
            name = ['feature:',num2str(i)];
            title(name);
        else
            figure(),plot(sen{i},spe{i});
            grid on;
            hold on;
            plot(standx,standy,'--');
            xlabel('100-Specificity');
            ylabel('Sensitivity');
            hold on;
            plot(20,0:100,'--');
            hold on;
            plot(0:100,80,'--');
            hold on;
            plot([100,0],[0,100],'--');
            name = ['feature:',num2str(i)];
            title(name);
            areas(index,i) = 1 - areas(index,i);
        end

    end
end



