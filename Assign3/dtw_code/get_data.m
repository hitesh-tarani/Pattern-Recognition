function img =get_data(f1,f2,f3)
% folder1='..\digit_data\class1\';
% folder2='..\digit_data\class2\';
% folder3='..\digit_data\class3\';



fileList1 = dir(f1);
fileList1 = fileList1(~[fileList1.isdir]); %remove directories
n1 = numel(fileList1);

fileList2 = dir(f2);
fileList2 = fileList2(~[fileList2.isdir]); %remove directories
n2 = numel(fileList2);

fileList3 = dir(f3);
fileList3 = fileList3(~[fileList3.isdir]); %remove directories
n3 = numel(fileList3);

img(n1+n2+n3).seq=0;

for i = 1:n1
   img(i).seq = importdata(strcat(f1,fileList1(i).name));
   img(i).class=1;
end
cnt=1;
for i = (n1+1):(n1+n2)
   img(i).seq = importdata(strcat(f2,fileList2(cnt).name));
   img(i).class=2;
   cnt=cnt+1;
end
cnt=1;
for i = (n1+n2+1):(n1+n2+n3)
   img(i).seq = importdata(strcat(f3,fileList3(cnt).name));
   img(i).class=3;
   cnt=cnt+1;
end

end






