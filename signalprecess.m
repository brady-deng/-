clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for constructing the annotations for this dataset.
%   The variable T in this script is the length of time for deriving.
%   In 1-23 I add an auto saving code to make the script more effective.
%   Last editted by Brady Deng in 1-23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


data = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\dataforanalysis.mat');
an = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\onlyanno.mat');

fs = 128;
N = 25;
%   Here T is the length of the period time.
T = input('Please input the data length:(s)');

for i = 1:N
    s1 = ['l(i,1) = length(data.f',num2str(i),');'];
    s2 = ['l(i,2) = floor(l(i,1)/(T*fs));'];
    s3 = ['data.f',num2str(i),' = data.f',num2str(i),'(1:l(i,2)*fs*T);'];
    s10 = ['data.Sp',num2str(i),' = data.Sp',num2str(i),'(1:l(i,2)*fs*T);'];
    s11 = ['data.So',num2str(i),' = data.So',num2str(i),'(1:l(i,2)*fs*T);'];
    s12 = ['data.Pul',num2str(i),' = data.Pul',num2str(i),'(1:l(i,2)*fs*T);'];
    s4 = ['l(i,3) = length(an.a',num2str(i),');'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s10);
    eval(s11);
    eval(s12);
    eval(s4);
    c = 1;
    for a = 1:l(i,3)
        s9 = ['if an.a',num2str(i),'(a,2) ~= 0 ann.a',num2str(i),'(c,1) = an.a',num2str(i),'(a,1);end'];
        s4 = ['if an.a',num2str(i),'(a,2) ~= 0 ann.a',num2str(i),'(c,2) = an.a',num2str(i),'(a,1) + an.a',num2str(i),'(a,2);c = c + 1;end'];
        eval(s9);
        eval(s4);
        
    end
    s5 = ['if T-rem(ann.a',num2str(i),'(count,1),T)>5 ann.a',num2str(i),'(count,1) = ceil(ann.a',num2str(i),'(count,1)/T);else ann.a',num2str(i),'(count,1) = ceil(ann.a',num2str(i),'(count,1)/T)+1;end'];
    s101 = ['if rem(ann.a',num2str(i),'(count,2),T)>5 ann.a',num2str(i),'(count,2) = ceil(ann.a',num2str(i),'(count,2)/T);else ann.a',num2str(i),'(count,2) = ceil(ann.a',num2str(i),'(count,2)/T)-1;end'];
    s6 = ['anno.a',num2str(i),' = zeros(l(i,2),1);'];
    s8 = ['l(i,4) = length(ann.a',num2str(i),'(:,1));'];
    
    
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
    eval(s8);
    for count = 1:l(i,4)
        eval(s5);
        eval(s101);
    end
    eval(s6);

    
    
    for a = 1:l(i,4)
        s7 = ['anno.a',num2str(i),'(ann.a',num2str(i),'(a,1):ann.a',num2str(i),'(a,2)) = 1;'];
        eval(s7);
    end
    
    
    s9 = ['dataseq.f',num2str(i),' = reshape(data.f',num2str(i),',fs*T,[]);'];
    s10 = ['dataseq.Sp',num2str(i),' = reshape(data.Sp',num2str(i),',fs*T,[]);'];
    s11 = ['dataseq.So',num2str(i),' = reshape(data.So',num2str(i),',fs*T,[]);'];
    s12 = ['dataseq.Pul',num2str(i),' = reshape(data.Pul',num2str(i),',fs*T,[]);'];
    
    eval(s9);
    eval(s10);
    eval(s11);
    eval(s12);
    

end

s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\data',num2str(T),'.mat'',''T'',''anno'',''dataseq'',''data'');'];
eval(s13);
