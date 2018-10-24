clc;
clear;
% close all;
T = input('Please input the data name you want to extract features:');

s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',T,'.mat'');'];
eval(s1);
% tic;
% T = data.T;

fs = 128;
N = 1;
C = 16;
%   Here C is the downsampling index.
an = data.a;
rfs = 8;
WT = data.T;
ST = data.WT;
FT = 10;
subt = WT/FT-1;
WL = WT*rfs;
RESO = 2*rfs/WL;
IF = 0.5;
IN = fix(IF/RESO);
% data.s.f1 = data.s.f1(:,1:5000);
% data.s.Sp1 = data.s.Sp1(:,1:5000);
% data.a.a1 = data.a.a1(1:5000);
for i = 1:N
    s816_1 = ['data.s.f',num2str(i),' = mapminmax(data.s.f',num2str(i),''');'];
    s816_2 = ['data.s.Sp',num2str(i),' = mapminmax(data.s.Sp',num2str(i),''');'];
    s816_3 = ['data.s.f',num2str(i),' = data.s.f',num2str(i),''';'];
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
    s8 = ['d.f.ftk',num2str(i),' = d.f.fft',num2str(i),'(1:10,:);'];
    eval(s8);
    s9 = ['d.f.ftk',num2str(i),' = mapminmax(d.f.ftk',num2str(i),''');'];
    s10 = ['d.f.kur',num2str(i),' = kurtosis(d.f.ftk',num2str(i),');'];
    eval(s10);
    
    
%     eval(s816_1);
%     eval(s816_2);
%     eval(s816_3);

    
%     eval(s3);
    
%     eval(s5);
%     eval(s6);
    
    
%     eval(s9);
    
    
end
temp_l = data.l;
clear data
ft = [];
at = [];
t = [1/(rfs*WT):1/(rfs*WT):1];
Hapor = 0.7;
% Hapor2 = 0.5;
HaporH = 0.85;
HaSp = 0.98;
apor = 0.3;
flowth = [0,9,15];
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
    s911 = ['hathre = Hapor*max(abs(d.f',num2str(i),'));'];
    s912 = ['athre = apor*max(abs(d.f',num2str(i),'));'];
    s913 = ['hathreH = HaporH*max(abs(d.f',num2str(i),'));'];
    eval(s911);
    eval(s912);
    eval(s913);
%     tempHa低通气次数，tempL是完整呼吸次数
    tempA = zeros(1,length(temp1));
    tempHa = zeros(1,length(temp1));
    tempHaH = zeros(1,length(temp1));
    for count = 1:length(temp1)
        tempL(count) = length(temp1{count});
        temp4(count) = length(temp1{count});
        for tempcount = 1:tempL(count)
            if abs(temp2(tempcount,count)) < hathre(count) && hathre(count)<5.5
                tempHa(count) = tempHa(count)+1;
                if abs(temp2(tempcount,count)) < athre(count)
                    tempA(count) = tempA(count)+1;                 
                end
            elseif abs(temp2(tempcount,count)) < 7 && hathre(count)>= 5.5
                tempHa(count) = tempHa(count)+1;
                if abs(temp2(tempcount,count)) < athre(count)
                    tempA(count) = tempA(count)+1;
                end
            elseif abs(temp2(tempcount,count)) > hathreH(count)
                tempHaH(count) = tempHaH(count)+1;
            end
        end
    end
    
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
    % 低通气次数，可以0.8219，与特征3类似，应该可以用特征3代替，
    s977 = ['f.f',num2str(i),'(4,:) = tempHa;'];
    eval(s977);
    % 血氧低通气次数，可以0.8453，比较均衡，与特征1比较类似，可以用1号特征代替，真阳率没有达到90，（10，60）
    s978 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',max(d.Sp',num2str(i),')*HaSp);'];
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
    % 高于峰值流量百分之九十的比例，对阴性样本比较敏感，应该可以用1号特征代替，AUC0.7773，（50，98）,(60,95)，有一部分重叠，但是不多
    s983 = ['f.f',num2str(i),'(7,:) = tempHaH./tempL;'];
    eval(s983);
    % 频率谱峰度，不行，AUC0.70，对哪一类都不敏感
    s984 = ['f.f',num2str(i),'(8,:) = d.f.kur',num2str(i),';'];
    eval(s984);
    % 呼吸停滞次数,不太行，但是是不是可以用来确定Apnea？，不行，对哪一类都不敏感，看起来还可以呀，
    s911 = ['f.f',num2str(i),'(9,:) = tempA./tempL;'];
    eval(s911);
    % 血氧低于91的时长
    s9191 = ['f.f',num2str(i),'(10,:) = Findlow(d.Sp',num2str(i),',91);'];
    % 血氧低于92的时长，会有区别，但是重叠的部分同样会很多
    s9192 = ['f.f',num2str(i),'(11,:) = Findlow(d.Sp',num2str(i),',92);'];
    eval(s9191);
    eval(s9192);
    % 低于峰值流量70%的计数效果与4类似
