clc;
clear;
close all;



cyc = 5;

for count = 0:cyc
    OnenetWS;
    OnenetWOS;
    testone;
    net23withsmote;
    s1 = ['stanws.n',num2str(count),' = result2;'];
    s2 = ['stanwos.n',num2str(count),' = result;'];
    s3 = ['owos.n',num2str(count),' = num;'];
    s4 = ['ows.n',num2str(count),' = num2;'];
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
end