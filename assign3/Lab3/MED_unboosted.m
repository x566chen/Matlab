%% C4
close all;    
clear all;  
clc;    
load assign32018.mat;
% id_a=randperm(200,50);
% a=a(id_a,:);
% id_b=randperm(200,50);
% b=b(id_b,:);
scatter(a(:,1),a(:,2),'*','DisplayName','A');
hold on;
scatter(b(:,1),b(:,2),'DisplayName','B');
%% MED
x_M = linspace(150, 475, 500);
y_M = linspace(0, 350, 500);
mean_a= mean(a);
mean_b= mean(b);
z_M = zeros(length(x_M), length(y_M));
for i=1:length(x_M)
    for j=1:length(y_M)
        z_M(i,j)=sqrt(((x_M(i)-mean_a(1))^2 + (y_M(j)-mean_a(2))^2))-sqrt(((x_M(i)- mean_b(1))^2 + (y_M(j)- mean_b(2))^2));
    end
end
z_M=z_M';
contour(x_M,y_M,z_M,[0, 0],'LineWidth',2,'LineColor','r','DisplayName','MED');
legend('show');