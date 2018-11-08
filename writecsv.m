function temp = writecsv( data,featurename,N )
%%A script for writing the data into a csv file
%   Detailed explanation goes here
%     N = 23;
if N == 0
    N = 23;
    l = ones(N,2);
    name = 'feature';
    label = 'label';
%     temp = [];
    for i = 1:N
        temp = [];
        s1 = ['l(i,:) = size(data.f.f',num2str(i),');'];
        s3 = [label,num2str(i),'= data.an.a',num2str(i),';'];
        eval(s1);
        eval(s3);
        s1105 = ['timeind',num2str(i),' = data.ind_time.i',num2str(i),''';'];
        eval(s1105);
        
        for count = 1:l(i,1)
            s2 = [name,num2str(count),'=data.f.f',num2str(i),'(count,:);'];
            s5 = ['feature',num2str(count),' = feature',num2str(count),''';'];
            temp = [temp,name,num2str(count),','];
            eval(s2);
            eval(s5);
        end
        temp = [temp,label,num2str(i),',timeind',num2str(i)];
%         temp(end) = [];
        s4 = ['T = table(',temp,');'];
        eval(s4);
        filename = [featurename,'.xlsx'];
        writetable(T,filename,'Sheet',num2str(i))
        
    end
else
    l = ones(N,2);
    name = 'feature';
    label = 'label';
    temp = [];
    
    
    s1 = ['l = size(data.f.f',num2str(N),');'];
    s3 = ['label',num2str(N),'= data.an.a',num2str(N),';'];
    eval(s1);
    eval(s3);
    s1105 = ['timeind',num2str(N),' = data.ind_time.i',num2str(N),''';'];
    eval(s1105);

    for count = 1:l
        s2 = [name,num2str(count),'=data.f.f',num2str(N),'(count,:);'];
        s5 = ['feature',num2str(count),' = feature',num2str(count),''';'];
        temp = [temp,name,num2str(count),','];
        eval(s2);
        eval(s5);
    end
    temp = [temp,label,num2str(N),',timeind',num2str(N)];
%     temp = [temp,timeind];
%         temp(end) = [];

    s4 = ['T = table(',temp,');'];
    eval(s4);
    filename = [featurename,'.xlsx']
    writetable(T,filename,'Sheet',num2str(N))
end


            

end

