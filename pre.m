% clc;
% clear;
% close all;
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

% ԭʼ�ź�����
data = importdata('E:\�ĵ�\MATLAB����\ucd-process\UCD Sleep Apnea Database\����\dataf&Sp.mat');
% ԭʼ�˹���ע����
an = importdata('E:\�ĵ�\MATLAB����\ucd-process\UCD Sleep Apnea Database\����\onlyanno.mat');

% ԭʼ������
fs = 128;
% ���ݿⱻ�Ը���
N = 25;
RN = 23;
%   Here T is the length of the period time.
% T = input('Please input the data length:');
% WT = input('Please input the window length:');
% Tao = input('Please input the SpO2 delay(0-60):');
% spth = input('Please input the SpO2 threshold:');
% Y = input('Please input whther to preprocess the flow:');
IP = WT/T;
M = 1/IP;
% segT = 
% �źŵ���ʵ������
rfs = 8;
% �źŽ������Ĳ���
step = fs/rfs;
% VT = WT;
% �����к��ж೤ʱ��ķ����¼���ȷ��Ϊ��������
VT = 5;
%ST��apnea��ʼ֮ǰ�Լ�֮����Ҫ�г���ʱ��
ST = 15;
splowlen = [];
flowlen = [];
%TaoѪ��֮������
% Tao = 20;
% Taofs = floor(Tao/rfs*fs);
% Ѫ��֮��ĵ�����Ҳ����������Ҫ���������ʱ��
Taofs = floor(Tao*rfs);
% �����ͨ�˲�������ֹƵ��Ϊ0.05
[c1,c2] = butter(3,0.05/rfs,'high');
for i = 1:N


    % ����������
    % Ѫ��������
    s301 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:step:end);'];
    s302 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:step:end);'];
    eval(s301);
    eval(s302);
    
    
    % l��i��1���źų���
    s1 = ['l(i,1) = length(data.f',num2str(i),');'];
    % �ź��ж��ٸ������Ĵ���
    s2 = ['l(i,2) = floor(l(i,1)/(T*rfs));'];
    % ʱ��ĸ���
    s4 = ['l(i,3) = length(an.a',num2str(i),');'];
    % ��ȡ���źų���
    s202 = ['l(i,4) = l(i,2)*rfs*T;'];
    % �������ڵ�����Ŀ
    s201 = ['l(i,5) = fix((l(i,4)/rfs-T)/WT)+1;'];
    eval(s1);
    eval(s2);
    eval(s4);
    eval(s202);
    eval(s201);
    
    % Ѱ����Ҫɾ�����źŶ�λ��
    c = 1;
    for a = 1:l(i,3)
%       Periodic breathing (PB)/ Cheynes-Stokes (CS)����־Ϊ1���ں���Ӧ��ɾ��
        s956 = ['ann.a',num2str(i),'(c,1) = an.a',num2str(i),'(a,1);'];
        s957 = ['ann.a',num2str(i),'(c,2) = an.a',num2str(i),'(a,1) + an.a',num2str(i),'(a,2);'];
        s958 = ['ann.a',num2str(i),'(c,3) = an.a',num2str(i),'(a,3);'];
        
        eval(s956);
        eval(s957);
        eval(s958);
        c = c+1;
    end
    %   �˹���ע���¼�������
    s205 = ['l(i,6) = length(ann.a',num2str(i),'(:,1));'];
    eval(s205);
    s1011 = ['templ = length(data.f',num2str(i),');'];
    eval(s1011);
    tempind = zeros(1,templ);
    s1011 = ['tempsp = data.Sp',num2str(i),';'];
    eval(s1011);
    %   ���Ϊ2��ʱ��ζ���ɾ��
    %   Ѱ��Ѫ������50ˮƽ��ʱ���
    s1028 = ['tempfl = data.f',num2str(i),';'];
    eval(s1028);
    flowdel = Findflow(tempfl,120);
    flowdel = reshape(flowdel,[],1);
    splow = find(tempsp<spth);
    [startp,endp] = Finddur(splow);
    inter = Findint(splow,startp,endp);
    splow = Findmer(splow,inter,startp,endp,120*8);
    splowlen = [splowlen;splow];
    flowlen = [flowlen;flowdel];
    %   ��ʼ������ʱ���
    indstart = 1:600*rfs;
    indend = (length(tempfl)-900*rfs):length(tempfl);
    tempdel = [];
    for k = 1:l(i,6)
        s1011 = ['tempan = ann.a',num2str(i),';'];
        eval(s1011);
        if tempan(k,3) == 0
            tempind(tempan(k,1)*rfs:tempan(k,2)*rfs) = 1;
        elseif tempan(k,3) == 1
            tempdel = [tempdel,tempan(k,1)*rfs:tempan(k,2)*rfs];
        end
    end
    [startp,endp] = Finddur(tempdel);
    inter = Findint(tempdel,startp,endp);
    tempdel = Findmer(tempdel,inter,startp,endp,60*8);
