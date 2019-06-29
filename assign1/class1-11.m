%% SYDE 675 LAB_1
clear all; close all; clc;

%% class 1
muAClass1 = [0,0];
sigmaAClass1 = [1,0; 0,1];
muBClass1 = [3,0];
sigmaBClass1 = [1,0; 0,1];

%% load data
load class1A.mat;
load class1B.mat;
h = figure
plot(rAClass1(:,1),rAClass1(:,2),'+');
hold on
plot(rBClass1(:,1),rBClass1(:,2),'o'); 
title('Class 1');

%% MED
meanClass1A = mean(rAClass1)
meanClass1B = mean(rBClass1)
u = linspace(-4, 7, 500);
v = linspace(-4, 4, 500);
z = zeros(length(u), length(v));
for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = ((u(i)- meanClass1A(1))^2 + (v(j)- meanClass1A(2))^2)...
                - ((u(i)- meanClass1B(1))^2 + (v(j)- meanClass1B(2))^2);
        end
end
z = z';
contour(u,v,z,[0, 0], 'LineWidth', 2,'LineColor','r','DisplayName','MED');

plot(meanClass1A(1),meanClass1A(2),'gs','MarkerSize',10,'MarkerFaceColor',...
    [0.5,0.5,0.5],...
    'DisplayName','mean_{sampleA}');
plot(meanClass1B(1),meanClass1B(2),'cs','MarkerSize',10,'MarkerFaceColor',...
    [0.5,0.5,0.5],...
    'DisplayName','mean_{sampleB}');

%% GED
u1 = linspace(-4, 7, 500);
v1 = linspace(-4, 4, 500);
valClass1A = cov(rAClass1)
valClass1B = cov(rBClass1)
z1 = zeros(length(u1), length(v1));
for i = 1:length(u1)
     for j = 1:length(v1)
         z1(i,j) = ([u1(i) v1(j)]- meanClass1A)*inv(valClass1A)*([u1(i) v1(j)]...
             - meanClass1A)'- ([u1(i) v1(j)]- meanClass1B)*inv(valClass1B)...
             *([u1(i) v1(j)]- meanClass1B)';
             
     end
end
z1 = z1';
contour(u1,v1,z1,[0, 0], 'LineWidth', 2,'DisplayName','GED'); 
legend('show');

%% MAP

u2 = linspace(-4, 7, 500);
v2 = linspace(-4, 4, 500);
z2 = zeros(length(u2), length(v2));
for i = 1:length(u2)
     for j = 1:length(v2)      
         z2(i,j) = 1/(2*pi*(abs(det(sigmaAClass1)))^0.5)*exp(-0.5*([u2(i) v2(j)]...
             - muAClass1)*inv(sigmaAClass1)*([u2(i) v2(j)]- muAClass1)')...
             - 1/(2*pi*(abs(det(sigmaBClass1)))^0.5)*exp(-0.5*([u2(i) v2(j)] ...
             - muBClass1)*inv(sigmaBClass1)*([u2(i) v2(j)]- muBClass1)');
     end
end
z2 = z2';
contour(u2,v2,z2,[0, 0], 'LineWidth', 2,'LineColor','b','DisplayName','MAP'); 
legend('show');

saveas(h,'class1.png');
%% NN
% u2_class1 = linspace(-5, 8, 500);
% v2_class1 = linspace(-3, 3, 500);
% z2_class1 = zeros(length(u2_class1), length(v2_class1));
% temp = zeros(400,1);
% for m = 1:length(u2_class1)
%     for n = 1:length(v2_class1)
%         z2_A_class1 = zeros(size(rAClass1,1), 1); 
%         z2_B_class1 = zeros(size(rAClass1,1), 1);
%         for i = 1:size(rAClass1,1)
%                 z2_A_class1(i) = (u2_class1(m)-rAClass1(i,1))^2+(v2_class1(n)-rAClass1(i,2))^2;
%                 z2_B_class1(i) = (u2_class1(m)-rBClass1(i,1))^2+(v2_class1(n)-rBClass1(i,2))^2;        
%         end
%         z2_class1(m,n) = min(z2_A_class1)-min(z2_B_class1);       
%     end
% end
% z2_class1 = z2_class1';
% contour(u2_class1,v2_class1,z2_class1,[0, 0], 'LineWidth', 1,'LineColor','m','DisplayName','NN'); 
% legend('show');
