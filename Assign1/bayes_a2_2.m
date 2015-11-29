function bayes_a2_2(files,c1,c2)

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

c=[c1;c2];
v_common=cov(c);
file=strcat(files,'\bayes_a2');
twoclass(file,c1,c2,m1,m2,v_common,v_common);

end
