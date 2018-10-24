temp1.fkur = [];
temp1.fmsp = [];
temp1.fspstd = [];
temp1.ffstd = [];
temp1.fsplp = [];
temp1.fsplpm = [];
temp1.ffmap = [];
temp1.ffsum = [];
temp1.fdsumi = [];
temp1.fdsumii = [];
temp1.fnl93 = [];
temp1.fnl92 = [];
temp1.fnl91 = [];
temp1.fnl90 = [];
temp1.fnlmean = [];
temp1.fmui = [];
temp1.fmuii = [];


temp2.fkur = [];
temp2.fmsp = [];
temp2.fspstd = [];
temp2.ffstd = [];
temp2.fsplp = [];
temp2.fsplpm = [];
temp2.ffmap = [];
temp2.ffsum = [];
temp2.fdsumi = [];
temp2.fdsumii = [];
temp2.fnl93 = [];
temp2.fnl92 = [];
temp2.fnl91 = [];
temp2.fnl90 = [];
temp2.fnlmean = [];
temp2.fmui = [];
temp2.fmuii = [];

for i = 1:23
    ft = temp1;
    s1 = ['ft.fkur = [ft.fkur,f.h.kur',num2str(i),'];'];
    s2 = ['ft.fmsp = [ft.fmsp,f.h.msp',num2str(i),'];'];
    s3 = ['ft.fspstd = [ft.fspstd,f.h.spstd',num2str(i),'];'];
    s4 = ['ft.ffstd = [ft.ffstd,f.h.fstd',num2str(i),'];'];
    s5 = ['ft.fsplp = [ft.fsplp,f.h.splp',num2str(i),'];'];
    s6 = ['ft.fsplpm = [ft.fsplpm,f.h.splpm',num2str(i),'];'];
    s7 = ['ft.ffmap = [ft.ffmap,f.h.fmap',num2str(i),'];'];
    s8 = ['ft.ffsum = [ft.ffsum,f.h.fsum',num2str(i),'];'];
    s9 = ['ft.fdsumi = [ft.fdsumi,f.h.dsumi',num2str(i),'];'];
    s10 = ['ft.fdsumii = [ft.fdsumii,f.h.dsumii',num2str(i),'];'];
    s11 = ['ft.fnl93 = [ft.fnl93,f.h.nl93',num2str(i),'];'];
    s12 = ['ft.fnl92 = [ft.fnl92,f.h.nl92',num2str(i),'];'];
    s13 = ['ft.fnl91 = [ft.fnl91,f.h.nl91',num2str(i),'];'];
    s14 = ['ft.fnl90 = [ft.fnl90,f.h.nl90',num2str(i),'];'];
    s15 = ['ft.fnlmean = [ft.fnlmean,f.h.nlmean',num2str(i),'];'];
    s16 = ['ft.fmui = [ft.fmui,f.h.mu',num2str(i),'(:,1)''];'];
    s17 = ['ft.fmuii = [ft.fmuii,f.h.mu',num2str(i),'(:,2)''];'];
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
    eval(s10);
    eval(s11);
    eval(s12);
    eval(s13);
    eval(s14);
    eval(s15);
    eval(s16);
    eval(s17);
    
    temp1 = ft;
    ft = temp2;
    
    
    s1 = ['ft.fkur = [ft.fkur,f.i.kur',num2str(i),'];'];
    s2 = ['ft.fmsp = [ft.fmsp,f.i.msp',num2str(i),'];'];
    s3 = ['ft.fspstd = [ft.fspstd,f.i.spstd',num2str(i),'];'];
    s4 = ['ft.ffstd = [ft.ffstd,f.i.fstd',num2str(i),'];'];
    s5 = ['ft.fsplp = [ft.fsplp,f.i.splp',num2str(i),'];'];
    s6 = ['ft.fsplpm = [ft.fsplpm,f.i.splpm',num2str(i),'];'];
    s7 = ['ft.ffmap = [ft.ffmap,f.i.fmap',num2str(i),'];'];
    s8 = ['ft.ffsum = [ft.ffsum,f.i.fsum',num2str(i),'];'];
    s9 = ['ft.fdsumi = [ft.fdsumi,f.i.dsumi',num2str(i),'];'];
    s10 = ['ft.fdsumii = [ft.fdsumii,f.i.dsumii',num2str(i),'];'];
    s11 = ['ft.fnl93 = [ft.fnl93,f.i.nl93',num2str(i),'];'];
    s12 = ['ft.fnl92 = [ft.fnl92,f.i.nl92',num2str(i),'];'];
    s13 = ['ft.fnl91 = [ft.fnl91,f.i.nl91',num2str(i),'];'];
    s14 = ['ft.fnl90 = [ft.fnl90,f.i.nl90',num2str(i),'];'];
    s15 = ['ft.fnlmean = [ft.fnlmean,f.i.nlmean',num2str(i),'];'];
    s16 = ['ft.fmui = [ft.fmui,f.i.mu',num2str(i),'(:,1)''];'];
    s17 = ['ft.fmuii = [ft.fmuii,f.i.mu',num2str(i),'(:,2)''];'];
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    eval(s4);
    eval(s5);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
    eval(s10);
    eval(s11);
    eval(s12);
    eval(s13);
    eval(s14);
    eval(s15);
    eval(s16);
    eval(s17);
    temp2 = ft;
