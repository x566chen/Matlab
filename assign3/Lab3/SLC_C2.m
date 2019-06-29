%% SLC_C2
close all;    
clear all;  
clc;    
load assign32018.mat;
id_a=randperm(200,50);
a_c2=a(id_a,:);
id_b=randperm(200,50);
b_c2=b(id_b,:);
%%
classA=a_c2;
classB=b_c2;
Class = [a; b];
Class(1:200, 3) = 1;
Class(201:400, 3) = 2;
z = zeros(length(Class),2);
z(1:200,1)= Class(1:200, 3);
z(201:400,1)= Class(201:400, 3);
for n = 1:200
    sampleA = classA;
    sampleB = classB;
    % get rid of 1 data
    sampleA(n,:) = 0;
    sampleB(n,:) = 0;
    sample = [sampleA;sampleB];
    % calculate the mean of sample A
    meanClassA = mean(classA);
    meanClassB = mean(classB);
    
    z(n,2) = (Class(n,1)- meanClassA(1))^2 + (Class(n,2)- meanClassA(2))^2 ...
        - ((Class(n,1)- meanClassB(1))^2 + (Class(n,2)- meanClassB(2))^2);
    
    z(n+200,2) = (Class(n+200,1)- meanClassA(1))^2 + (Class(n+200,2)- meanClassA(2))^2 ...
        - ((Class(n+200,1)- meanClassB(1))^2 + (Class(n+200,2)- meanClassB(2))^2);
    if z(n,2)>0
        z(n,2) = 2;
    else
        z(n,2) = 1;
    end
    
    if z(n+200,2)>0
        z(n+200,2) = 2;
    else
        z(n+200,2) = 1;
    end
end
    
id_row_error = find(z(:,1)~=z(:,2));
error_classified = Class(id_row_error,:);
id_row_error_num=randperm(length(error_classified),length(error_classified)/2);
select_error=error_classified(id_row_error_num,:);
a_error_c2 = find(select_error(:,3)==1);
b_error_c2 = find(select_error(:,3)==2);
a_error_c2 = select_error(a_error_c2,1:2);
b_error_c2 = select_error(b_error_c2,1:2);

id_row_right = find(z(:,1)==z(:,2));
right_classified = Class(id_row_right,:);
id_row_right_num=randperm(length(right_classified),length(error_classified)/2);
select_right=right_classified(id_row_right_num,:);
a_right_c2 = find(select_right(:,3)==1);
b_right_c2 = find(select_right(:,3)==2);
a_right_c2 = select_right(a_right_c2,1:2);
b_right_c2 = select_right(b_right_c2,1:2);

a_d2_c2 = [a_error_c2;a_right_c2];%D2 A
b_d2_c2 = [b_error_c2;b_right_c2];%D2 B
%% Q
classA_d2=a_d2_c2;
classB_d2=b_d2_c2;
error_SLC = zeros(10,1);
mean_a_plot = zeros(10,2);
mean_b_plot = zeros(10,2);
for k = 1:10
    id_r_a=randperm(length(a_d2_c2),1);
    mean_a=a_d2_c2(id_r_a,:);
    id_r_b=randperm(length(b_d2_c2),1);
    mean_b=b_d2_c2(id_r_b,:);
    mean_a_plot(k,:)=mean_a;
    mean_b_plot(k,:)=mean_b;
    z_d2_a = zeros(length(classA_d2),1);
    z_d2_b = zeros(length(classB_d2),1);
    %Class_d2 = [classA_d2; classB_d2];
    % add labels
%     Class_d2(1:length(a_d2_c2), 3) = 1;
%     Class_d2(length(a_d2_c2)+1:length(Class_d2), 3) = 2;
    for n_d2_a = 1:length(classA_d2)
        meanClassA_d2 = mean_a;
        meanClassB_d2 = mean_b;
        z_d2_a(n_d2_a) = (classA_d2(n_d2_a,1)- meanClassA_d2(1))^2 + (classA_d2(n_d2_a,2)- meanClassA_d2(2))^2 ...
                    - ((classA_d2(n_d2_a,1)- meanClassB_d2(1))^2 + (classA_d2(n_d2_a,2)- meanClassB_d2(2))^2);
        if z_d2_a(n_d2_a)>0
                 z_d2_a(n_d2_a) = 2;
             else
                 z_d2_a(n_d2_a) = 1;
        end
    end
        
    for n_d2_b = 1:length(classB_d2)
         meanClassA_d2 = mean_a;
         meanClassB_d2 = mean_b;
         z_d2_b(n_d2_b) = (classB_d2(n_d2_b,1)- meanClassA_d2(1))^2 + (classB_d2(n_d2_b,2)- meanClassA_d2(2))^2 ...
                     - ((classB_d2(n_d2_b,1)- meanClassB_d2(1))^2 + (classB_d2(n_d2_b,2)- meanClassB_d2(2))^2);
         if z_d2_b(n_d2_b)>0
                z_d2_b(n_d2_b) = 2;
         else
                z_d2_b(n_d2_b) = 1;
         end
    end
    z_d2_all(:,2)=[z_d2_a;z_d2_b];
    z_d2_all(1:length(classA_d2),1)=1;
    z_d2_all(length(classA_d2)+1:length(classA_d2)+length(classB_d2),1)=2;
    diff=find(z_d2_all(:,1)~=z_d2_all(:,2));
    errMED = length(diff)/length(z_d2_all);
    error_SLC(k,1) = errMED;
end
min_of_error_SLC=min(error_SLC);
id_row = find(error_SLC==min(error_SLC));

%%
mean_a_plot = mean_a_plot(id_row,:);
mean_b_plot = mean_b_plot(id_row,:);

%% MED_use_d2
x_M = linspace(150, 475, 500);
y_M = linspace(0, 350, 500);

z_M = zeros(length(x_M), length(y_M));
for i=1:length(x_M)
    for j=1:length(y_M)
        z_M(i,j)=sqrt(((x_M(i)-mean_a_plot(1))^2 + (y_M(j)-mean_a_plot(2))^2))-sqrt(((x_M(i)- mean_b_plot(1))^2 + (y_M(j)- mean_b_plot(2))^2));
    end
end
z_M=z_M';
scatter(a_d2_c2(:,1),a_d2_c2(:,2),'*','DisplayName','A');
hold on;
scatter(b_d2_c2(:,1),b_d2_c2(:,2),'DisplayName','B');
contour(x_M,y_M,z_M,[0, 0],'LineWidth',2,'LineColor','r','DisplayName','MED');
legend('show');