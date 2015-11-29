file_location='H:\study material\sem5\PR\Assign4\LS_Group16\';
str=strcat(file_location,'Class1-train.txt');
 data1= dlmread(str);
 [row,col]=size(data1);
 n_data1=row;
 all_data(1:n_data1,:)=data1;
 y(1:n_data1)=1;
 
 str=strcat(file_location,'Class2-train.txt');
 data2= dlmread(str);
 [row,col]=size(data2);
 n_data2=row;
 all_data(n_data1+1:n_data1+n_data2,:)=data2;
 y(n_data1+1:n_data1+n_data2)=-1;
 

str=strcat(file_location,'Class1-test.txt');
 test_data1= dlmread(str);
 [row,col]=size(test_data1);
 n_testdata1=row;
 
 str=strcat(file_location,'Class2-test.txt');
 test_data2= dlmread(str);
 [row,col]=size(test_data2);
 n_testdata2=row;
 
 str=strcat(file_location,'Class3-test.txt');
 test_data3= dlmread(str);
 [row,col]=size(test_data3);
 n_testdata3=row;
 
 str=strcat(file_location,'Class3-train.txt');
 data3= dlmread(str);
 [row,col]=size(data3);
 n_data3=row;
 all_data(n_data1+n_data2+1:n_data1+n_data2+n_data3,:)=data3;
 y(n_data1+n_data2+1:n_data1+n_data2+n_data3)=3;
 
 d=2;
 eta=0.5;
 a_12(1:d+1,1)=-1;
 
 confusion_matrix=zeros(3,3);
 
 while(1)
       
     num_wrong_class=0;
     delta_a(1:d+1,1)=0;
     for i=1:n_data1+n_data2
         z(1,1)=1;
         z(2:d+1,1)=transpose(all_data(i,:));
        x=y(i)*transpose(a_12)*z;
        if x<0
            num_wrong_class=num_wrong_class+1;
            delta_a(1:d+1,1)=delta_a(1:d+1,1) + y(i)*z;
            
        end
          
     end
     if num_wrong_class==0
         break;
         
     end
     a_12=a_12 + eta*delta_a;
 end
 
 a_13(1:d+1,1)=1;
 y(n_data1+n_data2+1:n_data1+n_data2+n_data3,1)=-1;
 y_(1:n_data1)=1;
  y_(n_data1+1:n_data1+n_data3)=-1;
 while(1)
       
     num_wrong_class=0;
     delta_a(1:d+1,1)=0;
     data(1:n_data1,:)=all_data(1:n_data1,:);
     data(n_data1+1:n_data1+n_data3,:)=all_data(n_data1+n_data2+1:n_data1+n_data2+n_data3,:);
     
     for i=1:n_data1+n_data3
         z(1,1)=1;
         z(2:d+1,1)=transpose(data(i,:));
        x=y_(i)*transpose(a_13)*z;
        if x<0
            num_wrong_class=num_wrong_class+1;
            delta_a(1:d+1,1)=delta_a(1:d+1,1) + y_(i)*z;
            
        end
          
     end
     if num_wrong_class==0
         break;
     end
     a_13=a_13 + eta*delta_a;
 end
 
 a_23(1:d+1,1)=1;
 y(n_data1+n_data2+1:n_data1+n_data2+n_data3,1)=-1;
 y_(1:n_data2)=1;
  y_(n_data2+1:n_data2+n_data3)=-1;
 while(1)
       
     num_wrong_class=0;
     delta_a(1:d+1,1)=0;
     data(1:n_data2,:)=all_data(n_data1+1:n_data1+n_data2,:);
     data(n_data2+1:n_data2+n_data3,:)=all_data(n_data1+n_data2+1:n_data1+n_data2+n_data3,:);
     for i=1:n_data2+n_data3
         z(1,1)=1;
         z(2:d+1,1)=transpose(data(i,:));
        x=y_(i)*transpose(a_23)*z;
        if x<0
            num_wrong_class=num_wrong_class+1;
            delta_a(1:d+1,1)=delta_a(1:d+1,1) + y_(i)*z;
            
        end
          
     end
     if num_wrong_class==0
         break;
     end
     a_23=a_23 + eta*delta_a;
 end
%  
%  
 
 
 hold all;

%plot(test_data1(1:n_testdata1,1),test_data1(1:n_testdata1,2),'.r');
%plot(all_data(n_data1+1:n_data1+n_data2,1),all_data(n_data1+1:n_data1+n_data2,2),'.g');

p=0;

