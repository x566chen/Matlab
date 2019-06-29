function [errorMED, errorGED] = analyError(muAClass, muBClass, sigmaAClass)
% input: 
%       muAClass    ---- mean of class A
%       muBClass    ---- mean of class B
%       sigmaAClass ---- covariance of class A and B
% Output: 
%       errorMED    ---- error rate of MED
%       errorGED    ---- error rate of GED
%%
% Error MED
MED_muA = -(muAClass - muBClass) * inv([1 0;0 1]) * (muAClass - muBClass)';
MED_muB = (muAClass - muBClass) * inv([1 0;0 1]) * (muAClass - muBClass)';
errorVarMED = 4 * (muAClass - muBClass) * inv([1 0;0 1]) * (muAClass - muBClass)';
errorMED = normcdf((-MED_muB/errorVarMED^0.5), 0, 1);

% Error GED
GED_muA = -(muAClass - muBClass) * inv(sigmaAClass) * (muAClass - muBClass)';
GED_muB = (muAClass - muBClass) * inv(sigmaAClass) * (muAClass - muBClass)';
errorVarGED = 4 * (muAClass - muBClass) * inv(sigmaAClass) * (muAClass - muBClass)';
errorGED = normcdf((-GED_muB/errorVarGED^0.5), 0, 1);