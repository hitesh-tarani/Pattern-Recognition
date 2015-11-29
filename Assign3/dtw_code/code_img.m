function [mean pi sigma] = code(a,k) 

% k=20;
iter=20;
% file='OD_Group12\trainingClass1.txt';
% a=importdata(file);
max1=max(a);
min1=min(a);
diff=max1-min1;
x=rand(k,23);
% z(:,1)=zeros(k,1);
% z(:,2)=min1(2)*ones(k,1);
%y=zeros(k,23);
for i=1:23
y(:,i)=x(:,i)*diff(i) + min1(i)*ones(k,1);
end

% scatter(y(:,1),y(:,2));
% hold
% scatter(a(:,1),a(:,2));
% scatter(a(1,1),a(1,2));
s=size(a(:,1));
l=1;
flag=true;
while flag
    %for l=1:iter
    clear b
    for j=1:s(1)
        
        min2=1000000000000;
        ind=0;
        elem=a(j,:);
        for i=1:k
            dist=eucliddist(elem,y(i,:));
            if(min2>dist)
                min2=dist;
                ind=i;
            end
        end
        if((exist('b','var'))==1)
            %         c(:,:)=b(ind,:,:);
            %         d=[c';elem];
            d=(size(b(:,:,1)));
            b(ind,d(2)+1,:)=elem;
        else
            b(ind,1,:)=elem;
        end
    end
         
    for i=1:size(b,1)
        for v=1:23
            z(i,v)=sum(b(i,:,v))/nnz(b(i,:,v));
            end
    end
    
    flag=l<iter &&~relerror_img(y,z,diff,k);
    y=z;
    l=l+1
    
end

clear z
for i=1:k
    z(i)=nnz(b(i,:,1))/s(1);
end

s=size(b(i,:,1));
sigma=zeros(k,23,23);
for i=1:k
    
    temp=zeros(23,23);
    for j=1:s(2)
        if(b(i,j,:))
%             temp(i)=temp(i)+1;
            if((exist('temp','var'))==1)
                s1=(size(temp(:,1)));
                temp(s1(1)+1,:)=squeeze(b(i,j,:))';
            else
                temp(1,:)=squeeze(b(i,j,:))';
            end
        end
    end
    sigma(i,:,:)=diag(diag(cov(temp(:,:))));
end
temp_cnt=0;
temp_mat=y;
temp_3_mat=sigma;
temp_z=z;
for i=1:k
    if(~z(i))
        j=i-temp_cnt;
        temp_mat(j,:)=[];
        temp_3_mat(j,:,:)=[];
        temp_cnt=temp_cnt+1;
        temp_z(j)=[];
    end
end
y=temp_mat;
sigma=temp_3_mat;
k=k-temp_cnt;
z=temp_z;

mean=y;

s=size(a);
flag=true;
gamma=zeros(k,s(1));
var12=log_likelihood(a,y,z,sigma);
dis='start em'
l=1
while flag
    %     clear b
    old_like=var12;
    for i=1:k
        for j=1:s(1)
            gamma(i,j)=gamma_znk(a(j,:),z,y,sigma,i);
        end
    end
    for i=1:k
        sigma(i,:,:)=diag(diag(new_sigma_k(a,gamma(i,:),y(i,:))));
        y(i,:)=new_mean_k(a,gamma(i,:));
        z(i)=new_pi_k(a,gamma(i,:));
    end
    var12=log_likelihood(a,y,z,sigma);
    flag=l<iter && error_like(old_like,var12);
    dis=old_like-var12
    l=l+1
    
    
end
mean=y;
pi=z;

end