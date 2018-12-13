clc;
clear;
close all;

ind = input('Please input the number of subjects you want to extract:');
if ind == 0
    ind = 2:28;
    ind_del = [4,16];
    ind_roi = setdiff(ind,ind_del);
    count = 1;
    for i = 1:length(ind_roi)
        s1114 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\data',num2str(ind_roi(i)),'.mat'');'];
        eval(s1114);
        s1114 = ['f',num2str(i),' = data(:,9);'];
        eval(s1114);
        s1114 = ['Sp',num2str(i),' = data(:,7);'];
        eval(s1114);
    end
else
    ind_roi = ind;
    for i = 1:length(ind_roi)
        s1114 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\data',num2str(ind_roi(i)),'.mat'');'];
        eval(s1114);
        ob(:,1) = data(:,7);
        ob(:,2) = data(:,9);
        ob(:,3) = data(:,6);
        ob(:,4) = data(:,8);
        ob(:,5) = data(:,11);
        ob(:,6) = data(:,12);
        ob(:,7) = data(:,13);
        com{1} = 'SpO2';
        com{2} = 'flow';
        com{3} = 'ECG';
        com{4} = 'sound';
        com{5} = 'ribcage';
        com{6} = 'abdo';
        com{7} = 'bodypos';
    end
end
     