function errKNN = errorKNNallData(classA, classB, K)
%---------------------------------------------------
% Classifier: KNN
% Input: 
%       class A, classB are two categories 
%       K ---- 1, 3, 5
%       
% Output:
%       errKNN ---- error rate of KNN classifier
%     
%---------------------------------------------------
Class = [classA;classB];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
label = zeros(length(Class),1);

for n = 1:200
    
    sampleA = classA;
    sampleB = classB;
    sample = [sampleA;sampleB];
    sample(1:200,3) = 1;
    sample(201:400,3) = 2;    
    sample(n,:) = 0;
    sample(n+200,:) = 0;
    
    mdl = fitcknn(sample(:,1:2),sample(:,3),'NumNeighbors', K);
    label(n) = predict(mdl,[Class(n,1),Class(n,2)]);
    
    if label(n)== Class(n,3)
        label(n) = 0;
    else 
        label(n) = 1;
    end
    
end

errKNN = sum(label)/400;

end


