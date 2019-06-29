function errMED = errorMEDallData(classA, classB)
%---------------------------------------------------
% Classifier: MED
% Input: 
%       class A, classB are two categories 
%       
% Output:
%       errMED ---- error rates of MED classifier
%
%---------------------------------------------------
Class = [classA; classB];
% add labels
Class(1:200, 3) = 1;
Class(201:400, 3) = 2;
z = zeros(length(Class),1);
for n = 1:200
    sampleA = classA;
    sampleB = classB;
    % get rid of 1 data 
    sampleA(n,:) = 0;
    sampleB(n,:) = 0;
    sample = [sampleA;sampleB];
    % calculate the mean of sample A
    meanClassA = mean(sampleA);
    meanClassB = mean(sampleB);
    
    z(n) = (Class(n,1)- meanClassA(1))^2 + (Class(n,2)- meanClassA(2))^2 ...
                - ((Class(n,1)- meanClassB(1))^2 + (Class(n,2)- meanClassB(2))^2);
           
    z(n+200) = (Class(n+200,1)- meanClassA(1))^2 + (Class(n+200,2)- meanClassA(2))^2 ...
                - ((Class(n+200,1)- meanClassB(1))^2 + (Class(n+200,2)- meanClassB(2))^2);
       if z(n)>0
                z(n) = 2;
            else
                z(n) = 1;
       end
            
       if z(n+200)>0
                z(n+200) = 2;
            else
                z(n+200) = 1;
       end
end
errMED = sum(abs(z(1:200)-1)+abs(z(201:400)-2))/400;
                   
