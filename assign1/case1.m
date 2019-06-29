
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
%compute standard deviation contour

syms p q v1 v2 v3 v4
q1=0
q2=0
x01=mean1(1)
y01=mean1(2)
eqn8=det(valClass1A-q*eye(size(valClass1A)))
[q]=solve(eqn8)
q1=q(1,1)
q2=q(2,1)
eqn9=(valClass1A-q1*eye(size(valClass1A)))*v1
eqn10=(valClass1A-q2*eye(size(valClass1A)))*v2
v1=eye(2)
v2=v1
if (q1>=q2)
    aa1=sqrt(q1)
    bb1=sqrt(q2)
    t1=atan(v1(2)/v1(1))
else
    aa1=sqrt(q2)
    bb1=sqrt(q1)
    t1=atan(v2(2)/v2(1))
end

q3=0
q4=0
x02=mean2(1)
y02=mean2(2)
eqn11=det(valClass1B-p*eye(size(valClass1B)))
[p]=solve(eqn11)
q3=p(1,1)
q4=p(2,1)
eqn12=(valClass1B-q3*eye(size(valClass1B)))*v3
eqn13=(valClass1B-q4*eye(size(valClass1B)))*v4
v3=eye(2)
v4=v3
if (q3>=q4)
    aa2=sqrt(q3)
    bb2=sqrt(q4)
    t2=atan(v3(2)/v3(1))
else
    aa2=sqrt(q4)
    bb2=sqrt(q3)
    t2=atan(v4(2)/v4(1))
end

ezplot([(x-x01)*cos(t1)+(y-y01)*sin(t1)]^2/(aa1^2)+[(x-x01)*sin(t1)-(y-y01)*cos(t1)]^2/(bb1^2)-1,[-3,5],[-3,5])%Deviation contour
ezplot([(x-x02)*cos(t2)+(y-y02)*sin(t2)]^2/(aa2^2)+[(x-x02)*sin(t2)-(y-y02)*cos(t2)]^2/(bb2^2)-1,[-3,5],[-3,5])%Deviation contour
legend('Class 1','Class 2','MED','GED','MAP','Standard Deviation Contour');
title('Case1Plot');