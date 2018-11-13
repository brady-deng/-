clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for processing the annotation files.
%   Last editted by brady deng in 1-22
%   Finally we can get the starttime and durtion time of the apnea and
%   hypopnea in the anno mat file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\dataflow.mat');
an = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\95\an.mat');
s = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\Starttime.mat');

N = 25;
fs = 128;
T = 60;
H = 24;

st = zeros(N,3);



for i = 1:N
    s1 = ['temp',num2str(2*i-1),' = an.a',num2str(i),'{1};'];
    s2 = ['temp',num2str(2*i),' = an.a',num2str(i),'{2};'];
    s3 = ['l(i) = length(an.a',num2str(i),'{1});'];
    
    eval(s1);
    eval(s2);
    eval(s3);
%     
%     for a = 1:l(i)
%         s14 = ['if an.a',num2str(i),'(a,2) == 0 an.a',num2str(i),'(a,1:2) = [];end'];
%         eval(s14);
%     end
    
    s4 = ['ann.a',num2str(i),' = zeros(l(i),5);'];
    
    s10 = ['st(i,1) = str2num(s{i}(1:2));'];
    s11 = ['st(i,2) = str2num(s{i}(3:4));'];
    s12 = ['st(i,3) = str2num(s{i}(5:6));'];
    s13 = ['anno.a',num2str(i),' = zeros(l(i),3);'];
    
    
    eval(s4);
    eval(s10);
    eval(s11);
    eval(s12);
    
    
    for a = 1:l(i)
%         s5 = ['if strcmp(an.a',num2str(i),'{2}(a),''EVENT'') an.a',num2str(i),'{2}(a) = an.a',num2str(i),'{3}(a);end'];
        s5 = ['if strcmp(an.a',num2str(i),'{2}{a},''EVENT'') an.a',num2str(i),'{2}{a} = 0;end'];
        s6 = ['ann.a',num2str(i),'(a,1) = str2num(an.a',num2str(i),'{1}{a}(1:2));'];
        s7 = ['ann.a',num2str(i),'(a,2) = str2num(an.a',num2str(i),'{1}{a}(3:4));'];
        s8 = ['ann.a',num2str(i),'(a,3) = str2num(an.a',num2str(i),'{1}{a}(5:6));'];
        s9 = ['if an.a',num2str(i),'{2}{a} ~= 0 ann.a',num2str(i),'(a,4) = str2num(an.a',num2str(i),'{2}{a});end'];
        %PB时间标注
        s951 = ['if an.a',num2str(i),'{2}{a} == 0 ann.a',num2str(i),'(a,4) = 20;end'];
        s952 = ['if an.a',num2str(i),'{2}{a} == 0 ann.a',num2str(i),'(a,5) = 1;end'];
        s10 = ['ann.a',num2str(i),'(a,1:3) = ann.a',num2str(i),'(a,1:3) - st(i,:);'];
        
        s12 = ['anno.a',num2str(i),'(a,1) = ann.a',num2str(i),'(a,1)*T*T+ann.a',num2str(i),'(a,2)*T+ann.a',num2str(i),'(a,3);'];
        s13 = ['anno.a',num2str(i),'(a,2) = ann.a',num2str(i),'(a,4)'];
        s953 = ['anno.a',num2str(i),'(a,3) = ann.a',num2str(i),'(a,5)'];
        s14 = ['if ann.a',num2str(i),'(a,1)<0 ann.a',num2str(i),'(a,1) = ann.a',num2str(i),'(a,1) + H;end'];
        
        
        
        
        
        
        eval(s5);
        s1112 = ['if strcmp(an.a',num2str(i),'{3}{a},''POSSIBLE'') an.a',num2str(i),'{2}{a} = 0;end'];
        eval(s1112);
        eval(s6);
        eval(s7);
        eval(s8);
        eval(s9);
        eval(s951);
        eval(s952);
        eval(s10);
        eval(s14);
        eval(s12);
        eval(s13);
        eval(s953);
        
    end
    
    
    
    
    
%     s8 = ['ann.a',num2str(i),'(:,1) = ann.a',num2str(i),'(:,1) - s(i);'];
%     eval(s8);
    
    
end


s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\95\onlyanno.mat'',''anno'');'];
eval(s13);
