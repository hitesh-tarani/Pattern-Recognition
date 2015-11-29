
T=36;N=4;
alpha=zeros(N,T);
alpha(:,1)=pi(1)*B(:,b(1)); 

for t=2:T
    x=alpha(:,t-1)'*A(:,:);
    alpha(:,t)=bsxfun(@times,x',B(:,b(t)));
end
