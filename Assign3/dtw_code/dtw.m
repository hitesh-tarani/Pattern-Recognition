% function res =dtw(test,train)
%       res= (dtw1(test,train)+dtw1(train,test))/2;
% end

function res =dtw(test,train)
m=size(train,1);
n=size(test,1);
res1=zeros(m,n);
res1(1,1)=eucliddist(train(1,:),test(1,:));
for i=2:m
    res1(i,1)=res1(i-1,1)+eucliddist(train(i,:),test(1,:));
end

for j=2:n
    res1(1,j)=res1(1,j-1)+eucliddist(train(1,:),test(j,:));
end
 
for i=2:m
    for j=2:n
       res1(i,j)=minim(res1(i-1,j),res1(i-1,j-1),res1(i,j-1))+ eucliddist(train(i,:),test(j,:));
    end
end

res=res1(m,n)/(m*n);

end

