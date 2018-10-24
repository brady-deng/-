function [ output_args ] = plot_d( data,label,i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s1 = ['figure(),subplot(211),plot(data.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
s3 = ['subplot(212),plot(data.Sp',num2str(i),'); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
    
eval(s1);
for b = 1:l(1,i)
    s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,0,''fill'');end'];
    eval(s2);
end
eval(s3);
for b = 1:l(1,i)
    s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,94,''fill'');end'];
    eval(s2);
end


end

