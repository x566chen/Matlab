function [muError, stdError] = errorGED(classA, classB)
%---------------------------------------------------
% Classifier: GED
% Input: 
%       class A, classB are two categories 
%       
% Output:
%       muError ---- mean of error rates
%       varError ---- variance of error rates
%
%---------------------------------------------------
Class = [classA;classB];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
error_GED = zeros(40,1);
for n = 1:40
    v = 5*n;
    u = (5*n-4);
    sampleA = classA(u:v,:);
    sampleB = classB(u:v,:);
    meanClassA = mean(sampleA);
    meanClassB = mean(sampleB);
    valClassA = cov(sampleA);
    valClassB = cov(sampleB);
    z = zeros(length(Class),1);
    for i = 1:400   
             z(i) = ([Class(i,1) Class(i,2)]- meanClassA)*inv(valClassA)*...
                 ([Class(i,1) Class(i,2)]- meanClassA)'- ...
                 ([Class(i,1) Class(i,2)]- meanClassB)*inv(valClassB)...
             *([Class(i,1) Class(i,2)]- meanClassB)';    
         
            if z(i)>0
                z(i) = 2;
            else
                z(i) = 1;
            end
    end
    % get rid of training samples
    z(u:v,:) = Class(u:v,3);
    z(200+u:200+v) = Class(200+u:200+v,3);
    % calculate error rate
    error_GED(n) = sum(abs(z(1:200)-1)+abs(z(201:400)-2))/380;
end
% RESULT
muError = mean(error_GED);
stdError = std(error_GED);
