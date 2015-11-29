function res =new_pi_k(data,gamma_zk)
n=size(data);
n=n(1);

tmp2=0;

for i=1:n
    tmp2=tmp2+gamma_zk(i);
end

res=tmp2/n;

end

