function bayes_a1_2(files,c1,c2)
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

v_common=(v1+v2)/2;
file=strcat(files,'\bayes_a1');
twoclass(file,c1,c2,m1,m2,v_common,v_common);
end
