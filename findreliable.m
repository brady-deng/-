clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for extracting the reliable datasets.
%   Subject 3&9 may be unreliable via observaing the figure of this signal.
%   Besides in order to exclude the influences caused by the wake period,
%   finally i exclude the beginning period of this signal.
%   In 1-23 I add 3 more channels to this script obeying the former rules
%   Last editted by brady deng in 1-23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = input('Please input the data length for reliable:(s):');


s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\data',num2str(T),'.mat'');'];
% datat = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\dataflow.mat');
st = importdata('E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\sleepstage.mat');

eval(s1);


fs = 128;
N = 25;
% T = data.T;
RN = 23;

an = data.anno;
% d = data.data;

c = 1;
for i = 1:N
    
    s2 = ['if i~=3 && i~=9 anr.a',num2str(c),' = an.a',num2str(i),'; end'];
    
    s4 = ['if i~=3 && i~=9 str.s',num2str(c),' = st.s',num2str(i),';c = c+1; end'];
    s1 = ['if i~=3 && i~=9 datar.f',num2str(c),' = data.dataseq.f',num2str(i),'; end'];
    s5 = ['if i~=3 && i~=9 datar.Sp',num2str(c),' = data.dataseq.Sp',num2str(i),'; end'];
    s6 = ['if i~=3 && i~=9 datar.So',num2str(c),' = data.dataseq.So',num2str(i),'; end'];
    s7 = ['if i~=3 && i~=9 datar.Pul',num2str(c),' = data.dataseq.Pul',num2str(i),'; end'];
    
    s8 = ['if i~=3 && i~=9 datatr.f',num2str(c),' = data.data.f',num2str(i),'; end'];
    s9 = ['if i~=3 && i~=9 datatr.Sp',num2str(c),' = data.data.Sp',num2str(i),'; end'];
    s10 = ['if i~=3 && i~=9 datatr.So',num2str(c),' = data.data.So',num2str(i),'; end'];
    s11 = ['if i~=3 && i~=9 datatr.Pul',num2str(c),' = data.data.Pul',num2str(i),'; end'];
    
    
    
    eval(s1);
    eval(s2);
%     eval(s3);
    eval(s4);
    eval(s5);
%     eval(s6);
%     eval(s7);
    
    eval(s8);
    eval(s9);
%     eval(s10);
%     eval(s11);
    
    
end


N = RN;

for i = 1:N
    s1 = ['l(1,i) = length(datatr.f',num2str(i),');'];
    s2 = ['l(2,i) = length(anr.a',num2str(i),');'];
    s3 = ['l(3,i) = length(str.s',num2str(i),');'];
    
    eval(s1);
    eval(s2);
    eval(s3);
end




for i = 1:N
    s1 = ['l(4,i) = floor(l(2,i)*0.1);'];
    
    s3 = ['anr.a',num2str(i),' = anr.a',num2str(i),'(l(4,i)+1:end);'];
    s4 = ['l(5,i) = l(2,i) - l(4,i);'];
    
    
    s2 = ['datar.f',num2str(i),' = datar.f',num2str(i),'(:,l(4,i)+1:end);'];
    s6 = ['datar.Sp',num2str(i),' = datar.Sp',num2str(i),'(:,l(4,i)+1:end);'];
    s7 = ['datar.So',num2str(i),' = datar.So',num2str(i),'(:,l(4,i)+1:end);'];
    s8 = ['datar.Pul',num2str(i),' = datar.Pul',num2str(i),'(:,l(4,i)+1:end);'];
    
    s9 = ['datatr.f',num2str(i),' = reshape(datar.f',num2str(i),',1,[]);'];
    s10 = ['datatr.Sp',num2str(i),' = reshape(datar.Sp',num2str(i),',1,[]);'];
    s11 = ['datatr.So',num2str(i),' = reshape(datar.So',num2str(i),',1,[]);'];
    s12 = ['datatr.Pul',num2str(i),' = reshape(datar.Pul',num2str(i),',1,[]);'];
    
    eval(s1);
    
    eval(s3);
    eval(s4);
%     eval(s5);
    eval(s2);
    eval(s6);
%     eval(s7);
%     eval(s8);
    
%     eval(s9);
%     eval(s10);
%     eval(s11);
%     eval(s12);
end

for i = 1:N
    s1 = ['len(i) = length(anr.a',num2str(i),');'];
    s2 = ['are.a',num2str(i),' = zeros(len(i),1);'];
    s3 = ['are.a',num2str(i),' = Findre(datar.Sp',num2str(i),');'];
    s4 = ['ara.a',num2str(i),' = ~are.a',num2str(i),';'];
    s5 = ['anr.a',num2str(i),' = anr.a',num2str(i),'(ara.a',num2str(i),');'];
    s6 = ['datar.f',num2str(i),' = datar.f',num2str(i),'(:,ara.a',num2str(i),');'];
    s7 = ['datar.Sp',num2str(i),' = datar.Sp',num2str(i),'(:,ara.a',num2str(i),');'];
    s8 = ['datatr.f',num2str(i),' = reshape(datar.f',num2str(i),',1,[]);'];
    s9 = ['datatr.Sp',num2str(i),' = reshape(datar.Sp',num2str(i),',1,[]);'];
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
        
end


s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\datar',num2str(T),'.mat'',''T'',''anr'',''datar'',''datatr'');'];
eval(s13);