%% case2 
close all;    
clear all;  
clc;    
load assign22018.mat;
classA=a2';
classB=b2';
% scatter(classA(:,1),classA(:,2));
% hold on;
% scatter(classB(:,1),classB(:,2));
%% ERROR_MED_ALL
[errMED]=errorMEDallData(classA, classB)
%% ERROR_GED_ALL
[errGED]=errorGEDallData(classA, classB)
%% ERROR_NN_ALL
[errNN]=errorKNNallData(classA, classB,1)
%% ERROR_3NN_ALL
[err3NN]=errorKNNallData(classA, classB,3)
%% ERROR_5NN_ALL
[err5NN]=errorKNNallData(classA, classB,5)