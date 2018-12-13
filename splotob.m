

i = input('Please input the subject number you want to plot:');

Nx = 1;

s1 = ['figure(),subplot(711),plot(ds.t.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
eval(s1);
s3 = ['subplot(712),plot(ds.t.Sp',num2str(i),'); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
eval(s3);
s1012 = ['templ = length(ds.a.a',num2str(i),');'];
eval(s1012);
s1 = ['subplot(713),plot(ds.t.ecg',num2str(i),'); hold on;grid on;title(''The ECG signal of SUBJECT',num2str(i),''');'];
eval(s1);
s1 = ['subplot(714),plot(ds.t.sound',num2str(i),'); hold on;grid on;title(''The SOUND signal of SUBJECT',num2str(i),''');'];
eval(s1);
s1 = ['subplot(715),plot(ds.t.rib',num2str(i),'); hold on;grid on;title(''The RIB signal of SUBJECT',num2str(i),''');'];
eval(s1);
s1 = ['subplot(716),plot(ds.t.abdo',num2str(i),'); hold on;grid on;title(''The ABDO signal of SUBJECT',num2str(i),''');'];
eval(s1);
s1 = ['subplot(717),plot(ds.t.body',num2str(i),'); hold on;grid on;title(''The BODY signal of SUBJECT',num2str(i),''');'];
eval(s1);
for b = 1:templ
    s2 = ['if ds.a.a',num2str(i),'(b) == 1 subplot(711),scatter(b*rfs,0,''fill'');end'];
    s951 = ['if ds.a.a',num2str(i),'(b) == 2 subplot(711),scatter(b*rfs,0,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
    s2 = ['if ds.a.a',num2str(i),'(b) == 1 subplot(712),scatter(b*rfs,94,''fill'');end'];
    s951 = ['if ds.a.a',num2str(i),'(b) == 2 subplot(712),scatter(b*rfs,94,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
end



