
input_args = input('Please input the feature you want to plot:');

s1 = ['figure(),plot(f.h.',input_args,');hold on;plot(f.i.',input_args,',''r--'');title(''The comparison in feature ',input_args,'.'');'];
eval(s1);