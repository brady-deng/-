function [ sample ] = mySMOTE( minority,radio,k,attr_type )
% [ sample ] = mySMOTE( minority,radio,k,attr_type )
%minority:少数样本，不包括属性值
%radio：生成新样本占少数样本的比例
%k: 近邻个数
%attr_type：属性类型，0：连续；1：离散
%sample：输出新样本
if(nargin<2)%nargin 函数输入变量个数
    help mySOMTE
elseif(nargin<3)
    radio=1;
    k=1;
    attr_type=zeros(1,size(minority,2));
end

[minority_num,attr_num]=size(minority);%少数样本个数
if radio<=0
%warning('radio=%d',radio,'is less than 0');
%return
 error('radio is less than 0');
elseif radio<1
    new_num=floor(radio*minority_num);
    sample_index=randperm(minority_num,new_num);%随机产生
    radio=1;
else
    radio=round(radio);
    sample_index=1:minority_num;    
end
%距离矩阵
distance_matrix=dist(minority');%欧式距离
sample_num= size(sample_index,2)*radio;
sample=zeros(sample_num,attr_num);
 for i=1: size(sample_index,2)
    k_nearest_index= find_k_nearest(sample_index(i),k,distance_matrix);
    nn=randperm(k,1) ;%随机选取一个近邻
    n_index=k_nearest_index(nn);%近邻样本的索引
    for r=1:radio
     for j=1:attr_num
         if attr_type(j)==0%numeric
           dif=minority(n_index,j)-minority(i,j);
           gap=rand(1,1);
           sample(radio*(i-1)+r,j)=minority(i,j)+dif*gap;
         else
             for kk=1:k
                 attribute(kk)=minority(k_nearest_index(kk),j);             
             end
             table = tabulate(attribute);%统计前k个样本在改属性上的分布
             [attr_j_num,index]=max(table(:,2));%出现次数最多的属性所在的行
             attr_j=table(index,1);%赋值
            sample(radio*(i-1)+r,j)= minority(i,j);%把前k个占多数的属性值赋给它
         end
             
      end
   end
 end
end

function [k_nearest_index]=find_k_nearest(sample_index,k,distance_matrix)
[distance,index]=sort(distance_matrix(:,sample_index));%排列
k_nearest_index=index(2:k+1,1);%返回前k行
end
