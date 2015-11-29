function y=density_img(x,mean,pi,sigma)
    cnt=1;
    for i=1:(size(x,1)/36)
        tmp=density(x(cnt:cnt+35,:),mean,pi,sigma);
        tmp=prod(log(tmp));
        y(i,1)=tmp;
		cnt=cnt+36;
    end

end
