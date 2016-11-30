%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);
%Create a data set specifically to be used with this problem.
ptanormdatedata = normdatedata(1:500,1:3);
%Get a separate matrix just with the classes of the normalized date data
ptaclass= normdatedata(:,4);
%classify everything based on the normalized date data
output = k_nn_classifier(ptanormdatedata',ptaclass(1:500)',1,normdatedata(501:1000,1:3)');
%Make a confusion matrix
confuzzled = confusionmat(ptaclass(501:1000),output')
disp('There were this many misclassifications:')
errors = confuzzled(1,2) + confuzzled(1,3) + confuzzled(2,1) + confuzzled(2,3) + confuzzled(3,1) + confuzzled(3,2)