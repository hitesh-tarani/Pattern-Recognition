
T=36;N=4;
beta=zeros(N,T);
beta(:,T)=1;

for t=T-1:1
    x=A(:,:)*beta(:,t+1);
    beta(:,t)=bsxfun(@times,B(:,b(t)),x);
end
