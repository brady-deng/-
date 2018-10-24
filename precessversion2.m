clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for constructing the annotations for this dataset.
%   The variable T in this script is the length of time for deriving.
%   In 1-23 I add an auto saving code to make the script more effective.
%   Last editted by Brady Deng in 1-23
%   Last editted by Brady Deng in 2-3
%   Last editted by Brady Deng in 3-2
%   The number created by this script is changed from int to double in 3-2
%   I use down-sampling to low down the computation complexity.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 原始信号数据
data = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\dataf&Sp.mat');
% 原始人工标注数据
an = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\onlyanno.mat');

% 原始采样率
fs = 128;
% 数据库被试个数
N = 25;
RN = 23;
%   Here T is the length of the period time.
T = input('Please input the data length:');
WT = input('Please input the window length:');
Tao = input('Please input the SpO2 delay(0-60):');
IP = WT/T;
M = 1/IP;
% segT = 
% 信号的真实采样率
rfs = 8;
% 信号降采样的步长
step = fs/rfs;
% VT = WT;
% 窗口中含有多长时间的发病事件才确定为阳性样本
VT = 5;
%ST是apnea开始之前以及之后想要切除的时长
ST = 15;
%Tao血氧之后秒数
% Tao = 20;
% Taofs = floor(Tao/rfs*fs);
% 血氧之后的点数，也就是我们需要主动对齐的时间
Taofs = floor(Tao*fs);
for i = 1:N
    % 主动对齐
    s9191 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:end-Taofs);'];
    s9192 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(Taofs+1:end);'];
    eval(s9191);
    eval(s9192);
    % 确保不同的窗口的数据总长度是一致的
    s1011 = ['segT = floor(length(data.f',num2str(i),')/(fs*20))*20;'];
    eval(s1011);
    s1011 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:segT*fs);'];
    eval(s1011);
    s1012 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:segT*fs);'];
    eval(s1012);
    % l（i，1）信号长度
    s1 = ['l(i,1) = length(data.f',num2str(i),');'];
    % 信号有多少个完整的窗口
    s2 = ['l(i,2) = floor(l(i,1)/(T*fs));'];
    
    s3 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:l(i,2)*fs*T);'];
    s10 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:l(i,2)*fs*T);'];
    s11 = ['data.So',num2str(i),' = data.So',num2str(i),'(1:l(i,2)*fs*T);'];
    s12 = ['data.Pul',num2str(i),' = data.Pul',num2str(i),'(1:l(i,2)*fs*T);'];
    % 时间的个数
    s4 = ['l(i,3) = length(an.a',num2str(i),');'];
    % 截取的信号长度
    s202 = ['l(i,4) = l(i,2)*fs*T;'];
    % 滑动窗口的总数目
    s201 = ['l(i,5) = fix((l(i,4)/fs-T)/WT)+1;'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s10);
%     eval(s11);
%     eval(s12);
    eval(s4);
    eval(s202);
    eval(s201);
    % 流量降采样
    % 血氧降采样
    s301 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:step:end);'];
    s302 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:step:end);'];
    
    eval(s301);
    eval(s302);
    
    c = 1;
    for a = 1:l(i,3)
%         s9 = ['if an.a',num2str(i),'(c,3) ~= 1 ann.a',num2str(i),'(c,1) = an.a',num2str(i),'(a,1);end'];
%         s4 = ['if an.a',num2str(i),'(c,3) ~= 1 ann.a',num2str(i),'(c,2) = an.a',num2str(i),'(a,1) + an.a',num2str(i),'(a,2);c = c + 1;end'];
%         s951 = ['ann.a',num2str(i),'(c,3) = an.a',num2str(i),'(a,3);'];
%       Periodic breathing (PB)/ Cheynes-Stokes (CS)，标志为1，在后续应该删除
        s952 = ['if an.a',num2str(i),'(c,3) == 1 temp_start = rfs*an.a',num2str(i),'(c,1);end'];
        s953 = ['if an.a',num2str(i),'(c,3) == 1 temp_end = rfs*an.a',num2str(i),'(c,2);end'];
        s954 = ['data.f',num2str(i),' = data.f',num2str(i),'(temp_start:temp_end) = [];'];
        s955 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(temp_start:temp_end) = [];'];
        s956 = ['ann.a',num2str(i),'(c,1) = an.a',num2str(i),'(a,1);'];
        s957 = ['ann.a',num2str(i),'(c,2) = an.a',num2str(i),'(a,1) + an.a',num2str(i),'(a,2);'];
        s958 = ['ann.a',num2str(i),'(c,3) = an.a',num2str(i),'(a,3);'];
        
        eval(s956);
        eval(s957);
        eval(s958);
        c = c+1;
        

