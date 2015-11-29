function twoclass(files,c1,c2,m1,m2,v1,v2)

y=range_2(c1,c2);

minx=y(1,1);
% miny=y(1,2);

maxx=y(2,1);
% maxy=y(2,2);

precx=y(3,1);
% precy=y(3,2);


cnt=1;

for i=minx:precx:maxx
    testgrid(cnt,1)=i;
    cnt=cnt+1;
end


cnt=cnt-1;

g1=g(testgrid,m1,v1);
g2=g(testgrid,m2,v2);

g12=g1-g2;

%range = 0.000001;
j1=1;
j2=1;

for i=1:cnt
    
  if((g1(i)> g2(i)))
      data1(j1,1)=testgrid(i,1);
      j1=j1+1;
  else
      data2(j2,1)=testgrid(i,1);
      j2=j2+1;
  end
end

% confmatrix_2(files,m1,m2,v1,v2);
%a=strsplit(files,'\');
Data=strcat(files,'.png');
f=figure('visible','on');


% scatter(data1(:,1),ones(size(data1(:,1),1),1));
hold

% scatter(data2(:,1),ones(size(data2(:,1),1),1));

scatter(c1(:,1),ones(size(c1(:,1),1),1));

scatter(c2(:,1),ones(size(c2(:,1),1),1));
saveas(f,Data);
hold
clear

end
