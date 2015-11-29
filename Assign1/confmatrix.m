function confmatrix(files,m1,m2,m3,v1,v2,v3)
fileno=strsplit(files{:},'\');
file=strcat(fileno(1),'\testingClass1.txt');
t1 = importdata(file{:});
file=strcat(fileno(1),'\testingClass2.txt');
t2 = importdata(file{:});
file=strcat(fileno(1),'\testingClass3.txt');
t3 = importdata(file{:});

g1_1=g(t1,m1,v1);
g1_2=g(t1,m2,v2);
g1_3=g(t1,m3,v3);
g2_1=g(t2,m1,v1);
g2_2=g(t2,m2,v2);
g2_3=g(t2,m3,v3);
g3_1=g(t3,m1,v1);
g3_2=g(t3,m2,v2);
g3_3=g(t3,m3,v3);

conf=zeros(3);

for i=1:size(t1,1)
   if(g1_1(i)>g1_2(i) && g1_1(i)>g1_3(i))
       conf(1,1)=conf(1,1)+1;
   elseif(g1_2(i)>g1_1(i) && g1_2(i)>g1_3(i))
       conf(1,2)=conf(1,2)+1;
   else
       conf(1,3)=conf(1,3)+1;
   end
end
for i=1:size(t2,1)
   if(g2_1(i)>g2_2(i) && g2_1(i)>g2_3(i))
       conf(2,1)=conf(2,1)+1;
   elseif(g2_2(i)>g2_1(i) && g2_2(i)>g2_3(i))
       conf(2,2)=conf(2,2)+1;
   else
       conf(2,3)=conf(2,3)+1;
   end
end
for i=1:size(t3,1)
   if(g3_1(i)>g3_2(i) && g3_1(i)>g3_3(i))
       conf(3,1)=conf(3,1)+1;
   elseif(g3_2(i)>g3_1(i) && g3_2(i)>g3_3(i))
       conf(3,2)=conf(3,2)+1;
   else
       conf(3,3)=conf(3,3)+1;
   end
end
cnt=0;
for i=1:size(conf)
    cnt=cnt+conf(i,i);
end
cnt=cnt/(size(t1,1)+size(t2,1)+size(t3,1));
confmat=strcat(files,'_confmat.txt');
dlmwrite(confmat{:},conf,'delimiter',' ');
dlmwrite(confmat{:},cnt,'-append');
end