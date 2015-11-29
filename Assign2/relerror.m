function boolval=relerror(a,b,diff,k)
   boolval=false;
   error=0.001;
   
   diff1=eucliddist(diff,zeros(1,size(diff,2)));
   for i=1:k
       if((eucliddist(a(1,:),b(1,:))/diff1<error))
           boolval=true;
           break;
       end
   end
end