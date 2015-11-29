function confmatrix_2(files,m1,m2,v1,v2)
fileno=strsplit(files{:},'\');
file=strcat(fileno(1),'\testingClass1.txt');
t1 = importdata(file{:});
file=strcat(fileno(1),'\testingClass2.txt');
t2 = importdata(file{:});

g1_1=g(t1,m1,v1);
g1_2=g(t1,m2,v2);
g2_1=g(t2,m1,v1);
g2_2=g(t2,m2,v2);
conf=zeros(2);

for i=1:size(t1,1)
   if(g1_1(i)>g1_2(i))
       conf(1,1)=conf(1,1)+1;
   else
       conf(1,2)=conf(1,2)+1;
   end
end
for i=1:size(t2,1)
   if(g2_1(i)>g2_2(i))
       conf(2,1)=conf(2,1)+1;
   else
       conf(2,2)=conf(2,2)+1;
   end
end
cnt=0;
for i=1:size(conf)
    cnt=cnt+conf(i,i);
end
cnt=cnt/(size(t1,1)+size(t2,1));
confmat=strcat(files,'_confmat.txt');
dlmwrite(confmat{:},conf,'delimiter',' ');
dlmwrite(confmat{:},cnt,'-append');
end