function res =new_mean_k(data,gamma_zk)
n=size(data);
s=n(2);
n=n(1);

tmp=zeros(1,s);
for i=1:n
    tmp=tmp+gamma_zk(i)*data(i,:);
end

tmp2=0;

for i=1:n
    tmp2=tmp2+gamma_zk(i);
end

res=tmp/tmp2;

end

