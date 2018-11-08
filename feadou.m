clc;
clear;
close all;

t1 = input('Please input the data name1 you want to extract features:');
t2 = input('Please input the data name2 you want to extract features:');
T1 = ['dataw',num2str(t1),'&1'];
T2 = ['dataw',num2str(t2),'&1'];
spt1 = input('Please input the spt1:');
spt2 = input('Please input the spt2:');
flowt = input('Please input the flowt');
index = input('Please input the index of the subject you want to extract:');
T = T1;
spt = spt1;
feaextract(T,index,flowt,spt);
T = T2;
spt = spt2;
feaextract10(T,index,flowt,spt);
