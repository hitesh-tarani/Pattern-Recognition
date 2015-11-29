function boolval=error_gamma(old_gamma,gamma)
boolval=true;
error=0.001;
s=size(gamma);
temp=gamma-old_gamma;
for i=1:s(1)
    for j=1:s(2)
        if(temp(i,j)>=error)
            boolval=false;
            break;
        end
    end
    if(boolval==false)
        break;
    end
end

