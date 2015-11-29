clear
N=8;
M=64;
k=M;
iter=20;
% a=importdata('..\Features\coast\training\training.txt');
% f1='..\digit_data\class1\training\';
% f2='..\digit_data\class2\training\';
% f3='..\digit_data\class3\training\';
f1='..\dtw_code\Features\coast\training\';
f2='..\dtw_code\Features\forest\training\';
f3='..\dtw_code\Features\insidecity\training\';
datatrain=get_data(f1,f2,f3);
dis='Training Data Done'

% f1='..\digit_data\class1\testing\';
% f2='..\digit_data\class2\testing\';
% f3='..\digit_data\class3\testing\';
f1='..\dtw_code\Features\coast\testing\';
f2='..\dtw_code\Features\forest\testing\';
f3='..\dtw_code\Features\insidecity\testing\';
datatest=get_data(f1,f2,f3);
a=[datatrain';datatest'];
% a=data.seq;
% max1=max(a);
% min1=min(a);
% diff=max1-min1;
train_count=size(datatrain',1);
test_count=size(datatest',1);
count=train_count+test_count;
d=size(a(1).seq,2);
x=randperm(count,k);
y=zeros(k,d);
for i=1:k
    y(i,:)=a(x(i)).seq(1,:);
end
l=0;
flag=true;
b(count).seq=0;
while flag
    
    init=0;
    new_mean=zeros(k,d);
    cluster_count=zeros(k,1);
    for j=1:count
        elem_array=a(j).seq;
        for m=1:size(elem_array,1)
            min2=inf;
            ind=0;
            elem=elem_array(m,:);
            for i=1:k
                dist=eucliddist(elem,y(i,:));
                if(min2>dist)
                    min2=dist;
                    ind=i;
                end
            end
            b(j).seq(m)=ind;
            cluster_count(ind)=cluster_count(ind)+1;
            new_mean(ind,:)=new_mean(ind,:)+elem;
        end
    end
    for i=1:k
        new_mean(i,:)=new_mean(i,:)/cluster_count(i);
    end
    flag=l<iter ;% &&~relerror_img(y,z,diff,k);
    y=new_mean;
    l=l+1
    
end

clear x;
no_class1(3).seq=0;
no_class1(1).seq=find(extractfield(datatrain,'class')==1);
no_class1(2).seq=find(extractfield(datatrain,'class')==2);
no_class1(3).seq=find(extractfield(datatrain,'class')==3);

no_classtest(3).seq=0;
no_classtest(1).seq=train_count+find(extractfield(datatest,'class')==1);
no_classtest(2).seq=train_count+find(extractfield(datatest,'class')==2);
no_classtest(3).seq=train_count+find(extractfield(datatest,'class')==3);
iter=40;
probabilitytest=zeros(3,3,size(no_classtest(1).seq,2));
for Clas=1:3
    A=(1/N)*ones(N);
%     A=triu(ones(N));
%     for i=1:N
%         for j=i:N
%             A(i,j)=1/(N+1-j);
%         end
%     end
%     pi=zeros(N,1);
%     pi(1)=1;
    pi=(1/N)*ones(N,1);
    
    no_class=no_class1(Clas).seq;
    % per_n=36/N;
    % in_file=36;
    B=zeros(N,M);
    for j=1:N-1
        for k=no_class
            per_n=floor(size(b(k).seq,2)/N);
            for x=(j-1)*per_n+1:j*per_n
                %         for k=2:count/in_file
                %             x=[x;in_file*(k-1)+(j-1)*per_n+1:in_file*(k-1)+j*per_n];
                %         end
                for i=1:M
                    B(j,i)=B(j,i)+numel(find(b(k).seq(x)==i));
                end
            end
        end
    end
    j=N;
    for k=no_class
        per_n=floor(size(b(k).seq,2)/N);
        for x=(j-1)*per_n+1:size(b(k).seq,2)
            %         for k=2:count/in_file
            %             x=[x;in_file*(k-1)+(j-1)*per_n+1:in_file*(k-1)+j*per_n];
            %         end
            for i=1:M
                B(j,i)=B(j,i)+numel(find(b(k).seq(x)==i));
            end
        end
    end
    
    B=bsxfun(@times,B,sum(B,2).^-1);
    
    % myzeta=zeros(T,N,N);
    % gamma=zeros(T,N);
    L=numel(no_class);
    likelihood=0;
    old_likelihood=0;
    n=1;
    class_loop=no_class;
    flag=true;
    while flag
        sum_zeta=zeros(N);
        sum_gamma=zeros(N,1);
        sum_gamma1=zeros(N,1);
        sum_gammam=zeros(N,M);
        L=numel(no_class);
        old_likelihood=likelihood;
        likelihood=0;
        for l=class_loop
            
            % calc alpha, beta, Observation
            % T=36;N=4;
            T=size(b(l).seq,2);
            alpha=zeros(N,T);
            alpha(:,1)=bsxfun(@times,pi(:),B(:,b(l).seq(1)));
            
            for t=2:T
                x=alpha(:,t-1)'*A(:,:);
                alpha(:,t)=bsxfun(@times,x',B(:,b(l).seq(t)));
            end
            
            % T=36;N=4;
            beta=zeros(N,T);
            beta(:,T)=1;
            
            for t=T-1:-1:1
%                 x=A(:,:)*beta(:,t+1);
                beta(:,t)=A(:,:)*bsxfun(@times,B(:,b(l).seq(t+1)),beta(:,t+1));
            end
            
            % calc done
            zetanum=zeros(T,N,N);
            zetadenum=zeros(T);
            zetatemp=zeros(T,N,N);
            gammatemp=zeros(N,T);
            
            for t=1:T-1
                zetanum(t,:,:)=bsxfun(@times,alpha(:,t),bsxfun(@times,A(:,:),bsxfun(@times,B(:,b(l).seq(t+1)),beta(:,t+1))'));
            end
            for t=1:T-1
                zetadenum(t)=sum(sum(squeeze(zetanum(t,:,:)))');
            end
            for t=1:T-1
                zetatemp(t,:,:)=zetanum(t,:,:)/zetadenum(t);
                sum_zeta(:,:)=sum_zeta(:,:)+squeeze(zetatemp(t,:,:));
            end
            %     for m=1:M
            
            gammatemp(:,1)=sum(squeeze(zetatemp(1,:,:))');
            sum_gamma1(:)=sum_gamma1(:)+squeeze(gammatemp(:,1));
            sum_gamma(:)=sum_gamma(:)+squeeze(gammatemp(:,1));
            m=b(l).seq(1);
            sum_gammam(:,m)=sum_gammam(:,m)+squeeze(gammatemp(:,1));
            
            for t=2:T-1
                gammatemp(:,t)=sum(squeeze(zetatemp(t,:,:))');
                sum_gamma(:)=sum_gamma(:)+squeeze(gammatemp(:,t));
                m=b(l).seq(t);
                sum_gammam(:,m)=sum_gammam(:,m)+squeeze(gammatemp(:,t));
            end
            gammatemp(:,T)=alpha(:,T);
            sum_gamma(:)=sum_gamma(:)+squeeze(gammatemp(:,t));
            m=b(l).seq(T);
            sum_gammam(:,m)=sum_gammam(:,m)+squeeze(gammatemp(:,t));
            
            probability=sum(alpha(:,T));
            likelihood=likelihood+log(probability);
            %     end
        end
        
        pi(:)=sum_gamma1(:)/L;
        
        A(:,:)=bsxfun(@times,sum_zeta(:,:),sum_gamma(:).^-1);
        % for i=1:N
        %     for j=1:N
        %         A(i,j)=sum(zetamy(:,i,j))/sum(gamma(:,i));
        %     end
        % end
        
        % for j=1:N
        %     for v=1:T
        %         num=0;
        %         for t=1:T
        %             if(b(l).seq(t)==v)
        %                 num = num + gamma(t,j);
        %             end
        %         end
        %         B(j,v)=num/sum(gamma(:,j));
        %     end
        % end
        diff=likelihood-old_likelihood
        flag=n<iter && abs(diff)>0.5;
        n=n+1
        B(:,:)=bsxfun(@times,sum_gammam(:,:),sum_gamma(:).^-1);
    end
    
    
    % testing
    for j=1:3
        L=numel(no_classtest(j).seq);
        
        for l=no_classtest(j).seq
            T=size(b(l).seq,2);
            alpha=zeros(N,T);
            alpha(:,1)=bsxfun(@times,pi(:),B(:,b(l).seq(1)));
            for t=2:T
                x=alpha(:,t-1)'*A(:,:);
                alpha(:,t)=bsxfun(@times,x',B(:,b(l).seq(t)));
            end
            probabilitytest(Clas,j,mod(l-1,L)+1)=sum(alpha(:,T));
        end
    end
end

for j=1:3
    [max1(j,:),ind1(j,:)]=max(probabilitytest(:,j,:));
    for i=1:3
        confmat(j,i)=numel(find(ind1(j,:)==i));
    end
end