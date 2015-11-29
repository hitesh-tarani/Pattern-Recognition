function bayes_b(files,c1,c2,c3)

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

file=strcat(files,'\bayes_b_class_1_2_3');
threeclass(file,c1,c2,c3,m1,m2,m3,v1,v2,v3);
file=strcat(files,'\bayes_b_class_1_2');
twoclass(file,c1,c2,m1,m2,v1,v2);
file=strcat(files,'\bayes_b_class_2_3');
twoclass(file,c2,c3,m2,m3,v2,v3);
file=strcat(files,'\bayes_b_class_1_3');
twoclass(file,c1,c3,m1,m3,v1,v3);

end
