function y=range_2(d1,d2)
m1=max(d1);
m2=max(d2);
ma=max([m1;m2]);

m1=min(d1);
m2=min(d2);
mi=min([m1;m2]);

rx=(ma(1)-mi(1))/100;

ry=(ma(2)-mi(2))/100;

r(1)=rx;
r(2)=ry;
y=[mi;ma;r];

end

