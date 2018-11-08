function [ md,sd ] = Altmanplot( vargold,varest )
%Plot the altman plot of the vargold and varest
%   Detailed explanation goes here
l = length(vargold);
% varmean = zeros(l,1);
% vardiff = zeros(l,1);
varmean = (vargold+varest)/2;
vardiff = (vargold-varest)/2;

sd = std(vardiff);
md = mean(vardiff);
% num = 5000;
% step = (max(varmean)-min(varmean))/num;
step = 0.1;
xcoor = min(varmean):step:max(varmean);
threh = md+2*sd;
threl = md-2*sd;
figure(),scatter(varmean,vardiff);
hold on;
plot(xcoor,threh,'r--');
plot(xcoor,threl,'r--');
plot(xcoor,0,'black-');
plot(xcoor,md,'b--');
xlim([min(varmean)-step,max(varmean)+step]);
ylim([md-4*sd,md+4*sd]);
xlabel('(AHIref+AHIpre)/2');
ylabel('AHIref-AHItest');


end

