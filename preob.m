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
ind = input('Please input the index of the subject you want to ob:');
filename = ['E:\�ĵ�\MATLAB����\ucd-process\UCD Sleep Apnea Database\����\sub',num2str(ind),'ob.mat'];
% ԭʼ�ź�����
data = importdata(filename);
head = data.com;
data = data.ob;
% ԭʼ�˹���ע����
an = importdata('E:\�ĵ�\MATLAB����\ucd-process\UCD Sleep Apnea Database\����\onlyanno.mat');
s1114 = ['an = an.a',num2str(ind),';'];
eval(s1114);
% ԭʼ������
fs = 128;
% ���ݿⱻ�Ը���
N = 25;
RN = 23;
i = ind;
%   Here T is the length of the period time.
T = input('Please input the data length:');
WT = input('Please input the window length:');
Tao = input('Please input the SpO2 delay(0-60):');
spth = input('Please input the SpO2 threshold:');
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
% ����������
% Ѫ��������
% data = data(1:step:end,:);
s1114 = ['tempa = an;'];
eval(s1114);


% l��i��1���źų���
s1 = ['l(1) = length(data);'];
% �ź��ж��ٸ������Ĵ���
s2 = ['l(2) = floor(l(1)/(T*rfs));'];
% ʱ��ĸ���
s4 = ['l(3) = length(an);'];
% ��ȡ���źų���
s202 = ['l(4) = l(2)*rfs*T;'];
% �������ڵ�����Ŀ
s201 = ['l(5) = fix((l(4)/rfs-T)/WT)+1;'];
eval(s1);
eval(s2);
eval(s4);
eval(s202);
eval(s201);

% Ѱ����Ҫɾ�����źŶ�λ��
c = 1;
for a = 1:l(3)
%       Periodic breathing (PB)/ Cheynes-Stokes (CS)����־Ϊ1���ں���Ӧ��ɾ��
    s956 = ['ann.a(c,1) = an(a,1);'];
    s957 = ['ann.a(c,2) = an(a,1) + an(a,2);'];
    s958 = ['ann.a(c,3) = an(a,3);'];

    eval(s956);
    eval(s957);
    eval(s958);
    c = c+1;
end
%   �˹���ע���¼�������
s205 = ['l(6) = length(ann.a(:,1));'];
eval(s205);
s1011 = ['templ = length(data(1:step:end,1));'];
eval(s1011);
tempind = zeros(1,templ);
s1011 = ['tempsp = data(1:step:end,1);'];
eval(s1011);
%   ���Ϊ2��ʱ��ζ���ɾ��
%   Ѱ��Ѫ������50ˮƽ��ʱ���
s1028 = ['tempfl = data(1:step:end,2);'];
eval(s1028);
%     for k = 1:l(i,6)
%         s1011 = ['tempan = ann.a',num2str(i),';'];
%         eval(s1011);
%         if tempan(k,3) == 0
%             tempind(tempan(k,1)*rfs:tempan(k,2)*rfs) = 1;
%         elseif tempan(k,3) == 1
%             tempdel = [tempdel,tempan(k,1)*rfs:tempan(k,2)*rfs];
%         end
%     end
flowdel = Findflow(tempfl,120);
flowdel = reshape(flowdel,[],1);
splow = find(tempsp<spth);
[startp,endp] = Finddur(splow);
splow = durextern(splow,startp,endp,60,length(tempfl));
[startp,endp] = Finddur(splow);
inter = Findint(splow,startp,endp);
splow = Findmer(splow,inter,startp,endp,120*8);
%     splowlen = [splowlen;splow];
%     flowlen = [flowlen;flowdel];
%   ��ʼ������ʱ���
indstart = 1:600*rfs;
indend = (length(tempfl)-900*rfs):length(tempfl);
tempdel = [];
for k = 1:l(6)
    s1011 = ['tempan = ann.a;'];
    eval(s1011);
    if tempan(k,3) == 0
        tempind(tempan(k,1)*rfs:tempan(k,2)*rfs) = 1;
    elseif tempan(k,3) == 1
        tempdel = [tempdel,tempan(k,1)*rfs:tempan(k,2)*rfs];
    end
end
[startp,endp] = Finddur(tempdel);
inter = Findint(tempdel,startp,endp);
tempdel = Findmer(tempdel,inter,startp,endp,120*8);
%     splow = [];
%     flowdel = [];
%     tempdel = [];
inddel = union(indstart,indend);
inddel = union(splow,inddel);
%     inddel = tempdel;
inddel = union(inddel,tempdel);
inddel = union(inddel,flowdel);
[startp,endp] = Finddur(inddel);
inter = Findint(inddel,startp,endp);
inddel = Findmer(inddel,inter,startp,endp,120*8);
tempind(inddel) = 5;
%     tempind(splow) = 3;
%     tempind(indstart) = 5;
%     tempind(indend) = 5;



% ��ͨ�˲����˲�
% s1031 = ['data(:,2) = filter(c1,c2,data(:,2));'];
% eval(s1031);
% % ����ƽ���˲�
% s1030 = ['data(:,2) = smooth(data(:,2),8);'];
% eval(s1030);



%     s1105 = ['segT = floor(length(data.f',num2str(i),')/100)*100;'];
%     eval(s1105);
%     s1105 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:segT);'];
%     eval(s1105);
%     s1105 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:segT);'];
%     eval(s1105);
%     tempind = tempind(1:segT);
%     oob(3,i) = length(tempind);



