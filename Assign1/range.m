function y=range(d1,d2,d3)
m1=max(d1);
m2=max(d2);
m3=max(d3);
ma=max([m1;m2;m3]);

m1=min(d1);
m2=min(d2);
m3=min(d3);
mi=min([m1;m2;m3]);

rx=(ma(1)-mi(1))/200;

ry=(ma(2)-mi(2))/200;

r(1)=rx;
r(2)=ry;
y=[mi;ma;r];

end


