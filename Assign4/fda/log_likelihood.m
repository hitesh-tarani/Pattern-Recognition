function y=log_likelihood(x,mean,pi,sigma)
d=density(x,mean,pi,sigma);
d=log(d);
y=sum(d);
end
