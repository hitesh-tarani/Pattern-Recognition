function y=g(x,mean,var)
q=size(x,2);
y=zeros(size(x,1),1);

for j=1:size(x,1)
    y(j,1)=exp((-(0.5)*(x(j,:)-mean)*((var)^(-1))*(x(j,:)-mean)')-(0.5)*log(det(var))-(q/2)*log(2*pi));
    
end
end