%     s982 = ['f.f',num2str(i),'(7,:) = Findlow(d.f',num2str(i),',hathre);'];
    % 平均通气量效果不好
    s9194 = ['f.f',num2str(i),'(12,:) = temp3./tempL;'];
    eval(s9194);
    % 低频成分
    s9193 = ['f.f',num2str(i),'(13,:) = sum(d.f.fft',num2str(i),'(1:4,:))./sum(d.f.fft',num2str(i),');'];
    eval(s9193);
    % 主频成分占总能量比重，美神卵用,重叠的太多了
    s9194 = ['f.f',num2str(i),'(14,:) = max(d.f.fft',num2str(i),')./sum(d.f.fft',num2str(i),');'];
    eval(s9194);
    % 血氧变化斜率绝对值,重叠的太多，会有区别，但是重叠的很多
    s9195 = ['f.f',num2str(i),'(15,:) = abs(f.f',num2str(i),'(6,:));'];
    eval(s9195);
%     s9197 = ['var5 = diff(d.f.fft',num2str(i),');'];
%     eval(s9197);
%     s9198 = ['var6 = var5(1:11,:);'];
%     eval(s9198);
    % 主频成分在低频部分占比，区别度不高
    s9196 = ['f.f',num2str(i),'(16,:) = max(d.f.fft',num2str(i),'(1:10,:))./sum(d.f.fft',num2str(i),'(1:10,:));'];
    eval(s9196);
    % 通气量相对变化量
    s9197 = ['f.f',num2str(i),'(17,:) = [0,diff(temp3)];'];
    eval(s9197);
%     呼吸流量分布
    s9198 = ['f.f',num2str(i),'(18:20,:) = hist(abs(temp2),flowth);'];
    eval(s9198);
%     18：0-4.5，19：4.5-12，20：12-：
    s9199 = ['f.f',num2str(i),'(18,:) = f.f',num2str(i),'(18,:) - sum(temp2 == 0);'];
    eval(s9199);
    % 呼吸流量分布比例，23没区别，22阴性样本分布会更高一些，但是重叠的部分太多了，21阳性样本分布的会更高一些，但是同样重叠很大
    s9120 = ['f.f',num2str(i),'(21:23,:) = f.f',num2str(i),'(18:20,:)./repmat(sum(temp2~=0),[3,1]);'];
    eval(s9120);
    % 呼吸处于停滞的时间,不能捕捉到该特征，会有一定的区别，阳性样本总体分布更大一些，但是重叠的部分太多了
    s9121 = ['f.f',num2str(i),'(24,:) = Findlow(abs(d.f',num2str(i),'),4);'];
    eval(s9121);
    s9122 = ['temp = d.f.ftk',num2str(i),';'];
    eval(s9122);
    % 频率谱的峰数，箱线图几乎是一模一样，没有什么区别
    s9193 = ['f.f',num2str(i),'(25,:) = Findpeak(temp);'];
    eval(s9193);
    % 血氧片段的总体走势，有一定的区别，但是不大，硬性样本会更分布在0以下的地方，阴性样本会分布在0的周围，但是会有很大的重叠
    s9194 = ['f.f',num2str(i),'(26,:) = 100*(d.Sp',num2str(i),'(end,:)-d.Sp',num2str(i),'(1,:))/WL;'];
    eval(s9194);
    % 呼吸频率,无法分辨出来，箱线图太接近了
    s9195 = ['f.f',num2str(i),'(27,:) = tempL/WT;'];
    eval(s9195);
    s978 = ['f.f',num2str(i),'(28,:) = Findlow(d.Sp',num2str(i),',max(d.Sp',num2str(i),')-1);'];
    eval(s978);
    s1008 = ['temp = max(d.Sp',num2str(i),');'];
    eval(s1008);
    s1009 = ['temp = [90,temp(1:end-1)];'];
    eval(s1009);
    s978 = ['f.f',num2str(i),'(29,:) = Findlow(d.Sp',num2str(i),',temp*HaSp);'];
    eval(s978);
    s978 = ['f.f',num2str(i),'(30,:) = Findlow(d.Sp',num2str(i),',temp-1);'];
    eval(s978);
    s1009 = ['temp = f.f',num2str(i),'(26,:);'];
    eval(s1009);
    for k = 1:length(temp)
        if temp(k) > 0
            s1009 = ['f.f',num2str(i),'(29,k) = 0'];
            eval(s1009);
        end
    end
    
