clear
no_of_classes=3;
c(no_of_classes).data=0;
files='RD';
file='../RD_Group12/';
% file='../image/';

% class1(1).file='coast';
% class1(2).file='forest';
% class1(3).file='insidecity';
class1(1).file='Class1';
class1(2).file='Class2';
class1(3).file='Class3';

% trainclass(1,:)=strcat(file,'/coast/training/concat.dt');
for i=1:no_of_classes
%     trainclass(i).file=strcat(file,class1(i).file,'/training/concat.dt');
    trainclass(i).file=strcat(file,'training',class1(i).file,'.txt');
end
for i=1:no_of_classes
    c(i).data=importdata(trainclass(i).file);
    c(i).m=mean(c(i).data);
    c(i).s=size(c(i).data,1)*cov(c(i).data);
end
class(3,3).w=0;
class(3,3).m=0;
class(3,3).v=0;
for i=1:no_of_classes-1
    for j=i+1:no_of_classes
        sw=c(i).s+c(j).s;
        det(sw)
        w=sw^-1*(c(i).m-c(j).m)';
        class(i,j).w=w;
        newdata1=c(i).data*w;
        newdata2=c(j).data*w;
        twoclass(strcat(files,num2str(i),num2str(j)),newdata1,newdata2,mean(newdata1),mean(newdata2),cov(newdata1),cov(newdata2));
        class(i,j).m(1)=mean(newdata1);
        %         class(i,j).data(1)=class(j,i);
        class(i,j).v(1)=cov(newdata1);
        %         class(i,j).v(1)=v1(j,i);
        class(i,j).m(2)=mean(newdata2);
        %         class(i,j).data(2)=class(j,i);
        class(i,j).v(2)=cov(newdata2);
        %         class(i,j).v(2)=v1(j,i);
    end
end
confmat=zeros(3,3);
for i=1:no_of_classes
    testdata=importdata(strcat(file,'testing',class1(i).file,'.txt'));
%     testdata=importdata(strcat(file,class1(i).file,'/testing/concat.dt'));
    
    g_testdata1_1=g(testdata*class(1,2).w,class(1,2).m(1),class(1,2).v(1));
    g_testdata1_2=g(testdata*class(1,2).w,class(1,2).m(2),class(1,2).v(2));
    g_testdata2_1=g(testdata*class(1,3).w,class(1,3).m(1),class(1,3).v(1));
    g_testdata2_3=g(testdata*class(1,3).w,class(1,3).m(2),class(1,3).v(2));
    g_testdata3_2=g(testdata*class(2,3).w,class(2,3).m(1),class(2,3).v(1));
    g_testdata3_3=g(testdata*class(2,3).w,class(2,3).m(2),class(2,3).v(2));
    for x=1:size(testdata,1)
        count1=g_testdata1_1(x)+g_testdata2_1(x);
        count2=g_testdata1_2(x)+g_testdata3_2(x);
        count3=g_testdata2_3(x)+g_testdata3_3(x);
%         if(g_testdata1_1(x)>g_testdata1_2(x))
%             count1=count1+1;
%         else
%             count2=count2+1;
%         end
%         if(g_testdata2_1(x)>g_testdata2_3(x))
%             count1=count1+1;
%         else
%             count3=count3+1;
%         end
%         if(g_testdata3_2(x)>g_testdata3_3(x))
%             count2=count2+1;
%         else
%             count3=count3+1;
%         end
        if(count1>count2&&count1>count3)
            confmat(i,1)=confmat(i,1)+1;
        elseif(count2>count1&&count2>count3)
            confmat(i,2)=confmat(i,2)+1;
        else
            confmat(i,3)=confmat(i,3)+1;
        end
    end
end
% for i=1:no_of_classes-1
%     for j=i+1:no_of_classes
%
%     end
% end