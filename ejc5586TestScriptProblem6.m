load('datedata.mat');
%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);
for i=1:3
    [p6m1_hat(i), p6s1_hat(i)]=Gaussian_ML_estimate(normdatedata(find(ptaclass==1),i)');
end