%     splow = [];
%     flowdel = [];
%     tempdel = [];
    inddel = union(indstart,indend);
    inddel = union(splow,inddel);
    inddel = union(inddel,tempdel);
    inddel = union(inddel,flowdel);
    [startp,endp] = Finddur(inddel);
    inter = Findint(inddel,startp,endp);
    inddel = Findmer(inddel,inter,startp,endp,120*8);
    
    tempind(inddel) = 5;
    
    % ��ͨ�˲����˲�
    s1031 = ['data.f',num2str(i),' = filter(c1,c2,data.f',num2str(i),');'];
    eval(s1031);
    % ����ƽ���˲�
    s1030 = ['data.f',num2str(i),' = smooth(data.f',num2str(i),',8);'];
    eval(s1030);
    
    
    
%     s1105 = ['segT = floor(length(data.f',num2str(i),')/100)*100;'];
%     eval(s1105);
%     s1105 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:segT);'];
%     eval(s1105);
%     s1105 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:segT);'];
%     eval(s1105);
%     tempind = tempind(1:segT);
%     oob(3,i) = length(tempind);
    
    
    
    % �����и�ڴ���
    s9 = ['tempf = Findw(data.f',num2str(i),',T,WT,rfs);'];
    s10 = ['tempsp = Findw(data.Sp',num2str(i),',T,WT,rfs);'];
    eval(s9);
    eval(s10);
    s1011 = ['tempindw = Findw(tempind,T,WT,rfs);'];
    eval(s1011);
    
    
    % ��������
    tempf = tempf(:,1:end-Tao);
    tempsp = tempsp(:,Tao+1:end);
    tempindw = tempindw(:,1:end-Tao);
    
    
    % ��ȡ��ͬ���ȵ����ݣ�����Tao�����Ĳ�ͬ���ݳ��ȵ�Ӱ��
    segT = floor(length(tempf)/120)*120;
    tempf = tempf(:,1:(segT-T));
    tempsp = tempsp(:,1:(segT-T));
    tempindw = tempindw(:,1:(segT-T));
    temptime = 1:length(tempf);
    oob(1,i) = length(tempf);
    
    % ɾ����Ч����
    [mdel,ndel] = find(tempindw == 5);
    ndel = unique(ndel);
    oob(2,i) = length(ndel);
    
    tempob{i} = ndel;
    tempf(:,ndel) = [];
    tempsp(:,ndel) = [];
    tempindw(:,ndel) = [];
    temptime(ndel) = [];
    % �洢������������
    tempanno = zeros(length(tempf),1);
    tempindsum = sum(tempindw);
    indapnea = find(tempindsum>=VT*rfs);
    tempanno(indapnea) = 1;
    s1011 = ['anno.a',num2str(i),' = tempanno;'];
    eval(s1011);
    s216 = ['ds.s.f',num2str(i),' = tempf;'];
    eval(s216);
    s217 = ['ds.s.Sp',num2str(i),' = tempsp;'];
    eval(s217);
    s218 = ['ds.a.a',num2str(i),' = anno.a',num2str(i),';'];
    eval(s218);
    s1101 = ['ds.i.i',num2str(i),' = temptime;'];
    eval(s1101);
    
    % �ع�ԭʼ����
    tf = reshape(tempf(:,1:T/WT:end),1,[]);
    tsp = reshape(tempsp(:,1:T/WT:end),1,[]);
    s214 = ['ds.t.f',num2str(i),' = tf;'];
    eval(s214);
    s215 = ['ds.t.Sp',num2str(i),' = tsp;'];
    eval(s215);

    
    clear tempf tempsp tempind templ tempanno tempindw tempindsum indstart tempdel inddel
    
    
    
    
    
    

    
    

end
index = zeros(2,max(l(:,5)));
for i = 1:max(l(:,5))
    index(1,i) = (i-1)*WT;
    index(2,i) = (i-1+M)*WT;
end

clear an

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
    s1011 = ['if i~=3 && i~=9 datar.isp',num2str(c),' = ds.i.i',num2str(i),'; end'];
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
    s1101 = ['ds.i.i',num2str(i),' = datar.isp',num2str(i),';'];
    eval(s1101);
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
s13 = ['save(''E:\�ĵ�\MATLAB����\ucd-process\UCD Sleep Apnea Database\����\dataw',num2str(T),'&',num2str(WT),'.mat'',''ds'');'];
eval(s13);
