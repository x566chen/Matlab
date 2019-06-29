function [muError, stdError] = errorKNN(classA, classB, K)
%-----------------------------------------------------------
% Classifier: KNN
% Input: 
%       class A, classB are two categories 
%       K - 1, 3, 5
% Output:
%       muError ---- mean of error rates
%       varError ---- variance of error rates
%
%-----------------------------------------------------------
Class = [classA;classB];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
errorNN = zeros(40,1);
label = zeros(length(Class),1);

for n = 1:40
    % choose 10 samples from class A and B 
    v = 5*n;
    u = (5*n-4);
    sampleA = classA(u:v,:);
    sampleB = classB(u:v,:);
    sample = [sampleA;sampleB];
    % add labels
    sample(1:5,3) = 1;
    sample(6:10,3) = 2;    
    % training 
    mdl = fitcknn(sample(:,1:2),sample(:,3),'NumNeighbors', K);
    
    for i = 1:400 
         label(i) = predict(mdl,[Class(i,1),Class(i,2)]);
    end
    
label(u:v,:) = Class(u:v,3);
label(200+u:200+v) = Class(200+u:200+v,3);
errorNN(n) = sum(abs(label(1:200)-1)+abs(label(201:400)-2))/380;
end
muError = mean(errorNN);
stdError = std(errorNN);
