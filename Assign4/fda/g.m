function y=g(x,mean,var)
y=zeros(size(x,1),1);
for j=1:size(x,1)
y(j)=(-(0.5)*(x(j,:)-mean)*((var)^(-1))*(x(j,:)-mean)')-(0.5)*log(det(var))-(size(x,2)/2)*log(2*pi);
end
end