end


ana(1,1) = mean(temp1.fkur);
ana(1,2) = mean(temp1.fmsp);
ana(1,3) = mean(temp1.fspstd);
ana(1,4) = mean(temp1.ffstd);
ana(1,5) = mean(temp1.fsplp);
ana(1,6) = mean(temp1.fsplpm);
ana(1,7) = mean(temp1.ffmap);
ana(1,8) = mean(temp1.ffsum);
ana(1,9) = mean(temp1.fdsumi);
ana(1,10) = mean(temp1.fdsumii);
ana(1,11) = mean(temp1.fnl93);
ana(1,12) = mean(temp1.fnl92);
ana(1,13) = mean(temp1.fnl91);
ana(1,14) = mean(temp1.fnl90);
ana(1,15) = mean(temp1.fnlmean);
ana(1,16) = mean(temp1.fmui);
ana(1,17) = mean(temp1.fmuii);

ana(2,1) = mean(temp2.fkur);
ana(2,2) = mean(temp2.fmsp);
ana(2,3) = mean(temp2.fspstd);
ana(2,4) = mean(temp2.ffstd);
ana(2,5) = mean(temp2.fsplp);
ana(2,6) = mean(temp2.fsplpm);
ana(2,7) = mean(temp2.ffmap);
ana(2,8) = mean(temp2.ffsum);
ana(2,9) = mean(temp2.fdsumi);
ana(2,10) = mean(temp2.fdsumii);
ana(2,11) = mean(temp2.fnl93);
ana(2,12) = mean(temp2.fnl92);
ana(2,13) = mean(temp2.fnl91);
ana(2,14) = mean(temp2.fnl90);
ana(2,15) = mean(temp2.fnlmean);
ana(2,16) = mean(temp2.fmui);
ana(2,17) = mean(temp2.fmuii);


ana(3,1) = std(temp1.fkur);
ana(3,2) = std(temp1.fmsp);
ana(3,3) = std(temp1.fspstd);
ana(3,4) = std(temp1.ffstd);
ana(3,5) = std(temp1.fsplp);
ana(3,6) = std(temp1.fsplpm);
ana(3,7) = std(temp1.ffmap);
ana(3,8) = std(temp1.ffsum);
ana(3,9) = std(temp1.fdsumi);
ana(3,10) = std(temp1.fdsumii);
ana(3,11) = std(temp1.fnl93);
ana(3,12) = std(temp1.fnl92);
ana(3,13) = std(temp1.fnl91);
ana(3,14) = std(temp1.fnl90);
ana(3,15) = std(temp1.fnlmean);
ana(3,16) = std(temp1.fmui);
ana(3,17) = std(temp1.fmuii);


ana(4,1) = std(temp2.fkur);
ana(4,2) = std(temp2.fmsp);
ana(4,3) = std(temp2.fspstd);
ana(4,4) = std(temp2.ffstd);
ana(4,5) = std(temp2.fsplp);
ana(4,6) = std(temp2.fsplpm);
ana(4,7) = std(temp2.ffmap);
ana(4,8) = std(temp2.ffsum);
ana(4,9) = std(temp2.fdsumi);
ana(4,10) = std(temp2.fdsumii);
ana(4,11) = std(temp2.fnl93);
ana(4,12) = std(temp2.fnl92);
ana(4,13) = std(temp2.fnl91);
ana(4,14) = std(temp2.fnl90);
ana(4,15) = std(temp2.fnlmean);
ana(4,16) = std(temp2.fmui);
ana(4,17) = std(temp2.fmuii);


for i = 1:17
    ana(5,2*i-1) = ana(1,i)-ana(3,i);
    ana(5,2*i) = ana(1,i)+ana(3,i);
    ana(6,2*i-1) = ana(2,i)-ana(4,i);
    ana(6,2*i) = ana(2,i)+ana(4,i);
end