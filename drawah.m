function [ output_args ] = drawah( test,pre )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
test = reshape(test,[],1);
pre = reshape(pre,[],1);
test(isnan(test) == 1) = [];
pre(isnan(pre) == 1) = [];
l = max([test;pre]);
xind = 1:l;
yind = zeros(1,l);
yindtest = yind;
yindpre = yind;
yindtest(test) = 1;
yindpre(pre) = 1;
% h = figure(1);
% ax = axes('Parent',h);
figure(),subplot(211),bar(xind,yindtest);
title('Reference Events','FontSize',20);
set(gca,'ytick',[0 1],'yticklabel',{'N' 'AH'})
set(gca,'FontSize',20);
subplot(212),bar(xind,yindpre);
title('Estimated Events','FontSize',20);
set(gca,'ytick',[0 1],'yticklabel',{'N' 'AH'})
set(gca,'FontSize',20);
% ax.YAxis.Visible = 'off';
% ax.XAxis.Visible = 'on';


end

