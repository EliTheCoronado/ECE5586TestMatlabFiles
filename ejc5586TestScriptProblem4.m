load('datedata.mat');
%get the biggest values of all the columns for data normlaization
Biggest = max(datedata);
%Set the 4th column so that it is 1, and will not change the class column
Biggest(1,4)=1;
%NOrmalize this stuff
normdatedata =  bsxfun(@rdivide,datedata,Biggest);
%separate into class 1 and class 3
meancl1 = [0,0,0];
meandiv1 = 0;
meancl3 = [0,0,0];
meandiv3 = 0;
%figure out which rows/vectors are in which class
for step1 = 1:500
    if normdatedata(step1,4) == 1
        meancl1 = meancl1 + normdatedata(step1,1:3);
        meandiv1 = meandiv1 + 1;
    elseif normdatedata(step1,4) == 3
        meancl3 = meancl3 + normdatedata(step1,1:3);
        meandiv3 = meandiv3 + 1;
    end
end
%get a mean vector
meanvec1 = meancl1/meandiv1;
meanvec3 = meancl3/meandiv3;
midpoint = (meanvec1 + meanvec3)/2;

%createa  vector between the two means
vecbetween = meanvec1 - meanvec3;
%Separate the values into either class 1 or class 3 for the first 500.
%aka having the subject treat her dates as binary, she liked them or didnt
p3out1 = zeros([500,1]);
for step2 = 1:500
    %if the dot product is +, then the point is above the decision plane.
    %else, point is below the decision plane.
    if (dot(vecbetween,normdatedata(step2,1:3)-midpoint)) > 0 
        p3out1(step2,1) = 1;
    else
        p3out1(step2,1) = 3;
    end
end
p4confusion1 = confusionmat(ptaclass(1:500),p3out1)
p3out2 = zeros([500,1]);
%same sort of deal for this one as well.
for step3 = 501:1000
    if (dot(vecbetween,normdatedata(step3,1:3)-midpoint)) > 0
        p3out2(step3-500,1) = 1;
    else
        p3out2(step3-500,1) = 3;
    end
end
p4confusion2 = confusionmat(ptaclass(501:1000),p3out2)