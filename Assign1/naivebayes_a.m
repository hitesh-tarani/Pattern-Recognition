function naivebayes_a(files,c1,c2,c3)

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

m3=mean(c3);
v3=cov(c3);

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

v_common=(v1+v2+v3)/3;
sum=0;
for i=1:tmp(1)
   sum=sum+v_common(i,i);
end
v_common=sum/tmp(1)*eye(tmp(1));
file=strcat(files,'\naivebayes_a_class_1_2_3');
threeclass(file,c1,c2,c3,m1,m2,m3,v_common,v_common,v_common);

v_common=(v1+v2)/2;
for i=1:tmp(1)
   sum=sum+v_common(i,i);
end
v_common=sum/tmp(1)*eye(tmp(1));
file=strcat(files,'\naivebayes_a_class_1_2');
twoclass(file,c1,c2,m1,m2,v_common,v_common);

v_common=(v3+v2)/2;
for i=1:tmp(1)
   sum=sum+v_common(i,i);
end
v_common=sum/tmp(1)*eye(tmp(1));
file=strcat(files,'\naivebayes_a_class_2_3');
twoclass(file,c2,c3,m2,m3,v_common,v_common);

v_common=(v1+v3)/2;
for i=1:tmp(1)
   sum=sum+v_common(i,i);
end
v_common=sum/tmp(1)*eye(tmp(1));
file=strcat(files,'\naivebayes_a_class_1_3');
twoclass(file,c1,c3,m1,m3,v_common,v_common);

end
