clear
file='Features\coast\training\training.txt';
c1 = importdata(file);
file='Features\forest\training\training.txt';
c2 = importdata(file);
file='Features\insidecity\training\training.txt';
c3 = importdata(file);

k1=4;
k2=4;
k3=4;
[m1 p1 s1] = code_img(c1,k1);
[m2 p2 s2] = code_img(c2,k2);
[m3 p3 s3] = code_img(c3,k3);


confmatrix_img(m1,m2,m3,p1,p2,p3,s1,s2,s3,k1);


clear

