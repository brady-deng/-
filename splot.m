

i = input('Please input the subject number you want to plot:');

Nx = 1;

s1 = ['figure(),subplot(211),plot(ds.t.f',num2str(i),'); hold on;grid on;title(''The flow signal of SUBJECT',num2str(i),''');'];
eval(s1);
% s9193 = ['label = anno.a',num2str(i),';'];
% eval(s9193);
s9193 = ['templabel = ann.a',num2str(i),';'];
eval(s9193);


% [m,n] = size(input_args);
% s9191 = ['ll = length(ds.t.f',num2str(i),');'];
% eval(s9191);
% label = zeros(1,ll);
% for count = 1:length(templabel)
%     label(templabel(count,1)*rfs:templabel(count,2)*rfs) = 1;
% end
% s9192 = ['input_args = ds.t.f',num2str(i),';'];
% eval(s9192);
% temp = diff(input_args);
% 
% z = 1;
% f = 1;
% ac = 1;
% for count = 6:ll-4
%     if temp(count-1)<=0 && temp(count-2)<=0 &&temp(count-3)<=0 &&temp(count-4)<=0 && temp(count-5)<=0 && temp(count)>=0 && temp(count+1)>=0 && temp(count+2)>=0 && temp(count+3)>=0
%         tempz(z) = count;
%         valuez(z) = input_args(count);
%         if label(count) == 1
%             loga(ac) = z;
%             ac = ac+1;
%         end
%         
% %         tempind{i}(c) = count;
% %         tempans(c) = input_args(count);
%         z = z+1;
%     end
%     if temp(count-1)>=0 &&temp(count-2)>=0  &&temp(count-3)>=0 &&temp(count-4)>=0 && temp(count-5)>=0 && temp(count)<=0&& temp(count+1)<=0 && temp(count+2)<=0 && temp(count+3)<=0
% %         tempind{i}(c) = count;
% %         tempans(c) = input_args(count);
%         tempf(f) = count;
%         valuef(f) = input_args(count);
%         if label(count) == 1
%             loga(ac) = z;
%             ac = ac+1;
%         end
%         f = f+1;
%     end
% end
% subplot(312),plot(valuez);
% hold on;
% plot(valuef);
% 
% for b = 1:length(loga)
%     s2 = ['subplot(312),scatter(loga(b),0,''fill'');'];
% %     s951 = ['subplot(312),scatter(b,0,''d'',''fill'');end'];
%     eval(s2);
% %     eval(s951);
% end

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


