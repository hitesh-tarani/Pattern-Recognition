function res =denom_n(xn,pi,mean,var)
k=size(mean);
k=k(1);
res=0;
for j=1:k
    nor=g(xn,mean(j,:),squeeze(var(j,:,:)));
    res=res+pi(j)*nor(1);
end
end