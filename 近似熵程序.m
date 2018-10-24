clear all
x = [1:100];
n=length(x)
sd=std(x)
r=0.2*sd
for ii=1:2
m=ii+1;
num=zeros(n-m+1,1);
for i=1:n-m+1
for j=1:n-m+1
if j~=i
for k=1:m
d(k)=abs(x(i+k-1)-x(j+k-1));
end
d1=max(d);
if d1<r
num(i,1)=num(i,1)+1;
end 
end
end
c0(i)=num(i,1)/(n-m);
c1(i)=log(c0(i));
end
sc=sum(c1);
fi(ii)=sc/(n-m+1);
end
app=fi(1)-fi(2);
