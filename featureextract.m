clc;
clear;
close all;
T = input('Please input the data length for feature extract:(s):');

s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\datar',num2str(T),'.mat'');'];
eval(s1);

% T = data.T;
fs = 128;
N = 23;
C = 16;

an = data.anr;

for i = 1:N
    s1 = ['d.f',num2str(i),' = data.datar.f',num2str(i),'(1:C:end,:);'];
    s2 = ['d.Sp',num2str(i),' = data.datar.Sp',num2str(i),'(1:C:end,:);'];
    s3 = ['d.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
    s4 = ['l(i) = length(d.f',num2str(i),'(1,:));'];
    s5 = ['d.Sp.d',num2str(i),' = std(d.Sp',num2str(i),');'];
    s6 = ['d.f.d',num2str(i),' = std(d.f',num2str(i),');'];
    s7 = ['d.f.fft',num2str(i),' = abs(fft(d.f',num2str(i),'));'];
    s8 = ['d.f.ftk',num2str(i),' = d.f.fft',num2str(i),'(10:40,:);'];
    s9 = ['d.f.ftk',num2str(i),' = mapminmax(d.f.ftk',num2str(i),''');'];
    s10 = ['d.f.kur',num2str(i),' = kurtosis(d.f.ftk',num2str(i),''');'];
    
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
    eval(s10);
    
end

for i = 1:N
    s1 = ['f.f',num2str(i),'(1,:) = d.f.kur',num2str(i),';'];
    s2 = ['f.f',num2str(i),'(2,:) = min(d.Sp',num2str(i),');'];
    s3 = ['f.f',num2str(i),'(3,:) = (max(d.Sp',num2str(i),')-min(d.Sp',num2str(i),'))./max(d.Sp',num2str(i),');'];
    s4 = ['f.f',num2str(i),'(4,:) = min(d.Sp',num2str(i),')./mean(d.Sp',num2str(i),');'];
%     s5 = ['f.f',num2str(i),'(5,a) = ApEn(2,0.2*d.Sp.d',num2str(i),'(a),d.Sp',num2str(i),'(:,a),0);'];
    s6 = ['f.f',num2str(i),'(5,a) = ApEn(2,0.2*d.f.d',num2str(i),'(a),d.f',num2str(i),'(:,a),0);'];
    s7 = ['f.f',num2str(i),'(6,:) = 2*max(d.f.fft',num2str(i),')./sum(d.f.fft',num2str(i),');'];
    s8 = ['f.f',num2str(i),'(7,a) = Findlow(d.Sp',num2str(i),'(:,a),93);'];
    s9 = ['f.f',num2str(i),'(8,a) = Findlow(d.Sp',num2str(i),'(:,a),91);'];
    s10 = ['f.f',num2str(i),'(9,a) = Findlow(d.Sp',num2str(i),'(:,a),mean(d.Sp',num2str(i),'));'];
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s7);
    
    
    
    for a = 1:l(i)
        eval(s6);
        eval(s8);
        eval(s9);
        eval(s10);
    end
    
end
headerlines = input('Please add some annotation to this feature file:');
name = input('Please input the feature file name you want to save:');
s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',name,'.mat'',''f'',''an'',''headerlines'');'];
eval(s13);