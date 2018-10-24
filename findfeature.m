clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Last editted by Brady Deng in 1-24.
%   This script mainly looks for the features which can be used for
%   recognition model.
%   Finally i decide to extract mean&min&nl93(the number of points below 93)
%   &nl91&ap(approximate entropy)&fp(the propotion of fft5).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = input('Please input the data length for extracting features:');
s1 = ['data = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\datar',num2str(T),'.mat'');'];
eval(s1);

fs = 128;
N = 23;
% T = 15;
rfs = 8;

%%
%   Here is to do some analysis work about this dataset.
for i = 1:N
    s1 = ['data.anr.a',num2str(i),' = Findse(data.anr.a',num2str(i),');'];
    s2 = ['data.anr.an',num2str(i),' = antotrain(data.anr.a',num2str(i),');'];
    eval(s1);
    eval(s2);
end
for i = 1:N
    s1 = ['l(1,i) = length(data.anr.a',num2str(i),');'];
    s2 = ['l(2,i) = sum(data.anr.an',num2str(i),'(:,1));'];
    s3 = ['l(3,i) = sum(data.anr.an',num2str(i),'(:,4));'];
    
    
    
    eval(s1);
    eval(s2);
    eval(s3);
    c = 1;
    d = 1;
    for a = 1:l(1,i)
        s4 = ['if data.anr.a',num2str(i),'(a) == 1 label.il',num2str(i),'(c) = a;c = c+1;end'];
        s5 = ['if data.anr.a',num2str(i),'(a) == 0 label.hl',num2str(i),'(d) = a;d = d+1;end'];
        
        eval(s4);
        eval(s5);
    end
    
    
%     s8 = ['dh.d',num2str(i),' = [];'];
%     s9 = ['di.d',num2str(i),' = [];'];
    s6 = ['dh.f',num2str(i),' = data.datar.f',num2str(i),'(:,label.hl',num2str(i),');'];
    s7 = ['di.f',num2str(i),' = data.datar.f',num2str(i),'(:,label.il',num2str(i),');'];
    s8 = ['dh.Sp',num2str(i),' = data.datar.Sp',num2str(i),'(:,label.hl',num2str(i),');'];
    s9 = ['di.Sp',num2str(i),' = data.datar.Sp',num2str(i),'(:,label.il',num2str(i),');'];
    s10 = ['dh.So',num2str(i),' = data.datar.So',num2str(i),'(:,label.hl',num2str(i),');'];
    s11 = ['di.So',num2str(i),' = data.datar.So',num2str(i),'(:,label.il',num2str(i),');'];
    s12 = ['dh.Pul',num2str(i),' = data.datar.Pul',num2str(i),'(:,label.hl',num2str(i),');'];
    s13 = ['di.Pul',num2str(i),' = data.datar.Pul',num2str(i),'(:,label.il',num2str(i),');'];
    s14 = ['dh.lssp',num2str(i),' = dh.Sp',num2str(i),'(1:16:end,:);'];
    s15 = ['di.lssp',num2str(i),' = di.Sp',num2str(i),'(1:16:end,:);'];
    s16 = ['dh.lsf',num2str(i),' = dh.f',num2str(i),'(1:16:end,:);'];
    s17 = ['di.lsf',num2str(i),' = di.f',num2str(i),'(1:16:end,:);'];
    
    eval(s8);
    eval(s9);
    eval(s6);
    eval(s7);
    eval(s8);
    eval(s9);
%     eval(s10);
%     eval(s11);
%     eval(s12);
%     eval(s13);
    eval(s14);
    eval(s15);
    eval(s16);
    eval(s17);
end