for i=1:n_testdata1
   z(1,1)=1;
         z(2:d+1,1)=transpose(test_data1(i,:));
        x_12=transpose(a_12)*z;
        x_13=transpose(a_13)*z;
        x_23=transpose(a_23)*z;
        k1=0;k2=0;k3=0;
        if x_12>=0
            k1=k1+1;
        else 
            k2=k2+1;
           
            
        end
         
        if x_13>=0
            k1=k1+1;
        else 
            k3=k3+1;
            
            
        end
        
        if x_23>=0
            k2=k2+1;
        else 
            
            k3=k3+1;
            
        end
        [value index]=max([k1 k2 k3]);
        confusion_matrix(index,1)= confusion_matrix(index,1)+1;
end

for i=1:n_testdata2
   z(1,1)=1;
         z(2:d+1,1)=transpose(test_data2(i,:));
        x_12=transpose(a_12)*z;
        x_13=transpose(a_13)*z;
        x_23=transpose(a_23)*z;
        k1=0;k2=0;k3=0;
        if x_12>=0
            k1=k1+1;
        else 
            k2=k2+1;
        end
         
        if x_13>=0
            k1=k1+1;
        else 
            k3=k3+1;
        end
        
        if x_23>=0
            k2=k2+1;
        else 
            k3=k3+1;
        end
       [value index]=max([k1 k2 k3]);
        confusion_matrix(index,2)= confusion_matrix(index,2)+1;
end

for i=1:n_testdata3
   z(1,1)=1;
         z(2:d+1,1)=transpose(test_data3(i,:));
        x_12=transpose(a_12)*z;
        x_13=transpose(a_13)*z;
        x_23=transpose(a_23)*z;
        k1=0;k2=0;k3=0;
        if x_12>=0
            k1=k1+1;
        else 
            k2=k2+1;
        end
         
        if x_13>=0
            k1=k1+1;
        else 
            k3=k3+1;
        end
        
        if x_23>=0
            k2=k2+1;
        else 
            k3=k3+1;
        end
        [value index]=max([k1 k2 k3]);
        confusion_matrix(index,3)= confusion_matrix(index,3)+1;
end



        
% for i=-20:0.1:20
%     for j=-15:0.1:15
%          z(1,1)=1;
%          z(2:d+1,1)=transpose([i j]);
%         x=abs(transpose(a_13)*z);
%         w=norm(a_13(2:3));
%         dist=x/w;
%         if dist <0.01
%             plot(i,j,'y*');
%         end
%         
%     end
% end
% 
% for i=-20:0.1:20
%     for j=-15:0.1:15
%          z(1,1)=1;
%          z(2:d+1,1)=transpose([i j]);
%         x=abs(transpose(a_12)*z);
%         w=norm(a_12(2:3));
%         dist=x/w;
%         if dist <0.01
%             plot(i,j,'b*');
%         end
%         
%     end
% end
% 
% for i=-20:0.1:20
%     for j=-15:0.1:15
%          z(1,1)=1;
%          z(2:d+1,1)=transpose([i j]);
%         x=abs(transpose(a_23)*z);
%         w=norm(a_23(2:3));
%         dist=x/w;
%         if dist <0.01
%             plot(i,j,'r*');
%         end
%         
%     end
% end

min_point_1=min([min([data1(:,1) data2(:,1) data3(:,1)])]);
min_point_2=min([min([data1(:,2) data2(:,2) data3(:,2)])]);
max_point_1=max([max([data1(:,1) data2(:,1) data3(:,1)])]);
max_point_2=max([max([data1(:,2) data2(:,2) data3(:,2)])]);

for i=min_point_1:0.1:max_point_1
    for j=min_point_2:0.1:max_point_2
         z(1,1)=1;
         z(2:d+1,1)=transpose([i j]);
        x_12=transpose(a_12)*z;
        x_13=transpose(a_13)*z;
        x_23=transpose(a_23)*z;
        k1=0;k2=0;k3=0;
        if x_12>=0
            k1=k1+1
        else 
            k2=k2+1
        end
         
        if x_13>=0
            k1=k1+1
        else 
            k3=k3+1
        end
        
        if x_23>=0
            k2=k2+1
        else 
            k3=k3+1
        end
        display('hey');
        i
        j
        
        if k1==k2 && k2==k3
            plot(i,j,'.w');
            continue;
        else
        [value index]=max([k1 k2 k3]);
         if(index==1)
         plot(i,j,'.b');
        elseif(index==2)
         plot(i,j,'.r');
         elseif(index==3)
         plot(i,j,'.y');
         
        end
        
        end
        
    end
end

 plot(all_data(1:n_data1,1),all_data(1:n_data1,2),'.c');
plot(all_data(n_data1+1:n_data1+n_data2,1),all_data(n_data1+1:n_data1+n_data2,2),'.g');
plot(all_data(n_data1+n_data2+1:n_data1+n_data2+n_data3,1),all_data(n_data1+n_data2+1:n_data1+n_data2+n_data3,2),'.r');

 %save ('classification_data.mat','confusion_matrix','a_12','a_13','a_23');