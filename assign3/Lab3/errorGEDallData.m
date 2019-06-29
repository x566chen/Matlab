function errGED = errorGEDallData(classA, classB)
%---------------------------------------------------
% Classifier: GED
% Input: 
%       class A, classB are two categories 
%       
% Output:
%       errGED ---- error rate 
%     
%---------------------------------------------------
Class = [classA;classB];
Class(1:200,3) = 1;
Class(201:400,3) = 2;
z = zeros(length(Class),1);

for n = 1:200  
    sampleA = classA;
    sampleB = classB;
    sampleA(n,:) = 0;
    sampleB(n,:) = 0;
    sample = [sampleA;sampleB];
    % mean and variance
    meanClassA = mean(sampleA);
    meanClassB = mean(sampleB);
    valClassA = cov(sampleA);
    valClassB = cov(sampleB);

     % Class A
     z(n) = ([Class(n,1) Class(n,2)]- meanClassA)*inv(valClassA)*([Class(n,1) Class(n,2)]...
             - meanClassA)'- ([Class(n,1) Class(n,2)]- meanClassB)*inv(valClassB)...
             *([Class(n,1) Class(n,2)]- meanClassB)';    
     % class B
     z(n+200) = ([Class(n+200,1) Class(n+200,2)]- meanClassA)*inv(valClassA)*([Class(n+200,1) Class(n+200,2)]...
             - meanClassA)'- ([Class(n+200,1) Class(n+200,2)]- meanClassB)*inv(valClassB)...
             *([Class(n+200,1) Class(n+200,2)]- meanClassB)';
          
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
errGED = sum(abs(z(1:200)-1)+abs(z(201:400)-2))/400;
