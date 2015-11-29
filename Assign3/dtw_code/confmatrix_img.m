function confmatrix_img(m1,m2,m3,p1,p2,p3,s1,s2,s3,k2p)
file='Features\coast\testing\testing.txt';
t1 = importdata(file);
file='Features\forest\testing\testing.txt';
t2 = importdata(file);
file='Features\insidecity\testing\testing.txt';
t3 = importdata(file);



g1_1=density_img(t1,m1,p1,s1);
g1_2=density_img(t1,m2,p2,s2);
g1_3=density_img(t1,m3,p3,s3);

g2_1=density_img(t2,m1,p1,s1);
g2_2=density_img(t2,m2,p2,s2);
g2_3=density_img(t2,m3,p3,s3);


g3_1=density_img(t3,m1,p1,s1);
g3_2=density_img(t3,m2,p2,s2);
g3_3=density_img(t3,m3,p3,s3);


conf=zeros(3);

for i=1:size(g1_1,1)
   if(g1_1(i)>g1_2(i) && g1_1(i)>g1_3(i))
       conf(1,1)=conf(1,1)+1;
   elseif(g1_2(i)>g1_1(i) && g1_2(i)>g1_3(i))
       conf(1,2)=conf(1,2)+1;
   else
       conf(1,3)=conf(1,3)+1;
   end
end
for i=1:size(g2_1,1)
   if(g2_1(i)>g2_2(i) && g2_1(i)>g2_3(i))
       conf(2,1)=conf(2,1)+1;
   elseif(g2_2(i)>g2_1(i) && g2_2(i)>g2_3(i))
       conf(2,2)=conf(2,2)+1;
   else
       conf(2,3)=conf(2,3)+1;
   end
end
for i=1:size(g3_1,1)
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
cnt=cnt/(size(g1_1,1)+size(g2_1,1)+size(g3_1,1));
confmat='Features/confmat1_k';
confmat=strcat(confmat,int2str(k2p));
confmat=strcat(confmat,'.txt');
dlmwrite(confmat,conf,'delimiter',' ');
dlmwrite(confmat,cnt,'-append');
end