%         eval(s9);
%         eval(s4);
%         eval(s951);
%         eval(s952);
%         eval(s953);
%         eval(s954);
%         eval(s955);

        
    end
    %   人工标注的事件的总数
    s205 = ['l(i,6) = length(ann.a',num2str(i),'(:,1));'];
    eval(s205);
    s1011 = ['templ = length(data.f',num2str(i),');'];
    eval(s1011);
    tempind = zeros(1,templ);
    s1011 = ['tempsp = data.Sp',num2str(i),';'];
    eval(s1011);
    %   标记为2的时间段都该删除
    %   寻找血氧低于50水平的时间段
    splow = find(tempsp<80);
    %   开始测量的时间段
    indstart = [1:600*rfs];
    tempind(splow) = 2;
    tempind(indstart) = 2;
    for k = 1:l(i,6)
        s1011 = ['tempan = ann.a',num2str(i),';'];
        eval(s1011);
        if tempan(k,3) == 0
            tempind(tempan(k,1)*rfs:tempan(k,2)*rfs) = 1;
        elseif tempan(k,3) == 1
            tempind(tempan(k,1)*rfs:tempan(k,2)*rfs) = 2;
        end
    end
    inddel = find(tempind == 2);
    s1011 = ['data.f',num2str(i),'(inddel) = [];'];
    eval(s1011);
    s1011 = ['data.Sp',num2str(i),'(inddel) = [];'];
    eval(s1011);
    tempind(inddel) = [];
    
    ind{i} = tempind;
        



    % 将数据划窗
    s9 = ['tempf = Findw(data.f',num2str(i),',T,WT,rfs);'];
    s10 = ['tempsp = Findw(data.Sp',num2str(i),',T,WT,rfs);'];
    s11 = ['dataseq.So',num2str(i),' = Findw(data.So',num2str(i),',T,WT,rfs);'];
    s12 = ['dataseq.Pul',num2str(i),' = Findw(data.Pul',num2str(i),',T,WT,rfs);'];
    
    eval(s9);
    eval(s10);
    s1011 = ['tempindw = Findw(tempind,T,WT,rfs);'];
    eval(s1011);
    tempanno = zeros(length(tempf),1);
    tempindsum = sum(tempindw);
    indapnea = find(tempindsum>=VT*rfs);
    tempanno(indapnea) = 1;
%     for k = 1:length(tempanno)
%         if sum(tempindw)>=VT*rfs
%             tempanno(k) = 1;
%         end
%     end
    s1011 = ['anno.a',num2str(i),' = tempanno;'];
    eval(s1011);
%     eval(s11);
%     eval(s12);
    s214 = ['ds.t.f',num2str(i),' = data.f',num2str(i),';'];
    eval(s214);
    s215 = ['ds.t.Sp',num2str(i),' = data.Sp',num2str(i),';'];
    eval(s215);
    s216 = ['ds.s.f',num2str(i),' = tempf;'];
    eval(s216);
    s217 = ['ds.s.Sp',num2str(i),' = tempsp;'];
    eval(s217);
    s218 = ['ds.a.a',num2str(i),' = anno.a',num2str(i),';'];
    eval(s218);
    
    clear tempf tempsp tempind templ tempanno tempindw tempindsum
    
    
    
    
    
    

    
    

end
index = zeros(2,max(l(:,5)));
for i = 1:max(l(:,5))
    index(1,i) = (i-1)*WT;
    index(2,i) = (i-1+M)*WT;
end

