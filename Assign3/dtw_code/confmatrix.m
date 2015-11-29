function confmatrix(imgtest,loc,k1,inc,k2)
cnt=1;
for k=k1:inc:k2
conf=zeros(3);

for i=1:size(imgtest,2)
    conf(imgtest(i).class,imgtest(i).alotclass(cnt))=conf(imgtest(i).class,imgtest(i).alotclass(cnt))+1;
end
cnt1=0;
for i=1:size(conf)
    cnt1=cnt1+conf(i,i);
end
cnt1=cnt1/size(imgtest,2);
dlmwrite(strcat(loc,int2str(k)),conf,'delimiter',' ');
dlmwrite(strcat(loc,int2str(k)),cnt1,'-append');
cnt=cnt+1;
end
end