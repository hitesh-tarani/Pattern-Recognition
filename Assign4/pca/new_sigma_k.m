function res =new_sigma_k(data,gamma_zk,mean_k)
q=size(data);
n=q(1);
s=q(2);

tmp=zeros(s,s);
for i=1:n
    tmp=tmp+gamma_zk(i)*((data(i,:)-mean_k)'*(data(i,:)-mean_k));
end

tmp2=0;

for i=1:n
    tmp2=tmp2+gamma_zk(i);
end

res=tmp/tmp2;

end

