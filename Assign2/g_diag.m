function y=g(x,mean,var)
var=diag(diag(var));
y=zeros(size(x,1),1);
for j=1:size(x,1)
    y(j,1)=exp((-(0.5)*(x(j,:)-mean)*((var)^(-1))*(x(j,:)-mean)')-(0.5)*log(det(var))-(2/2)*log(2*pi));
    
end
end