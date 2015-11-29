clear

c1=importdata('Spiral\trainingClass1.txt');
c2=importdata('Spiral\trainingClass2.txt');

k= 15;
[m1 p1 s1] = code(c1,k);
dis='class1'

[m2 p2 s2] = code(c2,k);
dis='class2'

dis='done em'
y=range_2(c1,c2);

minx=y(1,1);
miny=y(1,2);

maxx=y(2,1);
maxy=y(2,2);

precx=y(3,1);
precy=y(3,2);


cnt=1;

for i=minx:precx:maxx
    for j=miny:precy:maxy
        testgrid(cnt,1)=i;
        testgrid(cnt,2)=j;
        cnt=cnt+1;
    end
end

cnt=cnt-1;



g1=density(testgrid,m1,p1,s1);
g2=density(testgrid,m2,p2,s2);




%range = 0.000001;
j1=1;
j2=1;
j3=1;
j4=1;
for i=1:cnt
    
  if((g1(i)> g2(i)))
      data1(j1,1)=testgrid(i,1);
      data1(j1,2)=testgrid(i,2);
      j1=j1+1;
  end
  if((g2(i)> g1(i)))
      data2(j2,1)=testgrid(i,1);
      data2(j2,2)=testgrid(i,2);
      j2=j2+1;
  end
  
end

%confmatrix(files,m1,m2,m3,v1,v2,v3);
%a=strsplit(files,'\');
%Data=strcat(files,'.png');
%f=figure('visible','on');


scatter(data1(:,1),data1(:,2));
hold

scatter(data2(:,1),data2(:,2));

scatter(c1(:,1),c1(:,2));

scatter(c2(:,1),c2(:,2));
%saveas(f,Data{:});
hold

