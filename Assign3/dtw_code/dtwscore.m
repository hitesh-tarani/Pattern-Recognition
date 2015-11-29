function res=dtwscore(imgtrain,test)
  s=size(imgtrain,2);
  res(s).dtw=0;
  
  for i=1:s
      res(i).dtw=dtw(test.seq,imgtrain(i).seq);
      res(i).class=imgtrain(i).class;
  end
      

end

   