% for i = 1:N
%     s210 = ['anno.a',num2str(i),' = zeros(l(i,5),1);'];
%     eval(s210);
%     for a = 1:l(i,6)
% %         s203 = ['ann.a',num2str(i),'(a,3) = rem(ann.a',num2str(i),'(a,1),WT);'];
% %         s204 = ['ann.a',num2str(i),'(a,4) = rem(ann.a',num2str(i),'(a,2),WT);'];
% %         s206 = ['ann.a',num2str(i),'(a,5) = fix(ann.a',num2str(i),'(a,1)/WT);'];
% %         s207 = ['ann.a',num2str(i),'(a,6) = fix(ann.a',num2str(i),'(a,2)/WT);'];
% %         
% %         eval(s203);
% %         eval(s204);
% %         eval(s206);
% %         eval(s207);
% %         部分包含apnea的片段标记为2
% %         s991 = ['anno.a',num2str(i),'(ceil((ann.a',num2str(i),'(a,1)-T-ST)/WT)+1:floor((ann.a',num2str(i),'(a,1)+VT-T)/WT)) = 2;'];
% %         eval(s991);
% %         s992 = ['anno.a',num2str(i),'((ceil((ann.a',num2str(i),'(a,2)-VT)/WT)+1):floor(((ann.a',num2str(i),'(a,2)+ST)/WT)+1)) = 2;'];
% %         eval(s992);
% %       apnea之前与之后不切割版本
% %         s991 = ['anno.a',num2str(i),'(ceil((ann.a',num2str(i),'(a,1)-T)/WT)+1:floor((ann.a',num2str(i),'(a,2))/WT)) = 2;'];
% %         eval(s991);
%         
%         
% %         完全包含apnea的片段标记为1
%         s211 = ['anno.a',num2str(i),'(ceil((ann.a',num2str(i),'(a,1)+VT-T)/WT)+1:floor((ann.a',num2str(i),'(a,2)-VT)/WT)+1) = 1;'];
%         eval(s211);
% 
% %         包含呼吸停滞的标记为3，最后把他去掉
% %           s211_94 = ['if ann.a',num2str(i),'(a,3) == 0 anno.a',num2str(i),'(ceil((ann.a',num2str(i),'(a,1))/WT)+1:floor((ann.a',num2str(i),'(a,2)-VT)/WT)+1) = 1;end'];
%         s211_95 = ['if ann.a',num2str(i),'(a,3) == 1 anno.a',num2str(i),'(ceil((ann.a',num2str(i),'(a,1)-T)/WT)+1:floor((ann.a',num2str(i),'(a,2))/WT)+1) = 3;end'];
% %           eval(s211_94);
%         eval(s211_95);
% %         s212 = ['if index(2,ann.a',num2str(i),'(a,5)+1)-ann.a',num2str(i),'(a,1)<VT anno.a',num2str(i),'(ann.a',num2str(i),'(a,5)+1)=0;end'];
% %         s213 = ['if ann.a',num2str(i),'(a,2)-index(1,ann.a',num2str(i),'(a,6)+1)<VT anno.a',num2str(i),'(ann.a',num2str(i),'(a,6)+1)=0;end'];
% %         eval(s212);
% %         eval(s213);
%         
%          
%     end
% end
clear an
% for i = 1:N
%     s214 = ['ds.t.f',num2str(i),' = data.f',num2str(i),';'];
%     s215 = ['ds.t.Sp',num2str(i),' = data.Sp',num2str(i),';'];
%     s216 = ['ds.s.f',num2str(i),' = tempf;'];
%     s217 = ['ds.s.Sp',num2str(i),' = tempsp;'];
%     s218 = ['ds.a.a',num2str(i),' = anno.a',num2str(i),';'];
%     eval(s214);
%     eval(s215);
%     eval(s216);
%     eval(s217);
%     eval(s218);
% end
clear dataseq
c = 1;
for i = 1:N
    
    s2 = ['if i~=3 && i~=9 datar.an.a',num2str(c),' = ds.a.a',num2str(i),'; end'];
    eval(s2);
    s1 = ['if i~=3 && i~=9 datar.f',num2str(c),' = ds.s.f',num2str(i),'; end'];
    eval(s1);
    s5 = ['if i~=3 && i~=9 datar.Sp',num2str(c),' = ds.s.Sp',num2str(i),'; end'];
    eval(s5);
    s1011 = ['if i~=3 && i~=9 datar.tf',num2str(c),' = ds.t.f',num2str(i),'; end'];
    eval(s1011);
    s1011 = ['if i~=3 && i~=9 datar.tsp',num2str(c),' = ds.t.Sp',num2str(i),'; end'];
    eval(s1011);
    if i~=3 && i ~= 9
        c = c+1;
    end
    
    
end
clear ds
for i = 1:RN
    s214 = ['ds.t.f',num2str(i),' = datar.tf',num2str(i),';'];
    s215 = ['ds.t.Sp',num2str(i),' = datar.tsp',num2str(i),';'];
    s216 = ['ds.s.f',num2str(i),' = datar.f',num2str(i),';'];
    s217 = ['ds.s.Sp',num2str(i),' = datar.Sp',num2str(i),';'];
    s218 = ['ds.a.a',num2str(i),' = datar.an.a',num2str(i),';'];
    eval(s214);
    eval(s215);
    eval(s216);
    eval(s217);
    eval(s218);
end
clear datar

for i = 1:RN

    
    s1 = ['temp_a.a',num2str(i),' = zeros(floor(length(ds.t.f',num2str(i),')/rfs),1);'];
    s2 = ['l(i,7) = floor(length(ds.t.f',num2str(i),')/rfs),1;'];


    eval(s1);
    eval(s2);
    for count = 1:l(i,6)
        s2 = ['temp_a.a',num2str(i),'(ann.a',num2str(i),'(count,1):ann.a',num2str(i),'(count,2)) = (ann.a',num2str(i),'(count,3)+1);'];
        eval(s2);
    end

end


% temp_a = ds.a;
ds.l = l;
ds.T = T;
ds.WT = WT;
ds.tao = Tao;
ds.re = 0;
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\dataw',num2str(T),'&',num2str(WT),'.mat'',''ds'');'];
eval(s13);
