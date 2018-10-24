
input_args = input('Please input the feature you want to analyze:');

s1 = ['ans(1,1) = mean(f.h.',input_args,');'];
s2 = ['ans(1,2) = std(f.h.',input_args,');'];
s3 = ['ans(1,3) = mean(f.i.',input_args,');'];
s4 = ['ans(1,4) = std(f.i.',input_args,');'];

eval(s1);
eval(s2);
eval(s3);
eval(s4);

disp('mean_h:');
disp(ans(1,1));
disp('std_h:');
disp(ans(1,2));
disp('mean_i');
disp(ans(1,3));
disp('std_i:');
disp(ans(1,4));