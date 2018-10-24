i = input('Please input the index of subject you want to OB:');
n = input('Please input the index of the feature you want to OB:');
templ = length(n);
s2 = ['tempan = an.a',num2str(i),';'];
eval(s2);
t1 = find(tempan == 1);
figure();
for k = 1:templ
    s1 = ['fea = f.f',num2str(i),'(n(k),:);'];
    eval(s1);
    
    subplot(templ,1,k),plot(fea);
    tempmean = mean(fea);
    tempmean = repmat(tempmean,[length(t1),1]);
    hold on
    scatter(t1,tempmean,'fill');
    t = ['feature:',num2str(n(k))];
    title(t);
end
