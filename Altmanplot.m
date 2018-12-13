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
step2 = 0.5;
xcoor = min(varmean):step2:max(varmean);
threh = md+2*sd;
threl = md-2*sd;
threhy = repmat(threh,length(xcoor),1);
threly = repmat(threl,length(xcoor),1);
mdy = repmat(md,length(xcoor),1);
zy = repmat(0,length(xcoor),1);
figure(),scatter(varmean,vardiff);
hold on;
plot(xcoor,threhy,'r--');
plot(xcoor,threly,'r--');
plot(xcoor,zy,'black--');
plot(xcoor,mdy,'b--');
xlim([min(varmean)-step,max(varmean)+step]);
ylim([md-4*sd,md+4*sd]);
xlabel('(AHIref+AHIpre)/2');
ylabel('AHIref-AHItest');


end

