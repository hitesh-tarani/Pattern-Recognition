function y=density(x,mean,pi,sigma)
y=zeros(size(x,1),1);
    for j=1:size(x,1)
        y(j,1)=denom_n(x(j,:),pi,mean,sigma);
    end
end
