%% case3 
close all;    
clear all;  
clc;    
load assign22018.mat;
classA=a3';
classB=b3';
% scatter(classA(:,1),classA(:,2));
% hold on;
% scatter(classB(:,1),classB(:,2));
%% ERROR_MED_LIMIT
[muError_MED , stdError_MED]=errorMED(classA, classB)
%% ERROR_GED_LIMIT
[muError_GED , stdError_GED]=errorGED(classA, classB)
%% ERROR_NN_LIMIT
[muError_NN , stdError_NN]=errorKNN(classA, classB,1)
%% ERROR_3NN_LIMIT
[muError_3NN , stdError_3NN]=errorKNN(classA, classB,3)
%% ERROR_5NN_LIMIT
[muError_5NN , stdError_5NN]=errorKNN(classA, classB,5)