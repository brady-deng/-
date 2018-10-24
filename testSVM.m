clc;
clear;
close all;


N = 10;
for ite_count = 0:N
    s101 = ['svmwr.r',num2str(ite_count),' = result2;'];
%     s102 = ['svmor.r',num2str(ite_count),' = num;'];
%     SVMforone;
    SVMtest;
    eval(s101);
%     eval(s102);

    
    
end
svmwt = zeros(1,13);
for i = 0:10
%     s1 = ['svmot = svmot+d.svmor.r',num2str(i),';'];
    s2 = ['svmwt = svmwt+svmwr.r',num2str(i),';'];
%     eval(s1);
    eval(s2);
end
svmwt(1,11) = 100*svmwt(1,7)/(svmwt(1,5)+svmwt(1,6));
svmwt(1,12) = 100*svmwt(1,9)/svmwt(1,6);
svmwt(1,13) = 100*svmwt(1,10)/svmwt(1,5);