

i = input('Please input the subject number you want to plot:');
startsec = input('Please input the start second:');
endssec = input('Please input the end second:');
Nx = 1;
start = startsec*rfs;
ends = endssec*rfs;
s1 = ['figure(),subplot(811),plot(ds.t.f',num2str(i),'(start:ends)); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),'startsec:',num2str(startsec),'endsec:',num2str(endssec),''');'];
eval(s1);
% s9193 = ['label = anno.a',num2str(i),';'];
% eval(s9193);
s9193 = ['templabel = ds.a.a',num2str(i),';'];
eval(s9193);


% % [m,n] = size(input_args);
s9191 = ['ll = length(ds.t.f',num2str(i),');'];
eval(s9191);
label = zeros(1,ll);
labelroi = templabel(startsec:endssec);

s3 = ['subplot(812),plot(ds.t.Sp',num2str(i),'(start:ends)); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
eval(s3); 
start = start*16;
ends = ends*16;
s3 = ['subplot(813),plot(ds.t.ecg',num2str(i),'(start:ends)); hold on;grid on;title(''The ECG signal of SUBJECT',num2str(i),''');'];
eval(s3); 
s3 = ['subplot(814),plot(ds.t.sound',num2str(i),'(start:ends)); hold on;grid on;title(''The SOUND signal of SUBJECT',num2str(i),''');'];
eval(s3); 
s3 = ['subplot(815),plot(ds.t.rib',num2str(i),'(start:ends)); hold on;grid on;title(''The RIB signal of SUBJECT',num2str(i),''');'];
eval(s3); 
s3 = ['subplot(816),plot(ds.t.abdo',num2str(i),'(start:ends)); hold on;grid on;title(''The ABDO signal of SUBJECT',num2str(i),''');'];
eval(s3); 
s3 = ['subplot(817),plot(ds.t.body',num2str(i),'(start:ends)); hold on;grid on;title(''The BODY signal of SUBJECT',num2str(i),''');'];
eval(s3); 


for b = 1:length(labelroi)
    s2 = ['if labelroi(b) == 1 subplot(811),scatter(b*rfs,0,''fill'');end'];
    s951 = ['if labelroi(b) == 2 subplot(811),scatter(b*rfs,0,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
end
eval(s3);
for b = 1:length(labelroi)
    s2 = ['if labelroi(b) == 1 subplot(812),scatter(b*rfs,94,''fill'');end'];
    s951 = ['if labelroi(b) == 2 subplot(812),scatter(b*rfs,94,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
end
% 
% 
s928 = ['temp = ds.t.Sp',num2str(i),'(start:8:ends);'];
eval(s928);
ob = diff(temp);
ob = reshape(ob,[],1);
temp = [0;ob];
subplot(813),plot(temp);
hold on;
templabel = label(1:8:end);
labelroi = templabel(start/8:ends/8);
for b = 1:length(labelroi)
    if labelroi(b) == 1
        subplot(813),scatter(b,0,'fill');
        hold on;
    end
end