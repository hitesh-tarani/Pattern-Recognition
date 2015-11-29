function naivebayes_c_2(files,c1,c2)

%clear
%files='LS_Group12';
% file=strcat(files,'\trainingClass1.txt');
% c1 = importdata(file);
% file=strcat(files,'\trainingClass2.txt');
% c2 = importdata(file);
% file=strcat(files,'\trainingClass3.txt');
% c3 = importdata(file);

m1=mean(c1);
v1=cov(c1);

m2=mean(c2);
v2=cov(c2);

tmp=size(v1);

for i=1:tmp(1)
    for j=1:tmp(1)
        if(i~=j)
            v1(i,j)=0;
            v2(i,j)=0;
            v3(i,j)=0;
            
        end
    end
end

file=strcat(files,'\naivebayes_c');
twoclass(file,c1,c2,m1,m2,v1,v2);
end
