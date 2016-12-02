%!!!!!!!!!!!!                                                    !!!!!!!!!!
%!!!!!!!!!!!!   RUN THE PROBLEM 4 SCRIPT BEFORE RUNNING THIS ONE !!!!!!!!!!
%!!!!!!!!!!!!                                                    !!!!!!!!!!
%!!!!!!!!!!!!                                                    !!!!!!!!!!


load('datedata.mat');
%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);
prob5class = zeros([500,1]);
 for i = 1:500
     if normdatedata(i,4) == 1
         prob5class(i,1) = 1;
     elseif normdatedata(i,4)==2
         prob5class(i,1) = 3;
     else
         prob5class(i,1)=3;
     end
 end
inverted = pinv(normdatedata(1:500,1:3)');
decisionplane5 = (pinv(normdatedata(1:500,1:3)'*normdatedata(1:500,1:3)))*(normdatedata(1:500,1:3)'*prob5class)
%we know what the midpoint still is from the previous problem, so we will
%use it
prob5out = zeros([500,1]);
for i = 501:1000
    if (dot(decisionplane5,normdatedata(i,1:3)-midpoint)) > 0
        prob5out(i-500,1) = 1;
    else
        prob5out(i-500,1) = 3;
    end
end
p4confusion2 = confusionmat(ptaclass(501:1000),prob5out)