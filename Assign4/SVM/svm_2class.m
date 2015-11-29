clear

class1=importdata('../interlock/trainingClass1.txt');
class2=importdata('../interlock/trainingClass2.txt');
save='Interlock_RBF_confmat.txt';
newclass1=importdata('../interlock/testingClass1.txt');
newclass2=importdata('../interlock/testingClass2.txt');

X=[class1;class2];
newX=[newclass1;newclass2];

y1=ones(size(class1,1),1);
y2=2*ones(size(class2,1),1);

Y=[y1;y2];

SVMmodel=fitcsvm(X,Y,'GapTolerance',0,'Standardize','on','KernelFunction','RBF');
SVMmodel = fitPosterior(SVMmodel);

[label,score] = predict(SVMmodel,newX);

confmat=zeros(2);
for i=1:size(newclass1,1)
   if(label(i)==1)
      confmat(1,1)=confmat(1,1)+1; 
   else
      confmat(1,2)=confmat(1,2)+1;       
   end
end

for i=i+1:size(label,1)
   if(label(i)==2)
      confmat(2,2)=confmat(2,2)+1; 
   else
      confmat(2,1)=confmat(2,1)+1;       
   end
end

accuracy=confmat(1,1)+confmat(2,2);
accuracy=accuracy/(size(newclass1,1)+size(newclass2,1));

dlmwrite(save,confmat,'delimiter',' ');
dlmwrite(save,accuracy,'-append');