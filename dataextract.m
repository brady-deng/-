clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for transforming the origin files into mat files to
%   process.
%   Last editted by Brady Deng in 1-22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 28;
num = 25;
a = 1;
for i = 2:28
    if i ~= 4 && i ~= 16
        s1 = ['data.d',num2str(a),' = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\data',num2str(i),'.mat'');'];
        if(i<10)
            s2 = ['file',num2str(a),'= fopen(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\annotation\ucddb00',num2str(i),'_respevt.txt'');'];
            s8 = ['st.s',num2str(a),'= importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\annotation\ucddb00',num2str(i),'_stage.txt'');'];
        else
            s2 = ['file',num2str(a),'= fopen(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\annotation\ucddb0',num2str(i),'_respevt.txt'');'];
            s8 = ['st.s',num2str(a),'= importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\annotation\ucddb0',num2str(i),'_stage.txt'');'];
        end
        s3 = ['t',num2str(a),' = textscan(file',num2str(a),',''%s%s%s%s%s%s%s%s%s'',''headerlines'',0);'];
        s5 = ['l(i) = length(t',num2str(a),'{3});'];
        
        s4 = ['an.a',num2str(a),'{1} = t',num2str(a),'{1}(1:l(i));'];
        s6 = ['an.a',num2str(a),'{2} = t',num2str(a),'{3}(1:l(i));'];
        s7 = ['an.a',num2str(a),'{3} = t',num2str(a),'{2}(1:l(i));'];

        
        
%         eval(s1);

        eval(s2);
        eval(s8);
        eval(s3);
        eval(s5);
        
%         for a = 1:num
%             s7 = ['if
        
        eval(s4);
        eval(s6);
        eval(s7);
        a = a+1;
    end
end

s13 = ['save(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\95\an.mat'',''an'');'];
eval(s13);


%%
%   Here is to extract the flow&SpO2&Sound&Pulse signals to analyze because
%   in 1-22 I find that only rely on the flow channal is not feasible.
%   Editted by Brady Deng in 1-23.
% for a = 1:num
%         s9 = ['d.f',num2str(a),' = data.d',num2str(a),'(:,9);'];
%         s10 = ['d.Sp',num2str(a),' = data.d',num2str(a),'(:,7);'];
%         s11 = ['d.So',num2str(a),' = data.d',num2str(a),'(:,8);'];
%         s12 = ['d.Pul',num2str(a),' = data.d',num2str(a),'(:,14);'];
%         
%         eval(s9);
%         eval(s10);
%         eval(s11);
%         eval(s12);
% end


