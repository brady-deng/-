%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AHI 估计
%9.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all;
clc;


model = load('model.mat');
feaname = input('Please input the feature name you want to classify:');
s1 = ['d = importdata(''E:\文档\MATLAB程序\ucd-process\UCD Sleep Apnea Database\数据\',feaname,'.mat'');'];
eval(s1); 
N = 23;
% temp3 = [1,2,3,5,6,10,11,15,16,17,18];
% for i = 1:N
%     s1 = ['d.f.f',num2str(i),'(temp3,:) = [];'];
%     eval(s1);
% end
% temp3 = [1,4,5,6];
% for i = 1:N
%     s1 = ['d.f.f',num2str(i),'(temp3,:) = [];'];
%     eval(s1);
% end

% for i = 1:N
%     s1 = ['data{i} = d.f.f',num2str(i),''';'];
%     eval(s1);
%     l(i) = length(data{i}(:,1));
%     rec{i} = zeros(500,10);
% end
%         
% 
parfor i = 1:N
    pt{i} = svmclassify(model.ssave{i}{1},data{i})
end
for i = 1:N
    count = 1;
    for acount = 2:l(i)
        if pt{i}(acount) == 1&&pt{i}(acount-1) == 0
            temp_start = acount;
        end
        if pt{i}(acount) == 0&&pt{i}(acount-1) == 1
            temp_end = acount;
            
            if temp_end-temp_start<7
                continue
                
            end
            rec{i}(count,1) = temp_start;
            rec{i}(count,2) = temp_end;
            rec{i}(count,3) = rec{i}(count,2)-rec{i}(count,1);
            count = count+1;
        end
    end
      s1 = ['ahi(i) = length(rec{i}(:,1))/((length(d.an.a',num2str(i),')+60)/3600);'];
      eval(s1);
end
% for i = 1:N
%     s1 = ['pt{i} = d.an.a',num2str(i),';'];
%     eval(s1);
%     count = 1;
%     for acount = 2:l(i)
%         if pt{i}(acount) == 1&&pt{i}(acount-1) == 0
%             temp_start = acount;
%         end
%         if pt{i}(acount) == 0&&pt{i}(acount-1) == 1
%             temp_end = acount;
%             
% %             if temp_end-temp_start<5
% %                 continue
% %                 
% %             end
%             orec{i}(count,1) = temp_start;
%             orec{i}(count,2) = temp_end;
%             orec{i}(count,3) = orec{i}(count,2)-orec{i}(count,1);
%             count = count+1;
%         end
%     end
%     s1 = ['ahi(i) = length(orec{i}(:,1))/((length(d.an.a',num2str(i),')+60)/3600);'];
%     eval(s1);
% end