myzeta=zeros(T,N,N);
gamma=zeros(T,N);
for l=1:L
% calc alpha, beta, Observation
   for t=1:T-1
    zetanum(t,:,:)=bsxfun(@times,alpha(:,t),bsxfun(@times,A(:,:),bsxfun(@times,B(:,b(t+1)),beta(:,t+1))'));
  end
  for t=1:T-1
    zetadenum(t)=sum(sum(squeeze(zetanum(t,:,:)))');
  end
  for t=1:T-1
    zetatemp(t,:,:)=zetanum(t,:,:)/zetadenum(t);
  end
  for t=1:T-1
    gammatemp(t,i)=sum(squeeze(zeta(t,:,:))');
  end
myzeta=myzeta+zetatemp;
gamma=gamma+gammatemp;
end

pi(:)=gamma(1,:)/L;

for i=1:N
  for j=1:N
    A(i,j)=sum(zetamy(:,i,j))/sum(gamma(:,i));
  end
end

for j=1:N
  for v=1:T
    num=0;
    for t=1:T
      if(b(t)==v)
        num = num + gamma(t,j); 
      end 
    end
    B(j,v)=num/sum(gamma(:,j));
  end
end

probability=sum(alpha(T,:));
for l=1:L
   % recalculate probability with alpha for the given data ie with alpha(l)
    likelihood=likelihood*probability;
end

% hitesh i assumed that alpha's for all the data are given which i think is a problem? 