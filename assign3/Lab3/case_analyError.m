clear all;
close all;
clc;
%% case1
mu_A_1=[0 0]; 
sigma_A_1=[1,0;0,1];
mu_B_1=[3 0];
sigma_B_1=[1,0;0,1];
%% case2
mu_A_2=[-1 0]; 
sigma_A_2=[4,3;3,4];
mu_B_2=[1 0];
sigma_B_2=[4,3;3,4];
%% case3
mu_A_3=[0 0]; 
sigma_A_3=[3,1;1,2];
mu_B_3=[3 0];
sigma_B_3=[7,-3;-3,4];
%% 
[errorMED_case1, errorGED_case1] = analyError(mu_A_1, mu_B_1, sigma_A_1)
%% 
[errorMED_case2, errorGED_case2] = analyError(mu_A_2, mu_B_2, sigma_A_2)
%% 
[errorMED_case3, errorGED_case3] = analyError(mu_A_3, mu_B_3, sigma_A_3)
