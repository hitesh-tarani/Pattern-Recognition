function res =gamma_znk(xn,pi,mean,var,k) 
pi_k=pi(k);
mean_k=mean(k,:);
var_k=squeeze(var(k,:,:));
den=denom_n(xn,pi,mean,var);
nor=g(xn,mean_k,var_k);
res = pi_k*nor(1)/den;
end