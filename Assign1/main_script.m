function main_script

clear
class_2_files={'Interlock','Ring','Spiral'};

class_3_files={'LS_Group12','OD_Group12','rd_group12'};

for files=class_3_files
    file=strcat(files,'\trainingClass1.txt');
    c1 = importdata(file{:});
    
    file=strcat(files,'\trainingClass2.txt');
    c2 = importdata(file{:});
    
    file=strcat(files,'\trainingClass3.txt');
    c3 = importdata(file{:});
    bayes_a1(files,c1,c2,c3);
    bayes_a2(files,c1,c2,c3);
    bayes_b(files,c1,c2,c3);
    naivebayes_a(files,c1,c2,c3);
    naivebayes_b(files,c1,c2,c3);
    naivebayes_c(files,c1,c2,c3);
end

for files=class_2_files
    file=strcat(files,'\trainingClass1.txt');
    c1 = importdata(file{:});
    
    file=strcat(files,'\trainingClass2.txt');
    c2 = importdata(file{:});
    
    bayes_a1_2(files,c1,c2);
    bayes_a2_2(files,c1,c2);
    bayes_b_2(files,c1,c2);
    naivebayes_a_2(files,c1,c2);
    naivebayes_b_2(files,c1,c2);
    naivebayes_c_2(files,c1,c2);
end

end
