
clear all;
close all;
clc;

mu=[0,0]; 
sigma=[1,0;0,1];
class1=mvnrnd(mu, sigma, 200);
scatter(class1(:,1),class1(:,2));
hold on
mu1=[3,0]; 
sigma1=[1,0;0,1];
class2 = mvnrnd(mu1, sigma1, 200);
scatter(class2(:,1),class2(:,2));
title('Case 1');


%% MED
x = linspace(-4, 6,500);
y = linspace(-4, 4,500);
 
mean1 = mean(class1);
mean2 = mean(class2);
 z= zeros(length(x), length(y));
 
for i = 1:length(x)
    for j = 1:length(y)
        z(i,j) = (x(i)-mean1(1))^2+(y(j)-mean1(2))^2 -...
        ( (x(i)-mean2(1))^2+(y(j)-mean2(2))^2);
    end 
end
z = z';
contour(x,y,z,[0,0],'LineWidth',2,'DisplayName','MED');
%%GED
x1 = linspace(-4, 6, 500);
y1 = linspace(-4, 4, 500);
valClass1A=cov(class1);
valClass1B=cov(class2);
z1 = zeros(length(x1), length(y1));
for i = 1:length(x1)
     for j = 1:length(y1)
         z1(i,j) = ([x1(i) y1(j)]- mean1)*inv(valClass1A)*([x1(i) y1(j)]...
             - mean1)'- ([x1(i) y1(j)]- mean2)*inv(valClass1B)...
             *([x1(i) y1(j)]- mean2)';
             
     end
end
z1 = z1';
contour(x1,y1,z1,[0, 0], 'LineWidth', 2,'LineColor','r','DisplayName','GED'); 
legend('show');
%%MAP
x_m = linspace(-4, 6, 500);
y_m = linspace(-4, 4, 500);
z_m = zeros(length(x_m), length(y_m));
z_m = zeros(length(x_m), length(y_m));
for i = 1:length(x_m)
     for j = 1:length(y_m)  
         z_m(i,j) = 1/(2*pi*(abs(det(sigma)))^0.5)*exp(-0.5*([x_m(i) y_m(j)]...
             - mu)*inv(sigma)*([x_m(i) y_m(j)]- mu)') ...
             - 1/(2*pi*(abs(det(sigma1)))^0.5)*exp(-0.5*([x_m(i) y_m(j)]...
             - mu1)*inv(sigma1)*([x_m(i) y_m(j)]- mu1)');
     end
end
z_m = z_m';
contour(x_m,y_m,z_m,[0, 0], 'LineWidth', 2,'LineColor','b','DisplayName','MAP');

%% unit std
x=-4:0.1:6;
y=gaussmf(x,[1 mu]);
plot(x, y,'DisplayName', 'unit std')