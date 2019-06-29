%% case4
close all;    
clear all;  
clc;    
load assign2.mat;
scatter(a(:,1),a(:,2));
hold on;
scatter(b(:,1),b(:,2));
%% MED
x_M = linspace(150, 500, 500);
y_M = linspace(0, 300, 500);
mean_a= mean(a);
mean_b= mean(b);
z_M = zeros(length(x_M), length(y_M));
for i=1:length(x_M)
    for j=1:length(y_M)
        z_M(i,j)=sqrt(((x_M(i)-mean_a(1))^2 + (y_M(j)-mean_a(2))^2))-sqrt(((x_M(i)- mean_b(1))^2 + (y_M(j)- mean_b(2))^2));
    end
end
z_M=z_M';
contour(x_M,y_M,z_M,[0, 0],'LineWidth', 2,'LineColor','r','DisplayName','MED');
%% GED
x_G = linspace(150, 500, 500);
y_G = linspace(0, 300, 500);
cov_a=cov(a);
cov_b=cov(b);
z_G = zeros(length(x_G), length(y_G));
for i=1:length(x_G)
    for j=1:length(y_G)
        z_G(i,j)=([x_G(i) y_G(j)]- mean_a)*inv(cov_a)*([x_G(i) y_G(j)]- mean_a)'- ([x_G(i) y_G(j)]- mean_b)*inv(cov_b)*([x_G(i) y_G(j)]- mean_b)';
    end
end
z_G=z_G';
contour(x_G,y_G,z_G,[0, 0], 'LineWidth', 2,'LineColor','b','DisplayName','GED');
legend('show');