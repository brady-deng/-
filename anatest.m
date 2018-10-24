%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is for analyzing the result of with&without SMOTE.
%   test24 is the script without SMOTE and use the origin data for
%   trainging.
%   net23 is the script with SMOTE and use SMOTE to balance the apnea and 
%   health however there may be some problems with it. Perhaps the SMOTE is
%   only used for the training set.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;

nt = 10;
for count = 0:nt
    net23;
    test24;
    s1 = ['stanws.n',num2str(count),' = num;'];
    s2 = ['stanwos.n',num2str(count),' = num2;'];
    eval(s1);
    eval(s2);
end