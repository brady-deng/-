clc;
clear;
% close all;
T = input('Please input the data name you want to extract features:');
flowt = input('Please input the flowt:');
spt = input('Please input the spt:');
s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',T,'.mat'');'];
eval(s1);
index = input('Please input the index of the subject you want to extract:');

% tic;
% T = data.T;

fs = 128;
N = 23;
C = 16;
%   Here C is the downsampling index.
an = data.a;
ind_time = data.i;
rfs = 8;
WT = data.T;
ST = data.WT;
FT = 10;
subt = WT/FT-1;
WL = WT*rfs;
RESO = 2*rfs/WL;
IF = 0.5;
IN = fix(IF/RESO);
if index == 0
    for i = 1:N
        s1 = ['d.f',num2str(i),' = data.s.f',num2str(i),';'];
        eval(s1);
    %     s2 = ['d.Sp',num2str(i),' = data.s.Sp',num2str(i),';'];
        s2 = ['d.Sp',num2str(i),' = data.s.Sp',num2str(i),'(1:8:end,:);'];
        eval(s2);
        s3 = ['d.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
        s4 = ['l(i) = length(d.f',num2str(i),'(1,:));'];
        eval(s4);
        s5 = ['d.Sp.d',num2str(i),' = std(d.Sp',num2str(i),');'];
        s6 = ['d.f.d',num2str(i),' = std(d.f',num2str(i),');'];
        s7 = ['d.f.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
        eval(s7);
        s8 = ['d.f.ftk',num2str(i),' = d.f.fft',num2str(i),'(1:20,:);'];
        eval(s8);
        s9 = ['d.f.ftk',num2str(i),' = mapminmax(d.f.ftk',num2str(i),''');'];
        s10 = ['d.f.kur',num2str(i),' = kurtosis(d.f.ftk',num2str(i),');'];
        eval(s10);

    end
    temp_l = data.l;
    clear data
    ft = [];
    at = [];
    t = [1/(rfs*WT):1/(rfs*WT):1];
    % 低通气比例
    Hapor = 0.7;
    % 正常通气比例
    HaporH = 0.85;
    % 低通气血氧比例
    HaSp = 0.98;
    % 呼吸停滞比例
    apor = 0.3;
    flowth = [0,9,15];
    ST = flowt;
    for i = 1:N
    %     temp1，呼吸起始点与终止点
    %     temp2，流量峰值
        s971 = ['[temp1,temp2] = breathphse(d.f',num2str(i),');'];
        eval(s971);
    %     temp3流量峰值之和
        temp3 = sum(abs(temp2));
    %     temp5流量峰值最大值
        temp5 = max(abs(temp2));
    %     hathre流量低通气阈值
    %     更新为该段最大值，因为有可能捕捉不到最大呼吸流量点
    %   tempmax，附近窗口长度加ST的时间段内的第二大的值
    %   tempmin，附近窗口长度加ST的时间段内的第二小的值
        s1009 = ['[tempmax,tempmin] = Findmax(temp2(1:5,:),ST);'];
        eval(s1009);
        s911 = ['hathreh = Hapor*tempmax;'];
        s1008 = ['hathrel = Hapor*tempmin'];
        s912 = ['athreh = apor*tempmax;'];
        s1009 = ['athrel = apor*tempmin;'];
        s913 = ['hathreH = HaporH*tempmax;'];
        eval(s911);
        eval(s1008);
        eval(s1009);
        eval(s912);
        eval(s913);
    %     s1009 = ['[tempmax,tempmin] = Findmax(d.f',num2str(i),');'];
    %     eval(s1009);
    %     for k = 1:length(hathreh)
    %         if hathreh(k) > 8.5
    %             hathreh(k) = 8.5;
    %         end
    %         if hathrel(k) < - 8.5
    %             hathrel(k) = -8.5;
    %         end
    %     end
    %     tempHa低通气次数，tempL是完整呼吸次数
        tempA = zeros(1,length(temp1));
        tempHa = zeros(1,length(temp1));
        tempHaH = zeros(1,length(temp1));
        for count = 1:length(temp1)
            tempL(count) = length(temp1{count});
            temp4(count) = length(temp1{count});
            for tempcount = 1:tempL(count)
                if temp2(tempcount,count)>0 && temp2(tempcount,count)<hathreh(count)
                    tempHa(count) = tempHa(count)+1;
                    if temp2(tempcount,count) < athreh(count)
                        tempA(count) = tempA(count)+1;
                    end
                end
                if temp2(tempcount,count)<0 && temp2(tempcount,count)>hathrel(count)
                    tempHa(count) = tempHa(count)+1;
                    if temp2(tempcount,count) > athrel(count)
                        tempA(count) = tempA(count)+1;
                    end
                end
                if abs(temp2(tempcount,count))>hathreH(count)
                    tempHaH(count) = tempHaH(count)+1;
                end
            end
        end
        tempzero = find(tempL == 0);
%         tempL(tempob) = 
        s1008 = ['spmax = FindSp(d.Sp',num2str(i),',spt);'];
        eval(s1008);
        % 呼吸流量峰值
    %     s972 = ['f.f',num2str(i),'(1,:) = temp3./temp4;'];
        % 血氧方差，可以0.8821 ,AUC最大，比较均衡，（10，64）
        s973 = ['f.f',num2str(i),'(1,:) = std(d.Sp',num2str(i),');'];
        eval(s973);
        % 血氧极差，可以0.8664，与特征1类似，比较均衡，可以用1号特征代替，（10，60）
        s974 = ['f.f',num2str(i),'(2,:) = max(d.Sp',num2str(i),')-min(d.Sp',num2str(i),');'];
        eval(s974);
        % 呼吸次数
    %     s975 = ['f.f',num2str(i),'(4,:) = tempL'];
        % 低通气次数所占比重，可以0.8297，相对于特征1对阳性比较敏感，但是真阳率上升的还是比较慢，（40，98），（50，99），（10，20）
        s976 = ['f.f',num2str(i),'(3,:) = tempHa./tempL;'];
        eval(s976);
        s1031 = ['f.f',num2str(i),'(3,tempzero) = 1;'];
        eval(s1031);
        % 低通气次数，可以0.8219，与特征3类似，应该可以用特征3代替，
        s977 = ['f.f',num2str(i),'(4,:) = tempHa;'];
        eval(s977);
        % 血氧低通气次数，可以0.8453，比较均衡，与特征1比较类似，可以用1号特征代替，真阳率没有达到90，（10，60）
        s978 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',spmax*HaSp);'];
        eval(s978);
        % 最小值与索引
        s979 = ['[var1,var2] = min(d.Sp',num2str(i),');'];
        eval(s979);
        % 最大值与索引，
        s980 = ['[var3,var4] = max(d.Sp',num2str(i),');'];
        eval(s980);
        % 从最小值到最大值的斜率，没啥用，不太行，这个特征没什么用，可以考虑，会有分布的不同
        s981 = ['f.f',num2str(i),'(6,:) = 100*(var3-var1)./(var4-var2);'];
        eval(s981);
        tempequl = find((var4-var2) == 0);
        s1120 = ['f.f',num2str(i),'(6,tempequl) = 0;'];
        eval(s1120);
        % 高于峰值流量百分之九十的比例，对阴性样本比较敏感，应该可以用1号特征代替，AUC0.7773，（50，98）,(60,95)，有一部分重叠，但是不多
        s983 = ['f.f',num2str(i),'(7,:) = tempHaH./tempL;'];
        eval(s983);
        s1031 = ['f.f',num2str(i),'(7,tempzero) = 0;'];
        eval(s1031);
        % 频率谱峰度，不行，AUC0.70，对哪一类都不敏感
        s984 = ['f.f',num2str(i),'(8,:) = d.f.kur',num2str(i),';'];
        eval(s984);
        % 呼吸停滞次数,不太行，但是是不是可以用来确定Apnea？，不行，对哪一类都不敏感，看起来还可以呀，
        s911 = ['f.f',num2str(i),'(9,:) = tempA./tempL;'];
        eval(s911);
        s1120 = ['f.f',num2str(i),'(9,tempzero) = 1;'];
        eval(s1120);
        % 血氧低于91的时长
        s9191 = ['f.f',num2str(i),'(10,:) = Findlow(d.Sp',num2str(i),',91);'];
        % 血氧低于92的时长，会有区别，但是重叠的部分同样会很多
        s9192 = ['f.f',num2str(i),'(11,:) = Findlow(d.Sp',num2str(i),',92);'];
        eval(s9191);
        eval(s9192);
        % 呼吸处于停滞的时间,不能捕捉到该特征，会有一定的区别，阳性样本总体分布更大一些，但是重叠的部分太多了
        s9121 = ['f.f',num2str(i),'(12,:) = Findlow(abs(d.f',num2str(i),'),4);'];
        eval(s9121);
        s9122 = ['temp = d.f.ftk',num2str(i),';'];
        eval(s9122);
        % 血氧片段的总体走势，有一定的区别，但是不大，硬性样本会更分布在0以下的地方，阴性样本会分布在0的周围，但是会有很大的重叠
        s9194 = ['f.f',num2str(i),'(13,:) = 100*(d.Sp',num2str(i),'(end,:)-d.Sp',num2str(i),'(1,:))/WL;'];
        eval(s9194);
        s1008 = ['temp = max(d.Sp',num2str(i),');'];
        eval(s1008);
        s1009 = ['temp = [90,temp(1:end-1)];'];
        eval(s1009);
        % 14号特征与5号特征相似，只是进一步处理，如果当前窗口血氧总体上升则记为零，总体下降的话则记为原数
        s978 = ['f.f',num2str(i),'(14,:) = Findlow(d.Sp',num2str(i),',temp*HaSp);'];
        eval(s978);
        s1009 = ['temp = f.f',num2str(i),'(13,:);'];
        eval(s1009);
        for k = 1:length(temp)
            if temp(k) > 0
                s1009 = ['f.f',num2str(i),'(14,k) = 0'];
                eval(s1009);
            end
        end
        s1023 = ['spmean = Findspm(d.Sp',num2str(i),',spt);'];
        eval(s1023);
        % 低于前10s钟的平均血氧的时间
        s1023 = ['f.f',num2str(i),'(15,:) = Findlow(d.Sp',num2str(i),',spmean*HaSp);'];
        eval(s1023);
        % 从血氧基线下降的血氧水平
        s1023 = ['f.f',num2str(i),'(16,:) = spmean - mean(d.Sp',num2str(i),');'];
        eval(s1023);
        tempf = abs(temp2);
        % 平均通气量
        s1023 = ['f.f',num2str(i),'(17,:) = sum(tempf)./tempL;'];
        eval(s1023);
        s1031 = ['f.f',num2str(i),'(17,tempzero) = 0;'];
        eval(s1031);
        for k = 1:length(temp)
            tempind = find(tempf(:,k)~=0);
            % 通气量标准差
            if isempty(tempind)
                s1023 = ['f.f',num2str(i),'(18,k) = 0;'];
                eval(s1023);
                s1023 = ['f.f',num2str(i),'(19,k) = 0;'];
                eval(s1023);
                s1028 = ['f.f',num2str(i),'(21,k) = 0;'];
                eval(s1028);
            else
                s1023 = ['f.f',num2str(i),'(18,k) = std(tempf(tempind,k));'];
                eval(s1023);
                % 通气量极差
                s1023 = ['f.f',num2str(i),'(19,k) = max(tempf(tempind,k)) - min(tempf(tempind,k));'];
                eval(s1023);
                s1028 = ['f.f',num2str(i),'(21,k) = tempmax(k) - mean(tempf(tempind,k));'];
                eval(s1028);
            end
        end
        % 相当于血氧下降的水平
        s1023 = ['f.f',num2str(i),'(20,:) = spmax - mean(d.Sp',num2str(i),');'];
        eval(s1023);
        clear temp1 temp2 temp3 temp4 temp5 tempA tempHa tempHaH tempL tempmax tempmin
        clear tempind tempf
    end
else
    s1 = ['d.f',num2str(index),' = data.s.f',num2str(index),';'];
    eval(s1);
%     s2 = ['d.Sp',num2str(index),' = data.s.Sp',num2str(index),';'];
    s2 = ['d.Sp',num2str(index),' = data.s.Sp',num2str(index),'(1:8:end,:);'];
    eval(s2);
    s3 = ['d.fft',num2str(index),' = abs(fft(d.f',num2str(index),'));'];
    s4 = ['l(index) = length(d.f',num2str(index),'(1,:));'];
    eval(s4);
    s5 = ['d.Sp.d',num2str(index),' = std(d.Sp',num2str(index),');'];
    s6 = ['d.f.d',num2str(index),' = std(d.f',num2str(index),');'];
    s7 = ['d.f.fft',num2str(index),' = abs(fft(d.f',num2str(index),'));'];
    eval(s7);
    s8 = ['d.f.ftk',num2str(index),' = d.f.fft',num2str(index),'(1:10,:);'];
    eval(s8);
    
    s10 = ['d.f.kur',num2str(index),' = kurtosis(d.f.ftk',num2str(index),');'];
    eval(s10);
    temp_l = data.l;
    clear data
    ft = [];
    at = [];
    t = [1/(rfs*WT):1/(rfs*WT):1];
    % 低通气比例
    Hapor = 0.7;
    % 正常通气比例
    HaporH = 0.85;
    % 低通气血氧比例
    HaSp = 0.98;
    % 呼吸停滞比例
    apor = 0.3;
    flowth = [0,9,15];
    ST = flowt;
    %     temp1，呼吸起始点与终止点
    %     temp2，流量峰值
    s971 = ['[temp1,temp2] = breathphse(d.f',num2str(index),');'];
    eval(s971);
%     temp3流量峰值之和
    temp3 = sum(abs(temp2));
%     temp5流量峰值最大值
    temp5 = max(abs(temp2));
%     hathre流量低通气阈值
%     更新为该段最大值，因为有可能捕捉不到最大呼吸流量点
%   tempmax，附近窗口长度加ST的时间段内的第二大的值
%   tempmin，附近窗口长度加ST的时间段内的第二小的值
    s1009 = ['[tempmax,tempmin] = Findmax(temp2(1:5,:),ST);'];
    eval(s1009);
    s911 = ['hathreh = Hapor*tempmax;'];
    s1008 = ['hathrel = Hapor*tempmin'];
    s912 = ['athreh = apor*tempmax;'];
    s1009 = ['athrel = apor*tempmin;'];
    s913 = ['hathreH = HaporH*tempmax;'];
    eval(s911);
    eval(s1008);
    eval(s1009);
    eval(s912);
    eval(s913);
    tempA = zeros(1,length(temp1));
    tempHa = zeros(1,length(temp1));
    tempHaH = zeros(1,length(temp1));
    for count = 1:length(temp1)
        tempL(count) = length(temp1{count});
        temp4(count) = length(temp1{count});
        for tempcount = 1:tempL(count)
            if temp2(tempcount,count)>0 && temp2(tempcount,count)<hathreh(count)
                tempHa(count) = tempHa(count)+1;
                if temp2(tempcount,count) < athreh(count)
                    tempA(count) = tempA(count)+1;
                end
            end
            if temp2(tempcount,count)<0 && temp2(tempcount,count)>hathrel(count)
                tempHa(count) = tempHa(count)+1;
                if temp2(tempcount,count) > athrel(count)
                    tempA(count) = tempA(count)+1;
                end
            end
            if abs(temp2(tempcount,count))>hathreH(count)
                tempHaH(count) = tempHaH(count)+1;
            end
        end
    end
    tempzero = find(tempL == 0);
    s1008 = ['spmax = FindSp(d.Sp',num2str(index),',spt);'];
    eval(s1008);
    % 呼吸流量峰值
%     s972 = ['f.f',num2str(index),'(1,:) = temp3./temp4;'];
    % 血氧方差，可以0.8821 ,AUC最大，比较均衡，（10，64）
    s973 = ['f.f',num2str(index),'(1,:) = std(d.Sp',num2str(index),');'];
    eval(s973);
    % 血氧极差，可以0.8664，与特征1类似，比较均衡，可以用1号特征代替，（10，60）
    s974 = ['f.f',num2str(index),'(2,:) = max(d.Sp',num2str(index),')-min(d.Sp',num2str(index),');'];
    eval(s974);
    % 呼吸次数
%     s975 = ['f.f',num2str(index),'(4,:) = tempL'];
    % 低通气次数所占比重，可以0.8297，相对于特征1对阳性比较敏感，但是真阳率上升的还是比较慢，（40，98），（50，99），（10，20）
    s976 = ['f.f',num2str(index),'(3,:) = tempHa./tempL;'];
    eval(s976);
    s1031 = ['f.f',num2str(index),'(3,tempzero) = 1;'];
    eval(s1031);
    % 低通气次数，可以0.8219，与特征3类似，应该可以用特征3代替，
    s977 = ['f.f',num2str(index),'(4,:) = tempHa;'];
    eval(s977);
    % 血氧低通气次数，可以0.8453，比较均衡，与特征1比较类似，可以用1号特征代替，真阳率没有达到90，（10，60）
    s978 = ['f.f',num2str(index),'(5,:) = Findlow(d.Sp',num2str(index),',spmax*HaSp);'];
    eval(s978);
    % 最小值与索引
    s979 = ['[var1,var2] = min(d.Sp',num2str(index),');'];
    eval(s979);
    % 最大值与索引，
    s980 = ['[var3,var4] = max(d.Sp',num2str(index),');'];
    eval(s980);
    % 从最小值到最大值的斜率，没啥用，不太行，这个特征没什么用，可以考虑，会有分布的不同
    s981 = ['f.f',num2str(index),'(6,:) = 100*(var3-var1)./(var4-var2);'];
    eval(s981);
    tempequl = find((var4-var2) == 0);
    s1120 = ['f.f',num2str(index),'(6,tempequl) = 0;'];
    eval(s1120);
    % 高于峰值流量百分之九十的比例，对阴性样本比较敏感，应该可以用1号特征代替，AUC0.7773，（50，98）,(60,95)，有一部分重叠，但是不多
    s983 = ['f.f',num2str(index),'(7,:) = tempHaH./tempL;'];
    eval(s983);
    s1031 = ['f.f',num2str(index),'(7,tempzero) = 0;'];
    eval(s1031);
    % 频率谱峰度，不行，AUC0.70，对哪一类都不敏感
    s984 = ['f.f',num2str(index),'(8,:) = d.f.kur',num2str(index),';'];
    eval(s984);
    % 呼吸停滞次数,不太行，但是是不是可以用来确定Apnea？，不行，对哪一类都不敏感，看起来还可以呀，
    s911 = ['f.f',num2str(index),'(9,:) = tempA./tempL;'];
    eval(s911);
    s1120 = ['f.f',num2str(index),'(9,tempzero) = 1;'];
    eval(s1120);
    % 血氧低于91的时长
    s9191 = ['f.f',num2str(index),'(10,:) = Findlow(d.Sp',num2str(index),',91);'];
    % 血氧低于92的时长，会有区别，但是重叠的部分同样会很多
    s9192 = ['f.f',num2str(index),'(11,:) = Findlow(d.Sp',num2str(index),',92);'];
    eval(s9191);
    eval(s9192);
    % 呼吸处于停滞的时间,不能捕捉到该特征，会有一定的区别，阳性样本总体分布更大一些，但是重叠的部分太多了
    s9121 = ['f.f',num2str(index),'(12,:) = Findlow(abs(d.f',num2str(index),'),4);'];
    eval(s9121);
    s9122 = ['temp = d.f.ftk',num2str(index),';'];
    eval(s9122);
    % 血氧片段的总体走势，有一定的区别，但是不大，硬性样本会更分布在0以下的地方，阴性样本会分布在0的周围，但是会有很大的重叠
    s9194 = ['f.f',num2str(index),'(13,:) = 100*(d.Sp',num2str(index),'(end,:)-d.Sp',num2str(index),'(1,:))/WL;'];
    eval(s9194);
    s1008 = ['temp = max(d.Sp',num2str(index),');'];
    eval(s1008);
    s1009 = ['temp = [90,temp(1:end-1)];'];
    eval(s1009);
    s978 = ['f.f',num2str(index),'(14,:) = f.f',num2str(index),'(5,:);'];
    eval(s978);
    s1009 = ['temp = f.f',num2str(index),'(3,:);'];
    eval(s1009);
    for k = 1:length(temp)
        if temp(k) == 0
            s1009 = ['f.f',num2str(index),'(14,k) = 0'];
            eval(s1009);
        end
    end
    s1023 = ['spmean = Findspm(d.Sp',num2str(index),',spt);'];
    eval(s1023);
    % 低于前10s钟的平均血氧的时间
    s1023 = ['f.f',num2str(index),'(15,:) = Findlow(d.Sp',num2str(index),',spmean*HaSp);'];
    eval(s1023);
    % 从血氧基线下降的血氧水平
    s1023 = ['f.f',num2str(index),'(16,:) = spmean - mean(d.Sp',num2str(index),');'];
    eval(s1023);
    tempf = abs(temp2);
    % 平均通气量
    s1023 = ['f.f',num2str(index),'(17,:) = sum(tempf)./tempL;'];
    eval(s1023);
    s1031 = ['f.f',num2str(index),'(17,tempzero) = 0;'];
    eval(s1031);
    for k = 1:length(temp)
        tempind = find(tempf(:,k)~=0);
        % 通气量标准差
        if isempty(tempind)
            s1023 = ['f.f',num2str(index),'(18,k) = 0;'];
            eval(s1023);
            s1023 = ['f.f',num2str(index),'(19,k) = 0;'];
            eval(s1023);
            s1028 = ['f.f',num2str(index),'(21,k) = 0;'];
            eval(s1028);
        else
            s1023 = ['f.f',num2str(index),'(18,k) = std(tempf(tempind,k));'];
            eval(s1023);
            % 通气量极差
            s1023 = ['f.f',num2str(index),'(19,k) = max(tempf(tempind,k)) - min(tempf(tempind,k));'];
            eval(s1023);
            s1028 = ['f.f',num2str(index),'(21,k) = tempmax(k) - mean(tempf(tempind,k));'];
            eval(s1028);
        end
    end
    % 相当于血氧下降的水平
    s1023 = ['f.f',num2str(index),'(20,:) = spmax - mean(d.Sp',num2str(index),');'];
    eval(s1023);
    
    clear temp1 temp2 temp3 temp4 temp5 tempA tempHa tempHaH tempL tempmax tempmin
    clear tempind tempf
end
name = input('Please input the feature file name you want to save:');
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'',''f'',''an'',''ft'',''at'',''WT'',''ST'',''temp_l'',''ind_time'');'];
eval(s13);