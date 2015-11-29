clear

class1=importdata('../pca/image_trainingcoast.txt');
class2=importdata('../pca/image_trainingforest.txt');
class3=importdata('../pca/image_traininginsidecity.txt');
save='Image_PCA_confmat.txt';

newclass1=importdata('../pca/image_testingcoast.txt');
newclass2=importdata('../pca/image_testingforest.txt');
newclass3=importdata('../pca/image_testinginsidecity.txt');

X12=[class1;class2];
X23=[class2;class3];
X31=[class3;class1];
newX=[newclass1;newclass2;newclass3];

y1=ones(size(class1,1),1);
y2=2*ones(size(class2,1),1);
y3=3*ones(size(class3,1),1);
Y12=[y1;y2];
Y23=[y2;y3];
Y31=[y3;y1];

SVMmodel_12=fitcsvm(X12,Y12,'Standardize','on','KernelFunction','linear');
SVMmodel_23=fitcsvm(X23,Y23,'Standardize','on','KernelFunction','linear');
SVMmodel_31=fitcsvm(X31,Y31,'Standardize','on','KernelFunction','linear');
SVMmodel_12 = fitPosterior(SVMmodel_12);
SVMmodel_23 = fitPosterior(SVMmodel_23);
SVMmodel_31 = fitPosterior(SVMmodel_31);

[label_12,score_12] = predict(SVMmodel_12,newX);
[label_23,score_23] = predict(SVMmodel_23,newX);
[label_31,score_31] = predict(SVMmodel_31,newX);

score_123=zeros(size(newX,1),3);
label_final=zeros(size(newX,1),1);
for i=1:size(newX,1)
   score_123(i,1)=score_12(i,1)+score_31(i,1);
   score_123(i,2)=score_12(i,2)+score_23(i,1);
   score_123(i,3)=score_23(i,2)+score_31(i,2);
   [M,I]=max(score_123(i,:));
   label_final(i)=I;
end

confmat=zeros(3);
for i=1:size(newclass1,1)
   if(label_final(i)==1)
      confmat(1,1)=confmat(1,1)+1; 
   elseif(label_final(i)==2)
      confmat(1,2)=confmat(1,2)+1; 
   else
      confmat(1,3)=confmat(1,3)+1;
   end
end

for i=i+1:i+size(newclass2,1)
   if(label_final(i)==2)
      confmat(2,2)=confmat(2,2)+1; 
   elseif(label_final(i)==1)
      confmat(2,1)=confmat(2,1)+1; 
   else
      confmat(2,3)=confmat(2,3)+1;
   end
end

for i=i+1:i+size(newclass3,1)
   if(label_final(i)==3)
      confmat(3,3)=confmat(3,3)+1; 
   elseif(label_final(i)==1)
      confmat(3,1)=confmat(3,1)+1; 
   else
      confmat(3,2)=confmat(3,2)+1;
   end
end

accuracy=confmat(1,1)+confmat(2,2)+confmat(3,3);
accuracy=accuracy/(size(newclass1,1)+size(newclass2,1)+size(newclass3,1));

dlmwrite(save,confmat,'delimiter',' ');
dlmwrite(save,accuracy,'-append');