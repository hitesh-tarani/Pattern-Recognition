clear
no_of_classes=3;
c(no_of_classes).data=0;

files='image';
file='../image/';
class1(1).file='coast';
class1(2).file='forest';
class1(3).file='insidecity';

% files='RD';
% file='../RD_Group12/';
% class1(1).file='Class1';
% class1(2).file='Class2';
% class1(3).file='Class3';

% trainclass(1,:)=strcat(file,'/coast/training/concat.dt');
for i=1:no_of_classes
    trainclass(i).data=importdata(strcat(file,class1(i).file,'/training/concat.dt'));
    testclass(i).data=importdata(strcat(file,class1(i).file,'/testing/concat.dt'));
%     trainclass(i).data=importdata(strcat(file,'training',class1(i).file,'.txt'));
%     testclass(i).data=importdata(strcat(file,'testing',class1(i).file,'.txt'));
end
total=[trainclass(1).data;trainclass(2).data;trainclass(3).data;testclass(1).data;testclass(2).data;testclass(3).data];
[V,D]=eig(cov(total));
X=diag(D);
[D,I]=sort(X,'descend');
l=16;
for x=1:l
    for i=1:no_of_classes
        modtrain(i).data(:,x)=trainclass(i).data*V(:,I(x));
        modtest(i).data(:,x)=testclass(i).data*V(:,I(x));
    end
end
for i=1:no_of_classes
    confmat=strcat(files,'_training',class1(i).file,'.txt');
    dlmwrite(confmat,modtrain(i).data,'delimiter',' ');
    confmat=strcat(files,'_testing',class1(i).file,'.txt');
    dlmwrite(confmat,modtest(i).data,'delimiter',' ');
    k=3;
    [modtrain(i).m, modtrain(i).p, modtrain(i).v]=code(modtrain(i).data,k);
end

t1=modtest(1).data;
t2=modtest(2).data;
t3=modtest(3).data;
m1=modtrain(1).m;
m2=modtrain(2).m;
m3=modtrain(3).m;
p1=modtrain(1).p;
p2=modtrain(2).p;
p3=modtrain(3).p;
s1=modtrain(1).v;
s2=modtrain(2).v;
s3=modtrain(3).v;

g1_1=density(t1,m1,p1,s1);
g1_2=density(t1,m2,p2,s2);
g1_3=density(t1,m3,p3,s3);
g2_1=density(t2,m1,p1,s1);
g2_2=density(t2,m2,p2,s2);
g2_3=density(t2,m3,p3,s3);
g3_1=density(t3,m1,p1,s1);
g3_2=density(t3,m2,p2,s2);
g3_3=density(t3,m3,p3,s3);

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
% file1=strsplit(file,'/');
confmat=strcat(files,'_multi_l_',num2str(l),'_k_',num2str(k),'_confmat.txt');
dlmwrite(confmat,conf,'delimiter',' ');
dlmwrite(confmat,cnt,'-append');
% threeclass(file,modtrain(1).data,modtrain(2).data,modtrain(3).data,modtrain(1).m,modtrain(2).m,modtrain(3).m,modtrain(1).v,modtrain(2).v,modtrain(3).v);
% confmatrix(file,modtrain(1).m,modtrain(2).m,modtrain(3).m,modtrain(1).v,modtrain(2).v,modtrain(3).v);