theta1 = datedata(1:3,:);

theta1(:,4) = [3 3 3];
[output2, beluga, jig] = k_means(datedata',theta1');
confuzzled2 = confusionmat(datedata(:,4)',beluga')

theta2 = datedata(22:24,:);
theta2(:,4) = [3 3 3];
[output3, beluga2, jiggy] = k_means(datedata',theta2');
whaaaat = confusionmat(datedata(:,4)',beluga2')