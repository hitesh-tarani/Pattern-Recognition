function min=minim(x,y,z)
if(x<=y && x<=z)
       min=x;
   elseif(y<=z)
       min=y;
   else
      min=z;
end
end
