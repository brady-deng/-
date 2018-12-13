

i = input('Please input the subject number you want to plot:');
startsec = input('Please input the start second:');
endssec = input('Please input the end second:');
s1 = ['oba = find(ds.a.a',num2str(i),' == 1);'];
eval(s1);
roil = find(oba>=startsec);
roih = find(oba<=endssec);
roi = intersect(roil,roih);
roisec = oba(roi);
roisec_diff = diff(roisec);
roisec_i = find(roisec_diff~=1);
roisec_i = unique([roisec_i,roisec_i+1]);
roi_ind = [roisec(1),roisec(roisec_i)',roisec(end)];
start = startsec*rfs;
ends = endssec*rfs;
s1 = ['roif = ds.t.f',num2str(i),'(start:ends);'];
eval(s1);
fmin = floor(min(roif))-5;
fmax = floor(max(roif))+5;
yt = fmin:fmax;
obl = length(yt);
roi_ind1 = repmat(roi_ind,obl,1);
Nx = 1;

xt = startsec:1/rfs:endssec;
s1 = ['figure(),subplot(211),plot(xt,roif); hold on;grid off;'];
eval(s1);
plot(roi_ind1,yt,'black--');
title('Flow signal','FontSize',20);
xlabel('Time/s','FontSize',20);
set(gca,'FontSize',20,'xtick',[startsec endssec]);
ylim([fmin fmax]);
xlim([startsec endssec]);
% s9193 = ['label = anno.a',num2str(i),';'];
% eval(s9193);
s9193 = ['templabel = ds.a.a',num2str(i),';'];
eval(s9193);


% % [m,n] = size(input_args);
s9191 = ['ll = length(ds.t.f',num2str(i),');'];
eval(s9191);
label = zeros(1,ll);
labelroi = templabel(startsec:endssec);
s1 = ['roisp = ds.t.Sp',num2str(i),'(start:ends);'];
eval(s1);
spmin = floor(min(roisp))-5;
spmax = floor(max(roisp))+5;
s3 = ['subplot(212),plot(xt,roisp); hold on;grid off;'];
eval(s3); 
yt = spmin:spmax;
obl = length(yt);
roi_ind2 = repmat(roi_ind,obl,1);
plot(roi_ind2,yt,'black--');
title('SpO2 signal','FontSize',20);
xlabel('Time/s','FontSize',20);
set(gca,'FontSize',20,'xtick',[startsec endssec]);
ylim([spmin spmax]);
xlim([startsec endssec]);

% for b = 1:length(labelroi)
%     s2 = ['if labelroi(b) == 1 subplot(211),scatter(b*rfs,0,''fill'');end'];
%     s951 = ['if labelroi(b) == 2 subplot(211),scatter(b*rfs,0,''d'');end'];
%     eval(s2);
%     eval(s951);
% end
% eval(s3);
% for b = 1:length(labelroi)
%     s2 = ['if labelroi(b) == 1 subplot(212),scatter(b*rfs,94,''fill'');end'];
%     s951 = ['if labelroi(b) == 2 subplot(212),scatter(b*rfs,94,''d'');end'];
%     eval(s2);
%     eval(s951);
% end
% % 
% % 
% s928 = ['temp = ds.t.Sp',num2str(i),'(start:8:ends);'];
% eval(s928);
% ob = diff(temp);
% ob = reshape(ob,[],1);
% temp = [0;ob];
% subplot(313),plot(temp);
% hold on;
% templabel = label(1:8:end);
% labelroi = templabel(start/8:ends/8);
% for b = 1:length(labelroi)
%     if labelroi(b) == 1
%         subplot(313),scatter(b,0,'fill');
%         hold on;
%     end
% end