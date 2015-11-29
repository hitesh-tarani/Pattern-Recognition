function bayes_a2(files,c1,c2,c3)

%clear
%files='LS_Group12';
% file=strcat(files,'\trainingClass1.txt');
% c1 = importdata(file);
% file=strcat(files,'\trainingClass2.txt');
% c2 = importdata(file);
% file=strcat(files,'\trainingClass3.txt');
% c3 = importdata(file);

m1=mean(c1);

m2=mean(c2);

m3=mean(c3);

c=[c1;c2;c3];
v_common=cov(c);
file=strcat(files,'\bayes_a2_class_1_2_3');
threeclass(file,c1,c2,c3,m1,m2,m3,v_common,v_common,v_common);

c=[c1;c2];
v_common=cov(c);
file=strcat(files,'\bayes_a2_class_1_2');
twoclass(file,c1,c2,m1,m2,v_common,v_common);

c=[c2;c3];
v_common=cov(c);
file=strcat(files,'\bayes_a2_class_2_3');
twoclass(file,c2,c3,m2,m3,v_common,v_common);

c=[c1;c3];
v_common=cov(c);
file=strcat(files,'\bayes_a2_class_1_3');
twoclass(file,c1,c3,m1,m3,v_common,v_common);

end
