

i = input('Please input the subject number you want to plot:');

Nx = 1;

s1 = ['figure(),subplot(211),plot(ds.t.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
eval(s1);
s3 = ['subplot(212),plot(ds.t.Sp',num2str(i),'); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
s1012 = ['templ = length(ds.a.a',num2str(i),');'];
eval(s1012);
for b = 1:templ
    s2 = ['if ds.a.a',num2str(i),'(b) == 1 subplot(211),scatter(b*rfs,0,''fill'');end'];
    s951 = ['if ds.a.a',num2str(i),'(b) == 2 subplot(211),scatter(b*rfs,0,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
end
eval(s3);
for b = 1:templ
    s2 = ['if ds.a.a',num2str(i),'(b) == 1 subplot(212),scatter(b*rfs,94,''fill'');end'];
    s951 = ['if ds.a.a',num2str(i),'(b) == 2 subplot(212),scatter(b*rfs,94,''d'',''fill'');end'];
    eval(s2);
    eval(s951);
end


