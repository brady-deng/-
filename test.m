% clc
% clear
% close all

temp = f.f1([3,5,8,9],:);
temp = temp';
temp2 = zscore(temp);
temp3 = temp2.*temp2;
temp4 = sum(temp3');
f.f1(10,:) = temp4;