%     ind = [1,3,5,21,22,23,26];
%     ind = [3,7,29];
%     s9195 = ['f.f',num2str(i),' = f.f',num2str(i),'(ind,:);'];
%     eval(s9195);
%     s9194 = ['f.f',num2str(i),'(14,:) = 
%     s978 = ['f.f',num2str(i),'(5,:) = tempL;'];
    
    
%     eval(s972);
%     eval(s973);
%     eval(s974);
%     eval(s975);
%     eval(s976);
%     eval(s977);
%     eval(s978);
%     eval(s979);
%     eval(s980);
%     eval(s981);
%     eval(s983);
%     eval(s984);
%     eval(s982);
%     eval(s978);
%     eval(s979);
%     clear temp1 temp2 temp3 temp4 tempL hathre tempHa tempHaH;
    clear temp1 temp2 temp3 temp4 tempL tempHa tempHaH;
    
    s991 = ['tempind = find(an.a',num2str(i),'==2);'];
    s992 = ['an.a',num2str(i),'(tempind) = [];'];
    s993 = ['f.f',num2str(i),'(:,tempind) = [];'];
    s994 = ['d.f',num2str(i),'(:,tempind) = [];'];
    s995 = ['d.Sp',num2str(i),'(:,tempind) = [];'];
    s996 = ['d.f.fft',num2str(i),'(:,tempind) = [];'];
    
    eval(s991);
    eval(s992);
    eval(s993);
    eval(s994);
    eval(s995);
    eval(s996);
    clear tempind;
end
% for i = 1:N
% % % 9-7注，特征没有代表性，故注掉
% %     s1 = ['f.f',num2str(i),'(1,:) = d.f.kur',num2str(i),';'];
% %     s2 = ['f.f',num2str(i),'(2,:) = min(d.Sp',num2str(i),');'];
% 
% %     s5 = ['f.f',num2str(i),'(5,a) = ApEn(2,0.2*d.Sp.d',num2str(i),'(a),d.Sp',num2str(i),'(:,a),0);'];
% %     s6 = ['f.f',num2str(i),'(3,a) = ApEn(2,0.2*d.f.d',num2str(i),'(a),d.f',num2str(i),'(:,a),0);'];
%     
%     s203 = ['f.f',num2str(i),' = zeros(8,l(i));'];
% %     血氧方差
%     s106 = ['f.f',num2str(i),'(1,:) = std(d.Sp',num2str(i),');'];
% 
%     s103 = ['mu',num2str(i),'(a,:) = polyfit(t'',d.Sp',num2str(i),'(:,a),1);'];
% %     血氧直线斜率
%     s104 = ['f.f',num2str(i),'(2,:) = abs(mu',num2str(i),'(:,1));'];
% %     血氧直线截距
%     s105 = ['f.f',num2str(i),'(3,:) = mu',num2str(i),'(:,2);'];
% %     低于93的时间
%     s8 = ['f.f',num2str(i),'(4,:) = Findlow(d.Sp',num2str(i),',93);'];
% %     s9 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',91);'];
% %     低于平均值的时间
%     s10 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',mean(d.Sp',num2str(i),'));'];
%     
% %     s3 = ['f.f',num2str(i),'(7,:) = (max(d.Sp',num2str(i),')-min(d.Sp',num2str(i),'))./max(d.Sp',num2str(i),');'];
% %     最小值与平均值比例
%     s4 = ['f.f',num2str(i),'(6,:) = min(d.Sp',num2str(i),')./mean(d.Sp',num2str(i),');'];
% %     最大能量占比
%     s7 = ['f.f',num2str(i),'(7,:) = 2*max(d.f.fft',num2str(i),')./sum(d.f.fft',num2str(i),');'];
% %     能量频带方差
%     s204 = ['f.f',num2str(i),'(8,:) = std(d.f.fft',num2str(i),'(1:IN,:));'];
% %     低于整体均值的时间
%     s817_1 = ['f.f',num2str(i),'(9,:) = Findlow(d.Sp',num2str(i),',mean(mean(d.Sp',num2str(i),')));'];
% %     s817_2 = ['temp817_1 = xcorr(d.f',num2str(i),');'];
% %     s817_3 = ['f.f',num2str(i),'(10,:) = temp817_1(length(d.Sp',num2str(i),'(:,1)),1:length(d.Sp',num2str(i),'(1,:)));'];
% %     通气量
%     s817_4 = ['f.f',num2str(i),'(10,:) = sum(abs(d.f',num2str(i),'));'];
% %     通气量差值
%     s817_5 = ['f.f',num2str(i),'(11,:) = [0,diff(sum(abs(d.f',num2str(i),')))];'];
% %     流量最大值
%     s817_6 = ['f.f',num2str(i),'(12,:) = max(d.f',num2str(i),');'];
% %     流量最小值
%     s817_7 = ['f.f',num2str(i),'(13,:) = min(d.f',num2str(i),');'];
% %     流量极差
%     s817_8 = ['f.f',num2str(i),'(14,:) = max(d.f',num2str(i),') - min(d.f',num2str(i),')'];
% %     流量极差之比
%     s817_9 = ['f.f',num2str(i),'(15,:) = [1,f.f',num2str(i),'(14,2:end)./f.f',num2str(i),'(14,1:end-1)];'];
% %     通气量之比
%     s817_10 = ['f.f',num2str(i),'(16,:) = [1,f.f',num2str(i),'(10,2:end)./f.f',num2str(i),'(10,1:end-1)];'];
% %     流量最大值之比
%     s817_11 = ['f.f',num2str(i),'(17,:) = [1,f.f',num2str(i),'(12,2:end)./f.f',num2str(i),'(12,1:end-1)];'];
% %     流量最小值之比
%     s817_12 = ['f.f',num2str(i),'(18,:) = [1,f.f',num2str(i),'(13,2:end)./f.f',num2str(i),'(13,1:end-1)];'];
%     s201 = ['temp = TFcal(d.f',num2str(i),',WT,FT,rfs);'];
%     s205 = ['temp2 = TFcal(d.Sp',num2str(i),',WT,FT,rfs);'];
%     s202 = ['f.f',num2str(i),' = [f.f',num2str(i),';temp];'];
%     s206 = ['f.f',num2str(i),' = [f.f',num2str(i),';temp2];'];
% %     s101 = ['f.f',num2str(i),'(10,:) = sum(abs(d.f',num2str(i),'(1:fix(data.T*rfs/3),:)))-sum(abs(d.f',num2str(i),'(fix(data.T*rfs/3)+1:fix(data.T*rfs*2/3),:)));'];
% %     s102 = ['f.f',num2str(i),'(11,:) = sum(abs(d.f',num2str(i),'(fix(data.T*rfs/3)+1:fix(data.T*rfs*2/3),:)))-sum(abs(d.f',num2str(i),'(fix(data.T*2*rfs)/3+1:end,:)));'];
% %     eval(s1);
% %     eval(s2);
%     eval(s203);
%     eval(s106);
%     for a = 1:l(i)
%         eval(s103);
%     end
%     eval(s104);
%     eval(s105);
%     eval(s8);
% %     eval(s9);
%     eval(s10); 
% %     eval(s3);
%     eval(s4);
%     eval(s7);
%     eval(s204);
%     eval(s817_1);
% %     eval(s817_2);
% %     eval(s817_3);
%     eval(s817_4);
%     eval(s817_5);
%     eval(s817_6);
%     eval(s817_7);
%     eval(s817_8);
%     eval(s817_9);
%     eval(s817_10);
%     eval(s817_11);
%     eval(s817_12);
%     
% %     eval(s201);
% %     eval(s205);
% %     eval(s202);
% %     eval(s206);
% %     eval(s101);
% %     eval(s102);
% 
% 
% %     s2 = ['ft = [ft,f.f',num2str(i),'];'];
% %     s3 = ['at = [at;an.a',num2str(i),'];'];
% %     eval(s2);
% %     eval(s3);
% %     删除mu，减小内存需要
%     s961 = ['clear mu',num2str(i),';'];
%     eval(s961);
%     
% end
% toc;
% headerlines = input('Please add some annotation to this feature file:');
% clear d;

name = input('Please input the feature file name you want to save:');
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'',''f'',''an'',''ft'',''at'',''WT'',''ST'',''temp_l'');'];
eval(s13);