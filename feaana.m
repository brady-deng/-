%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this script is for analyze the feature
%and visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id = input('Please input the subject id you want to analyze:');
% id = str2int(id);
s1016 = ['num_fea = length(f.f',num2str(id),'(:,1));'];
eval(s1016);
% num_fea = length(f.f.f1(:,1));
% num_fea = length(d.f.f1(:,1));
s1 = ['ind_a = an.a',num2str(id),' == 1;'];
s2 = ['ind_n = an.a',num2str(id),' == 0;'];
s911 = ['ind_s = an.a',num2str(id),' == 2;'];
% s1 = ['ind_a = f.an.a',num2str(id),' == 1;'];
% s2 = ['ind_n = f.an.a',num2str(id),' == 0;'];
% s1 = ['ind_a = d.an.a',num2str(id),' == 1;'];
% s2 = ['ind_n = d.an.a',num2str(id),' == 0;'];
% s911 = ['ind_s = d.an.a',num2str(id),' == 2;'];
s3 = ['fn = f.f',num2str(id),'(:,ind_n);'];
s4 = ['fa = f.f',num2str(id),'(:,ind_a);'];
s912 = ['fs = f.f',num2str(id),'(:,ind_s);'];
% s3 = ['fn = f.f.f',num2str(id),'(:,ind_n);'];
% s4 = ['fa = f.f.f',num2str(id),'(:,ind_a);'];
% s3 = ['fn = d.f.f',num2str(id),'(:,ind_n);'];
% s4 = ['fa = d.f.f',num2str(id),'(:,ind_a);'];
% s912 = ['fs = d.f.f',num2str(id),'(:,ind_s);'];
eval(s1);
eval(s2);
eval(s911);
% eval(s993);
eval(s3);
eval(s4);
eval(s912);
% eval(s994);
for i = 1:num_fea
    figure();
    subplot(1,3,1);
    x1 = fn(i,:)';
    x2 = fa(i,:)';
    x3 = fs(i,:)';
    boxplot(x1,'notch','on');
    title(['N',num2str(i)]);
    subplot(1,3,2);
    boxplot(x2,'notch','on');
    title(['A',num2str(i)]);
    subplot(1,3,3);
    boxplot(x3,'notch','on');
    title(['S',num2str(i)]);
end