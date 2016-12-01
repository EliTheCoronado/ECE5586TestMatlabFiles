load('datedata.mat');
%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);
theta1 = normdatedata(1:3,:);

theta1(:,4) = [3 3 3];
[output2, beluga, jig] = k_means(normdatedata',theta1');
kmeansconfusionmat1 = confusionmat(normdatedata(:,4)',beluga')

theta2 = normdatedata(22:24,:);
theta2(:,4) = [3 3 3];
[output3, beluga2, jiggy] = k_means(normdatedata',theta2');
kmeansconfusionmat2 = confusionmat(normdatedata(:,4)',beluga2')