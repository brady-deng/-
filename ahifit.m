function [ a ] = ahifit( goldvar,prevar )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure(),scatter(goldvar,prevar);
hold on;
tempmin = 0;
tempmax = max(goldvar+5);
tempind = tempmin:0.1:tempmax;
tempy = tempind;
plot(tempind,tempy,'black--');
[a,b] = polyfit(goldvar,prevar,1);
plot(tempind,a(1)*tempind+a(2));
xlabel('AHIrefer');
ylabel('AHIpre');
end

