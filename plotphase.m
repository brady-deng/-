num = input('Please input the index of subject you want to plot:');
winum = input('Please input the index of window you want to plot:');
s1022 = ['tempan = an.a',num2str(num),';'];
eval(s1022);
s1008 = ['l = length(d.f',num2str(num),'(:,',num2str(winum),'));'];
eval(s1008);
x = 1:l;
x = x/8;
s1 = ['figure(),subplot(311),plot(x,d.f',num2str(num),'(:,',num2str(winum),'));hold on'];
eval(s1);
% s911 = ['plot([1:length(d.f',num2str(num),'(:,',num2str(winum),'))],max(abs(d.f',num2str(num),'(:,',num2str(winum),')))*Hapor,''--'');'];
% eval(s911);
% s913 = ['plot([1:length(d.f',num2str(num),'(:,',num2str(winum),'))],-max(abs(d.f',num2str(num),'(:,',num2str(winum),')))*Hapor,''--'');'];
% eval(s913);
title_num = ['Subject',num2str(num),'index',num2str(winum),',',num2str(tempan(winum)),';'];
hold on;
l = length(temp1{winum});
for i = 1:l
    s2 = ['scatter(temp1{winum}(i)/8,d.f',num2str(num),'(temp1{winum}(i),',num2str(winum),'),''fill'');'];
    eval(s2);
    
end
title(title_num);
s2 = ['subplot(312),plot(d.Sp',num2str(num),'(:,',num2str(winum),'));hold on;'];
s912 = ['plot([1:length(d.Sp',num2str(num),'(:,',num2str(winum),'))],max(d.Sp',num2str(num),'(:,',num2str(winum),'))*HaSp,''--'');'];
s3 = ['subplot(313),plot(d.f.fft',num2str(num),'(:,',num2str(winum),'));xlim([0,100]);'];


eval(s2);
eval(s912);
title(title_num);
eval(s3);
title(title_num);
s9201 = ['fea = f.f',num2str(num),'(:,',num2str(winum),');'];
eval(s9201);
disp(fea);