%%
%   Here is to show the nasal flow signal and the annotations to help find
%   some features in time domain.
Nex = 1;
% for i = 1:Nex
%     s1 = ['figure(),subplot(411),plot(data.datatr.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
%     
%     
%     eval(s1);
%     for b = 1:l(1,i)
%         s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,0,''fill'');end'];
%         eval(s2);
%     end
%     
%     s3 = ['subplot(412),plot(data.datatr.Sp',num2str(i),'); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
%     s4 = ['subplot(413),plot(data.datatr.So',num2str(i),'); hold on;grid on;title(''The Sound signal of SUBJECT',num2str(i),''');'];
%     s5 = ['subplot(414),plot(data.datatr.Pul',num2str(i),'); hold on;grid on;title(''The Pulse signal of SUBJECT',num2str(i),''');'];
%     
%     eval(s3);
%     for b = 1:l(1,i)
%         s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,90,''fill'');end'];
%         eval(s2);
%     end
%     eval(s4);
%     for b = 1:l(1,i)
%         s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,0,''fill'');end'];
%         eval(s2);
%     end
%     eval(s5);
%     for b = 1:l(1,i)
%         s2 = ['if data.anr.a',num2str(i),'(b) == 1 scatter(b*T*fs,60,''fill'');end'];
%         eval(s2);
%     end
%     
% end
Nx = 23;
for i = 1:Nx
    s1 = ['figure(),subplot(211),plot(data.datatr.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
    s3 = ['subplot(212),plot(data.datatr.Sp',num2str(i),'); hold on;grid on;title(''The SpO2 signal of SUBJECT',num2str(i),''');'];
    
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




%% 
%   Here is to show the apnea signals in these 4 channels.
% 
% for i = 1:20:l(2,1)
%     figure(),subplot(411),plot(di.f1(:,i));
%     title('The flow signal of apnea in subject 1');
%     subplot(412),plot(di.Sp1(:,i));
%     title('The SpO2 signal of apnea in subject 1');
%     subplot(413),plot(di.So1(:,i));
%     title('The Sound signal of apnea in subject 1');
%     subplot(414),plot(di.Pul1(:,i));
%     title('The Pulse signal of apnea in subject 1');
% end
% 
% for i = 1:300:l(3,1)
%     figure(),subplot(411),plot(dh.f1(:,i));
%     title('The flow signal of health in subject 1');
%     subplot(412),plot(dh.Sp1(:,i));
%     title('The SpO2 signal of health in subject 1');
%     subplot(413),plot(dh.So1(:,i));
%     title('The Sound signal of health in subject 1');
%     subplot(414),plot(dh.Pul1(:,i));
%     title('The Pulse signal of health in subject 1');
% end





%%
%   Based on the former codes here is to find some features in there
%   channels

% t = [1/(rfs*T):1/(rfs*T):1];
% for i = 1:N
% %     s1 = ['f.h.ms',num2str(i),' = mean(dh.lssp',num2str(i),');'];
% %     s2 = ['f.i.ms',num2str(i),' = mean(di.lssp',num2str(i),');'];
% %     s3 = ['f.h.Sosum',num2str(i),' = sum(dh.So',num2str(i),'.*dh.So',num2str(i),');'];
% %     s4 = ['f.i.Sosum',num2str(i),' = sum(di.So',num2str(i),'.*di.So',num2str(i),');'];
%     s5 = ['f.h.fft',num2str(i),' = abs(fft(dh.lsf',num2str(i),'));'];
%     s6 = ['f.i.fft',num2str(i),' = abs(fft(di.lsf',num2str(i),'));'];
%     s7 = ['f.h.kur',num2str(i),' = kurtosis(f.h.ftk',num2str(i),''');'];
%     s8 = ['f.i.kur',num2str(i),' = kurtosis(f.i.ftk',num2str(i),''');'];
% %     s9 = ['f.h.fps',num2str(i),' = sum(dh.lsf',num2str(i),'.*dh.lsf',num2str(i),');'];
% %     s10 = ['f.i.fps',num2str(i),' = sum(di.lsf',num2str(i),'.*di.lsf',num2str(i),');'];
%     s11 = ['f.h.nl92',num2str(i),'(a) = Findlow(dh.lssp',num2str(i),'(:,a),92);'];
%     s12 = ['f.i.nl92',num2str(i),'(a)= Findlow(di.lssp',num2str(i),'(:,a),92);'];
%     s13 = ['f.h.nl91',num2str(i),'(a) = Findlow(dh.lssp',num2str(i),'(:,a),91);'];
%     s14 = ['f.i.nl91',num2str(i),'(a) = Findlow(di.lssp',num2str(i),'(:,a),91);'];
%     s15 = ['f.h.nl90',num2str(i),'(a) = Findlow(dh.lssp',num2str(i),'(:,a),90);'];
%     s16 = ['f.i.nl90',num2str(i),'(a) = Findlow(di.lssp',num2str(i),'(:,a),90);'];
% %     s17 = ['f.h.mu',num2str(i),'(a,:) = polyfit(t'',dh.lssp',num2str(i),'(:,a),1);'];
% %     s18 = ['f.i.mu',num2str(i),'(a,:) = polyfit(t'',di.lssp',num2str(i),'(:,a),1);'];
%     s19 = ['f.h.msp',num2str(i),' = min(dh.lssp',num2str(i),');'];
%     s20 = ['f.i.msp',num2str(i),' = min(di.lssp',num2str(i),');'];
%     s33 = ['f.h.spstd',num2str(i),' = std(dh.lssp',num2str(i),');'];
%     s34 = ['f.i.spstd',num2str(i),' = std(di.lssp',num2str(i),');'];
%     s35 = ['f.h.fstd',num2str(i),' = std(dh.lsf',num2str(i),');'];
%     s36 = ['f.i.fstd',num2str(i),' = std(di.lsf',num2str(i),');'];
% %     s21 = ['f.h.apsp',num2str(i),'(a) = ApEn(2,0.2*f.h.spstd',num2str(i),'(a),dh.lssp',num2str(i),'(:,a),0);'];
% %     s22 = ['f.i.apsp',num2str(i),'(a) = ApEn(2,0.2*f.i.spstd',num2str(i),'(a),di.lssp',num2str(i),'(:,a),0);'];
%     s37 = ['f.h.apf',num2str(i),'(a) = ApEn(2,0.2*f.h.fstd',num2str(i),'(a),dh.lsf',num2str(i),'(:,a),0);'];
%     s38 = ['f.i.apf',num2str(i),'(a) = ApEn(2,0.2*f.i.fstd',num2str(i),'(a),di.lsf',num2str(i),'(:,a),0);'];
% %     s23 = ['f.h.med',num2str(i),' = median(dh.lssp',num2str(i),');'];
% %     s24 = ['f.i.med',num2str(i),' = median(di.lssp',num2str(i),');'];
% %     s25 = ['f.h.spv',num2str(i),' = var(dh.lssp',num2str(i),');'];
% %     s26 = ['f.i.spv',num2str(i),' = var(di.lssp',num2str(i),');'];
% %     s27 = ['f.h.fmax',num2str(i),' = max(dh.lsf',num2str(i),');'];
% %     s28 = ['f.i.fmax',num2str(i),' = max(di.lsf',num2str(i),');'];
%     s29 = ['f.h.nl93',num2str(i),'(a) = Findlow(dh.lssp',num2str(i),'(:,a),93);'];
%     s30 = ['f.i.nl93',num2str(i),'(a) = Findlow(di.lssp',num2str(i),'(:,a),93);'];
%     s31 = ['f.h.fp15',num2str(i),'(a) = 2*f.h.fft',num2str(i),'(15,a)/sum(f.h.fft',num2str(i),'(:,a));'];
%     s32 = ['f.i.fp15',num2str(i),'(a) = 2*f.i.fft',num2str(i),'(15,a)/sum(f.i.fft',num2str(i),'(:,a));'];
%     s39 = ['f.h.fp16',num2str(i),'(a) = 2*f.h.fft',num2str(i),'(16,a)/sum(f.h.fft',num2str(i),'(:,a));'];
%     s40 = ['f.i.fp16',num2str(i),'(a) = 2*f.i.fft',num2str(i),'(16,a)/sum(f.i.fft',num2str(i),'(:,a));'];
%     s41 = ['f.h.fp17',num2str(i),'(a) = 2*f.h.fft',num2str(i),'(17,a)/sum(f.h.fft',num2str(i),'(:,a));'];
%     s42 = ['f.i.fp17',num2str(i),'(a) = 2*f.i.fft',num2str(i),'(17,a)/sum(f.i.fft',num2str(i),'(:,a));'];
%     s47 = ['f.h.fp18',num2str(i),'(a) = 2*f.h.fft',num2str(i),'(18,a)/sum(f.h.fft',num2str(i),'(:,a));'];
%     s48 = ['f.i.fp18',num2str(i),'(a) = 2*f.i.fft',num2str(i),'(18,a)/sum(f.i.fft',num2str(i),'(:,a));'];
%     s45 = ['f.h.fp19',num2str(i),'(a) = 2*f.h.fft',num2str(i),'(19,a)/sum(f.h.fft',num2str(i),'(:,a));'];
%     s46 = ['f.i.fp19',num2str(i),'(a) = 2*f.i.fft',num2str(i),'(19,a)/sum(f.i.fft',num2str(i),'(:,a));'];
%     s43 = ['f.h.fpsum',num2str(i),'(a) = 2*sum(f.h.fft',num2str(i),'(15:19,a))/sum(f.h.fft',num2str(i),'(:,a));'];
%     s44 = ['f.i.fpsum',num2str(i),'(a) = 2*sum(f.i.fft',num2str(i),'(15:19,a))/sum(f.i.fft',num2str(i),'(:,a));'];
% %     s45 = ['f.h.spps',num2str(i),' = sum(dh.lssp',num2str(i),'.*dh.lssp',num2str(i),');'];
% %     s46 = ['f.i.spps',num2str(i),' = sum(di.lssp',num2str(i),'.*di.lssp',num2str(i),');'];
%     s49 = ['f.h.splp',num2str(i),' = (max(dh.lssp',num2str(i),')-min(dh.lssp',num2str(i),'))./max(dh.lssp',num2str(i),');'];
%     s50 = ['f.i.splp',num2str(i),' = (max(di.lssp',num2str(i),')-min(di.lssp',num2str(i),'))./max(di.lssp',num2str(i),');'];
%     s51 = ['f.h.ftk',num2str(i),' = f.h.fft',num2str(i),'(10:40,:);'];
%     s52 = ['f.i.ftk',num2str(i),' = f.i.fft',num2str(i),'(10:40,:);'];
%     s53 = ['f.h.ftk',num2str(i),' = mapminmax(f.h.ftk',num2str(i),''');'];
%     s54 = ['f.i.ftk',num2str(i),' = mapminmax(f.i.ftk',num2str(i),''');'];
%     s55 = ['f.h.splpm',num2str(i),' = min(dh.lssp',num2str(i),')./mean(dh.lssp',num2str(i),');'];
%     s56 = ['f.i.splpm',num2str(i),' = min(di.lssp',num2str(i),')./mean(di.lssp',num2str(i),');'];
%     s57 = ['f.h.fmap',num2str(i),' = 2*max(f.h.fft',num2str(i),')./sum(f.h.fft',num2str(i),');'];
%     s58 = ['f.i.fmap',num2str(i),' = 2*max(f.i.fft',num2str(i),')./sum(f.i.fft',num2str(i),');'];
%     s59 = ['f.h.nlmean',num2str(i),'(a) = Findlow(dh.lssp',num2str(i),'(:,a),mean(dh.lssp',num2str(i),'));'];
%     s60 = ['f.i.nlmean',num2str(i),'(a) = Findlow(di.lssp',num2str(i),'(:,a),mean(di.lssp',num2str(i),'));'];
%     
% 
%     
%     
% %     eval(s1);
% %     eval(s2);
% %     eval(s3);
% %     eval(s4);
%     eval(s5);
%     eval(s6);
%     eval(s51);
%     eval(s52);
%     eval(s53);
%     eval(s54);
%     eval(s7);
%     eval(s8);
% %     eval(s9);
% %     eval(s10);
%     eval(s19);
%     eval(s20);
% %     eval(s23);
% %     eval(s24);
% %     eval(s25);
% %     eval(s26);
% %     eval(s27);
% %     eval(s28);
%     eval(s33);
%     eval(s34);
%     eval(s35);
%     eval(s36);
% %     eval(s45);
% %     eval(s46);
%     eval(s49);
%     eval(s50);
%     eval(s55);
%     eval(s56);
%     eval(s57);
%     eval(s58);
% 
% 
% 
%     
%     for a = 1:l(3,i)
%         eval(s11);
%         eval(s13);
%         eval(s15);
% %         eval(s17);
% %         eval(s21);
%         eval(s31);
%         eval(s37);
%         eval(s39);
%         eval(s41);
%         eval(s43);
%         eval(s29);
%         eval(s45);
%         eval(s47);
%         eval(s59);
%     end
%     for a = 1:l(2,i)
%         eval(s12);
%         eval(s14);
%         eval(s16);
% %         eval(s18);
%         eval(s32);
% %         eval(s22);
%         eval(s38);
%         eval(s40);
%         eval(s42);
%         eval(s44);
%         eval(s30);
%         eval(s46);
%         eval(s48);
%         eval(s60);
%     end
% end





%%
%   Here is to show whether these features are efficient in recognizing the
%   health and apnea.

% figure(),plot(f.h.ms1);
% hold on;
% plot(f.i.ms1,'r--');
% title('The comparison between health and apnea in ms1');
% figure(),plot(f.h.msp1);
% hold on;
% plot(f.i.msp1,'r--');
% title('The comparison between health and apnea in msp1');
% figure(),plot(f.h.fps1);
% hold on;
% plot(f.i.fps1,'r--');
% title('The comparison between health and apnea in fp1');
% 
% figure(),plot(f.h.med1);
% hold on;
% plot(f.i.med1,'r--');
% title('The comparison between health and apnea in med1');
% figure(),plot(f.h.spv1);
% hold on;
% plot(f.i.spv1,'r--');
% title('The comparison between health and apnea in spv1');
% figure(),plot(f.h.fmax1);
% hold on;
% plot(f.i.fmax1,'r--');
% title('The comparison between health and apnea in fmax1');
% 
% figure(),plot(f.h.nl921);
% hold on;
% plot(f.i.nl921,'r--');
% title('The comparison between health and apnea in nl921');
% figure(),plot(f.h.nl911);
% hold on;
% plot(f.i.nl911,'r--');
% title('The comparison between health and apnea in nl911');
% figure(),plot(f.h.nl901);
% hold on;
% plot(f.i.nl901,'r--');
% title('The comparison between health and apnea in nl901');
% 
% figure(),plot(f.h.mu1(:,1));
% hold on;
% plot(f.i.mu1(:,1),'r--');
% title('The comparison between health and apnea in mu1(:,1)');
% figure(),plot(f.h.mu1(:,2));
% hold on;
% plot(f.i.mu1(:,2),'r--');
% title('The comparison between health and apnea in mu1(:,2)');
% 
% 
% figure(),plot(f.h.fp1);
% hold on;
% plot(f.i.fp1,'r--');
% title('The comparison between health and apnea in fp1');

%%
%   Here is to show some examples of the fft in this dataset.

% figure(),subplot(221),plot(dh.f1(:,200));
% subplot(222),plot(di.f1(:,20));
% subplot(223),plot(f.h.fft1(:,200));
% xlim([0 200]);
% subplot(224),plot(f.i.fft1(:,20));
% xlim([0 200]);




%%   
%   Here is to find some differences in the frequence domain between the
%   healthy set and apnea set.
%   I use some examples to show the differences.

% c = 1;
% for i = 1:60:l(2,1)
%     s1 = ['figure(),subplot(211),plot(dh.d1(:,i));'];
%     s2 = ['subplot(212),plot(f.h.fft1(:,i));title(''H-SUBJECT',num2str(c),''');xlim([0 200]);ylim([0 4000]);'];
%     s3 = ['figure(),subplot(211),plot(di.d1(:,i));'];
%     s4 = ['subplot(212),plot(f.i.fft1(:,i));title(''I-SUBJECT',num2str(c),''');xlim([0 200]);ylim([0 4000]);'];
%     
%     eval(s1);
%     eval(s2);
%     eval(s3);
%     eval(s4);
% end

