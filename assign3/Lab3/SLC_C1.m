%% SLC_C1
close all;    
clear all;  
clc;    
load assign32018.mat;
id_a=randperm(200,50);
a_r=a(id_a,:);
id_b=randperm(200,50);
b_r=b(id_b,:);
scatter(a_r(:,1),a_r(:,2),'*','DisplayName','A');
hold on;
scatter(b_r(:,1),b_r(:,2),'DisplayName','B');
%% SLC
% id_r_a=randperm(200,1);
% mean_a=a(id_r_a,:);
% id_r_b=randperm(200,1);
% mean_b=b(id_r_b,:);
% x_M = linspace(150, 520, 500);
% y_M = linspace(0, 350, 500);
% z_M = zeros(length(x_M), length(y_M));
% for i=1:length(x_M)
%     for j=1:length(y_M)
%         z_M(i,j)=sqrt(((x_M(i)-mean_a(1))^2 + (y_M(j)-mean_a(2))^2))-sqrt(((x_M(i)- mean_b(1))^2 + (y_M(j)- mean_b(2))^2));
%     end
% end
% z_M=z_M';
% contour(x_M,y_M,z_M,[0, 0],'LineWidth', 2,'LineColor','r','DisplayName','MED');
% legend('show');
%% errorSLC
classA=a_r;
classB=b_r;
error_SLC = zeros(10,1);
mean_a_plot = zeros(10,2);
mean_b_plot = zeros(10,2);
for k = 1:10
    id_r_a=randperm(200,1);
    mean_a=a(id_r_a,:);
    id_r_b=randperm(200,1);
    mean_b=b(id_r_b,:);
    mean_a_plot(k,:)=mean_a;
    mean_b_plot(k,:)=mean_b;
    
    Class = [classA; classB];
    % add labels
    Class(1:50, 3) = 1;
    Class(51:100, 3) = 2;
    z = zeros(length(Class),1);
    for n = 1:50
        sampleA = classA;
        sampleB = classB;
        % get rid of 1 data 
        sampleA(n,:) = 0;
        sampleB(n,:) = 0;
        sample = [sampleA;sampleB];
        % calculate the mean of sample A
        meanClassA = mean_a;
        meanClassB = mean_b;
        z(n) = (Class(n,1)- meanClassA(1))^2 + (Class(n,2)- meanClassA(2))^2 ...
                    - ((Class(n,1)- meanClassB(1))^2 + (Class(n,2)- meanClassB(2))^2);

        z(n+50) = (Class(n+50,1)- meanClassA(1))^2 + (Class(n+50,2)- meanClassA(2))^2 ...
                    - ((Class(n+50,1)- meanClassB(1))^2 + (Class(n+50,2)- meanClassB(2))^2);
           if z(n)>0
                    z(n) = 2;
                else
                    z(n) = 1;
           end

           if z(n+50)>0
                    z(n+50) = 2;
                else
                    z(n+50) = 1;
           end
    end
    errMED = sum(abs(z(1:50)-1)+abs(z(51:100)-2))/100;
    error_SLC(k,1) = errMED;
end
min_of_error_SLC=min(error_SLC)
id_row = find(error_SLC==min(error_SLC))
%%
mean_a_plot = mean_a_plot(id_row,:);
mean_b_plot = mean_b_plot(id_row,:);
 
x_M = linspace(150, 520, 500);
y_M = linspace(0, 350, 500);
z_M = zeros(length(x_M), length(y_M));
for i=1:length(x_M)
    for j=1:length(y_M)
        z_M(i,j)=sqrt(((x_M(i)-mean_a_plot(1))^2 + (y_M(j)-mean_a_plot(2))^2))-sqrt(((x_M(i)- mean_b_plot(1))^2 + (y_M(j)- mean_b_plot(2))^2));
    end
end
z_M=z_M';
contour(x_M,y_M,z_M,[0, 0],'LineWidth', 2,'LineColor','r','DisplayName','SLC');
legend('show');