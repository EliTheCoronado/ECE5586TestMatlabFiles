load('datedata.mat');
%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);

simpledatedata = normdatedata(:,1:3);
simpleclass = normdatedata(:,4);

%ran a sort of the data, to split the data evenly. If column 1 is less than
%.2081, it becomes a 1, if between .2081 and .4527, becomes a 2, else
%becomes 3. Same deal for the other columns
 for i=1:1000,
     %column 1
     if simpledatedata(i,1)<.2081
         simpledatedata(i,1) = 1;
     elseif (simpledatedata(i,1)>=.2081) && (simpledatedata(i,1)<=.4527)
         simpledatedata(i,1) = 2;
     else
         simpledatedata(i,1) = 3;
     end
     %column 2
     if simpledatedata(i,2)<.2081
         simpledatedata(i,2) = 1;
     elseif (simpledatedata(i,2)>=.2081) && (simpledatedata(i,2)<=.4527)
         simpledatedata(i,2) = 2;
     else
         simpledatedata(i,2) = 3;
     end
     %column 3
     if simpledatedata(i,3)<.3236
         simpledatedata(i,3) = 1;
     elseif (simpledatedata(i,3)>=.3236) && (simpledatedata(i,3)<=.6555)
         simpledatedata(i,3) = 2;
     else
         simpledatedata(i,3) = 3;
     end
 end
%These are now sorted yippee
%Gotta get dat mean and variance what what
 for i=1:3
     [p6m1_hat(i), p6s1_hat(i)]=Gaussian_ML_estimate(simpledatedata(find(simpleclass==1),i)');
 end
 p6m1_hat = p6m1_hat'; p6s1_hat = p6s1_hat';
%  for i=1:3
%      [p6m2_hat(i), p6s2_hat(i)]=Gaussian_ML_estimate(simpledatedata(find(simpleclass==2),i)');
%  end
%  p6m2_hat = p6m2_hat'; p6s2_hat = p6s2_hat';
 for i=1:3
     [p6m3_hat(i), p6s3_hat(i)]=Gaussian_ML_estimate(simpledatedata(find(simpleclass==3),i)');
 end
 p6m3_hat = p6m3_hat'; p6s3_hat = p6s3_hat';
 %classify those points
 for i=1:3
    p6perFeature1(i,:)=normpdf(simpledatedata(501:1000,i),p6m1_hat(i),sqrt(p6s1_hat(i)));
   % p6perFeature2(i,:)=normpdf(simpledatedata(501:1000,i)',p6m2_hat(i),sqrt(p6s2_hat(i)));
    p6perFeature3(i,:)=normpdf(simpledatedata(501:1000,i)',p6m3_hat(i),sqrt(p6s3_hat(i)));
 end
p6naive_prob1=prod(p6perFeature1);
%p6naive_prob2=prod(p6perFeature2);
p6naive_prob3=prod(p6perFeature3);
p6classified=ones(1,500);
p6classified(find(p6naive_prob1<p6naive_prob3))=3;
confusionmat(simpleclass(501:1000),p6classified)
