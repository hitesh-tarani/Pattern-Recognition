clear
k1=2;
inc=2;
k2=32;
loc='..\digit_data';

f1='..\digit_data\class1\training\';
f2='..\digit_data\class2\training\';
f3='..\digit_data\class3\training\';
imgtrain=get_data(f1,f2,f3);
dis='Training Data Done'

f1='..\digit_data\class1\testing\';
f2='..\digit_data\class2\testing\';
f3='..\digit_data\class3\testing\';

imgtest=get_data(f1,f2,f3);
dis='Testing Data Done'

for i=1:size(imgtest,2)
    dis=i
    sc=dtwscore(imgtrain,imgtest(i));
    sorted=nestedSortStruct(sc,'dtw');
    cnt=1;
    for k=k1:inc:k2
        c=[0 0 0];
    
        for j=1:k
            if(sorted(j).class==1)
                c=c+[1 0 0];
            elseif(sorted(j).class==2)
                c=c+[0 1 0];
            else
                c=c+[0 0 1];
            end
        end
        imgtest(i).alotclass(cnt)=maxim_ind(c);
        cnt=cnt+1;
    end
end
confmatrix(imgtest,loc,k1,inc,k2);

