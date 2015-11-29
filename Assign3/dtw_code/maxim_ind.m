function max=maxim_ind(c)
x=c(1);
y=c(2);
z=c(3);

if(x>=y && x>=z)
       max=1;
   elseif(y>=z)
       max=2;
   else
      max=3;
end
end
