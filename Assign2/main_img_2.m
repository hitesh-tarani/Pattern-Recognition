clear
k=16;
for cntm=1:4
files={'Features'};
file='Features\coast\training\training.txt';
x1 = importdata(file);
file='Features\forest\training\training.txt';
x2 = importdata(file);
file='Features\insidecity\training\training.txt';
x3 = importdata(file);


 cnt=1;
    for i=1:(size(x1,1)/36)
        c1(i,:)=mean(x1(cnt:cnt+35,:));
        cnt=cnt+36;
    end

cnt=1;
    for i=1:(size(x2,1)/36)
        c2(i,:)=mean(x2(cnt:cnt+35,:));
        cnt=cnt+36;
    end

cnt=1;
    for i=1:(size(x3,1)/36)
        c3(i,:)=mean(x3(cnt:cnt+35,:));
        cnt=cnt+36;
    end


k1=k;
k2=k;
k3=k;
[m1 p1 s1] = code_img(c1,k1);
[m2 p2 s2] = code_img(c2,k2);
[m3 p3 s3] = code_img(c3,k3);


file='Features\coast\testing\testing.txt';
x1 = importdata(file);
file='Features\forest\testing\testing.txt';
x2 = importdata(file);
file='Features\insidecity\testing\testing.txt';
x3 = importdata(file);


 cnt=1;
    for i=1:(size(x1,1)/36)
        t1(i,:)=mean(x1(cnt:cnt+35,:));
        cnt=cnt+36;
    end

cnt=1;
    for i=1:(size(x2,1)/36)
        t2(i,:)=mean(x2(cnt:cnt+35,:));
        cnt=cnt+36;
    end

cnt=1;
    for i=1:(size(x3,1)/36)
        t3(i,:)=mean(x3(cnt:cnt+35,:));
        cnt=cnt+36;
    end




confmatrix_img_2(t1,t2,t3,m1,m2,m3,p1,p2,p3,s1,s2,s3,k1);
k=k*2;
end



