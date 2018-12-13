

i = input('Please input the subject number you want to plot:');
startsec = input('Please input the start second:');
endssec = input('Please input the end second:');
Nx = 1;
start = startsec*rfs;
ends = endssec*rfs;
s1 = ['figure(),subplot(311),plot(ds.t.f',num2str(i),'(start:ends)); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),'startsec:',num2str(startsec),'endsec:',num2str(endssec),''');'];
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

s3 = ['subplot(312),plot(ds.t.Sp',num2str(i),'(start:ends)); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
eval(s3); 

for b = 1:length(labelroi)
    s2 = ['if labelroi(b) == 1 subplot(311),scatter(b*rfs,0,''fill'');end'];
    s951 = ['if labelroi(b) == 2 subplot(311),scatter(b*rfs,0,''d'');end'];
    eval(s2);
    eval(s951);
end
eval(s3);
for b = 1:length(labelroi)
    s2 = ['if labelroi(b) == 1 subplot(312),scatter(b*rfs,94,''fill'');end'];
    s951 = ['if labelroi(b) == 2 subplot(312),scatter(b*rfs,94,''d'');end'];
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
subplot(313),plot(temp);
hold on;
templabel = label(1:8:end);
labelroi = templabel(start/8:ends/8);
for b = 1:length(labelroi)
    if labelroi(b) == 1
        subplot(313),scatter(b,0,'fill');
        hold on;
    end
end