% �����и�ڴ���
s9 = ['tempf = Findw(data(1:step:end,2),T,WT,rfs);'];
s10 = ['tempsp = Findw(data(1:step:end,1),T,WT,rfs);'];
eval(s9);
eval(s10);
tempecg = Findw(data(:,3),T,WT,fs);
tempsound = Findw(data(:,4),T,WT,fs);
tempribcage = Findw(data(:,5),T,WT,fs);
tempabdo = Findw(data(:,6),T,WT,fs);
tempbody = Findw(data(:,7),T,WT,fs);
s1011 = ['tempindw = Findw(tempind,T,WT,rfs);'];
eval(s1011);


% ��������
tempf = tempf(:,1:end-Tao);
tempsp = tempsp(:,Tao+1:end);
tempindw = tempindw(:,1:end-Tao);
tempecg = tempecg(:,1:end-Tao);
tempsound = tempsound(:,1:end-Tao);
tempribcage = tempribcage(:,1:end-Tao);
tempabdo = tempabdo(:,1:end-Tao);
tempbody = tempbody(:,1:end-Tao);


% ��ȡ��ͬ���ȵ����ݣ�����Tao�����Ĳ�ͬ���ݳ��ȵ�Ӱ��
segT = floor(length(tempf)/120)*120;
tempf = tempf(:,1:(segT-T));
tempsp = tempsp(:,1:(segT-T));
tempindw = tempindw(:,1:(segT-T));
tempecg = tempecg(:,1:(segT-T));
tempsound = tempsound(:,1:(segT-T));
tempribcage = tempribcage(:,1:(segT-T));
tempabdo = tempabdo(:,1:(segT-T));
tempbody = tempbody(:,1:(segT-T));
temptime = 1:length(tempf);


% ɾ����Ч����
[mdel1,ndel1] = find(tempindw == 5);
%     ndel = unique(ndel);
%     oob(2,i) = length(ndel);
%     [mdel2,ndel2] = find(tempindw == 3);
%     ndel2 = ndel2 - Tao;
%     ndel2 = ndel2(find(ndel2>0));
%     ndel = union(ndel1,ndel2);
ndel = ndel1;


tempf(:,ndel) = [];
tempsp(:,ndel) = [];
tempindw(:,ndel) = [];
temptime(ndel) = [];
tempecg(:,ndel) = [];
tempsound(:,ndel) = [];
tempribcage(:,ndel) = [];
tempabdo(:,ndel) = [];
tempbody(:,ndel) = [];

% ɾ��ȫʱ�������еĲ��ɿ�����
%     s1113 = ['data.f',num2str(i),'(inddel) = [];'];
%     eval(s1113);
%     s1113 = ['data.Sp',num2str(i),'(inddel) = [];'];
%     eval(s1113);


% �洢������������
tempanno = zeros(length(tempf),1);
tempindsum = sum(tempindw);
indapnea = find(tempindsum>=VT*rfs);
tempanno(indapnea) = 1;
s1011 = ['anno.a = tempanno;'];
eval(s1011);
s216 = ['ds.s.f',num2str(i),' = tempf;'];
eval(s216);
s217 = ['ds.s.Sp',num2str(i),' = tempsp;'];
eval(s217);
s216 = ['ds.s.ecg',num2str(i),' = tempecg;'];
eval(s216);
s217 = ['ds.s.sound',num2str(i),' = tempsound;'];
eval(s217);
s217 = ['ds.s.ribcage',num2str(i),' = tempribcage;'];
eval(s217);
s217 = ['ds.s.abdo',num2str(i),' = tempabdo;'];
eval(s217);
s217 = ['ds.s.body',num2str(i),' = tempbody;'];
eval(s217);
s218 = ['ds.a.a',num2str(i),' = anno.a;'];
eval(s218);
s1101 = ['ds.i.i',num2str(i),' = temptime;'];
eval(s1101);

% �ع�ԭʼ����
tf = reshape(tempf(:,1:T/WT:end),1,[]);
tsp = reshape(tempsp(:,1:T/WT:end),1,[]);
tecg = reshape(tempecg(:,1:T/WT:end),1,[]);
tsound = reshape(tempsound(:,1:T/WT:end),1,[]);
trib = reshape(tempribcage(:,1:T/WT:end),1,[]);
tabdo = reshape(tempabdo(:,1:T/WT:end),1,[]);
tbody = reshape(tempbody(:,1:T/WT:end),1,[]);

s214 = ['ds.t.f',num2str(i),' = tf;'];
%     s214 = ['ds.t.f',num2str(i),' = data.f',num2str(i),';'];
eval(s214);
s215 = ['ds.t.Sp',num2str(i),' = tsp;'];
eval(s215);
s215 = ['ds.t.ecg',num2str(i),' = tecg;'];
eval(s215);
s215 = ['ds.t.sound',num2str(i),' = tsound;'];
eval(s215);
s215 = ['ds.t.rib',num2str(i),' = trib;'];
eval(s215);
s215 = ['ds.t.abdo',num2str(i),' = tabdo;'];
eval(s215);
s215 = ['ds.t.body',num2str(i),' = tbody;'];
eval(s215);

clear tempf tempsp tempind templ tempanno tempindw tempindsum indstart tempdel inddel



clear an

clear dataseq








% temp_a = ds.a;
ds.l = l;
ds.T = T;
ds.WT = WT;
ds.tao = Tao;
ds.re = 0;

