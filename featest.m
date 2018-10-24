clc;
clear;
close all;

T = input('Please input the data  you want to test:');

s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',T,'.mat'');'];
eval(s1);
tic;
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
testNum = 10000;
data.s.f1 = data.s.f1(:,1:testNum);
data.s.Sp1 = data.s.Sp1(:,1:testNum);
data.a.a1 = data.a.a1(1:testNum);
an.a1 = an.a1(1:testNum);
for i = 1:N
    s1 = ['d.f',num2str(i),' = data.s.f',num2str(i),';'];
    s2 = ['d.Sp',num2str(i),' = data.s.Sp',num2str(i),';'];
    s3 = ['d.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
    s4 = ['l(i) = length(d.f',num2str(i),'(1,:));'];
    s5 = ['d.Sp.d',num2str(i),' = std(d.Sp',num2str(i),');'];
    s6 = ['d.f.d',num2str(i),' = std(d.f',num2str(i),');'];
    s7 = ['d.f.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
    s8 = ['d.f.ftk',num2str(i),' = d.f.fft',num2str(i),'(5:15,:);'];
    s9 = ['d.f.ftk',num2str(i),' = mapminmax(d.f.ftk',num2str(i),''');'];
    s10 = ['d.f.kur',num2str(i),' = kurtosis(d.f.ftk',num2str(i),''');'];
    
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
%     eval(s5);
%     eval(s6);
    eval(s7);
%     eval(s8);
%     eval(s9);
%     eval(s10);
    
end
ft = [];
at = [];
t = [1/(rfs*data.T):1/(rfs*data.T):1];
for i = 1:N
%     s1 = ['f.f',num2str(i),'(1,:) = d.f.kur',num2str(i),';'];
%     s2 = ['f.f',num2str(i),'(2,:) = min(d.Sp',num2str(i),');'];

%     s5 = ['f.f',num2str(i),'(5,a) = ApEn(2,0.2*d.Sp.d',num2str(i),'(a),d.Sp',num2str(i),'(:,a),0);'];
%     s6 = ['f.f',num2str(i),'(3,a) = ApEn(2,0.2*d.f.d',num2str(i),'(a),d.f',num2str(i),'(:,a),0);'];
    
    s203 = ['f.f',num2str(i),' = zeros(8,l(i));'];
    s106 = ['f.f',num2str(i),'(1,:) = std(d.Sp',num2str(i),');'];
    s103 = ['mu',num2str(i),'(a,:) = polyfit(t'',d.Sp',num2str(i),'(:,a),1);'];
    s104 = ['f.f',num2str(i),'(2,:) = abs(mu',num2str(i),'(:,1));'];
    s105 = ['f.f',num2str(i),'(3,:) = mu',num2str(i),'(:,2);'];
    s8 = ['f.f',num2str(i),'(4,:) = Findlow(d.Sp',num2str(i),',93);'];
%     s9 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',91);'];
    s10 = ['f.f',num2str(i),'(5,:) = Findlow(d.Sp',num2str(i),',mean(d.Sp',num2str(i),'));'];
    
%     s3 = ['f.f',num2str(i),'(7,:) = (max(d.Sp',num2str(i),')-min(d.Sp',num2str(i),'))./max(d.Sp',num2str(i),');'];
    s4 = ['f.f',num2str(i),'(6,:) = min(d.Sp',num2str(i),')./mean(d.Sp',num2str(i),');'];
    
    s7 = ['f.f',num2str(i),'(7,:) = 2*max(d.f.fft',num2str(i),')./sum(d.f.fft',num2str(i),');'];
    s204 = ['f.f',num2str(i),'(8,:) = std(d.f.fft',num2str(i),'(1:IN,:));'];
    s201 = ['temp = TFcal(d.f',num2str(i),',WT,FT,rfs);'];
    s205 = ['temp2 = TFcal(d.Sp',num2str(i),',WT,FT,rfs);'];
    s202 = ['f.f',num2str(i),' = [f.f',num2str(i),';temp];'];
    s206 = ['f.f',num2str(i),' = [f.f',num2str(i),';temp2];'];
%     s101 = ['f.f',num2str(i),'(10,:) = sum(abs(d.f',num2str(i),'(1:fix(data.T*rfs/3),:)))-sum(abs(d.f',num2str(i),'(fix(data.T*rfs/3)+1:fix(data.T*rfs*2/3),:)));'];
%     s102 = ['f.f',num2str(i),'(11,:) = sum(abs(d.f',num2str(i),'(fix(data.T*rfs/3)+1:fix(data.T*rfs*2/3),:)))-sum(abs(d.f',num2str(i),'(fix(data.T*2*rfs)/3+1:end,:)));'];
%     eval(s1);
%     eval(s2);
    eval(s203);
    eval(s106);
    for a = 1:l(i)
        eval(s103);
    end
    eval(s104);
    eval(s105);
    eval(s8);
%     eval(s9);
    eval(s10); 
%     eval(s3);
    eval(s4);
    eval(s7);
    eval(s204);
    eval(s201);
    eval(s205);
    eval(s202);
    eval(s206);
%     eval(s101);
%     eval(s102);


%     s2 = ['ft = [ft,f.f',num2str(i),'];'];
%     s3 = ['at = [at;an.a',num2str(i),'];'];
%     eval(s2);
%     eval(s3);
    
end
toc;
% headerlines = input('Please add some annotation to this feature file:');
name = input('Please input the feature file name you want to save:');
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'',''f'',''an'',''ft'',''at'',''WT'',''ST'');'];
eval(s13);