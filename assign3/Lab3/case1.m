%% case1 
clear all;
close all;
clc;
%% 
mu_A=[0 0]; 
sigma_A=[1,0;0,1];
R = chol(sigma_A);
a = repmat(mu_A,200,1) + randn(200,2)*R;
scatter(a(:,1),a(:,2));
hold on; 
mu_B=[3 0];
sigma_B=[1,0;0,1];
R = chol(sigma_B);
b = repmat(mu_B,200,1) + randn(200,2)*R;
scatter(b(:,1),b(:,2));
%% MED
% x_M = linspace(-4, 7, 300);
% y_M = linspace(-4, 4, 300);
% mean_a= mean(a);
% mean_b= mean(b);
% z_M = zeros(length(x_M), length(y_M));
% for i=1:length(x_M)
%     for j=1:length(y_M)
%         z_M(i,j)=sqrt(((x_M(i)-mean_a(1))^2 + (y_M(j)-mean_a(2))^2))-sqrt(((x_M(i)- mean_b(1))^2 + (y_M(j)- mean_b(2))^2));
%     end
% end
% z_M=z_M';
% contour(x_M,y_M,z_M,[0, 0],'LineWidth', 2,'LineColor','r','DisplayName','MED');
%% GED
% x_G = linspace(-4, 7, 300);
% y_G = linspace(-4, 4, 300);
% cov_a=cov(a);
% cov_b=cov(b);
% z_G = zeros(length(x_G), length(y_G));
% for i=1:length(x_G)
%     for j=1:length(y_G)
%         z_G(i,j)=([x_G(i) y_G(j)]- mean_a)*inv(cov_a)*([x_G(i) y_G(j)]- mean_a)'- ([x_G(i) y_G(j)]- mean_b)*inv(cov_b)*([x_G(i) y_G(j)]- mean_b)';
%     end
% end
% z_G=z_G';
% contour(x_G,y_G,z_G,[0, 0], 'LineWidth', 2,'LineColor','b','DisplayName','GED');
%% unit standard deviation
% x_unit_A = linspace(-4, 7, 300);
% y_unit_A = linspace(-4, 4, 300);
% z_unit_A=zeros(length(mu_A),length(mu_A));
% [V_A,D_A]=eig(sigma_A);
% z_unit_A=D_A^(-1/2)*V_A'*mu_A';
% z_unit_A=z_unit_A';
% for i=1:length(x_unit_A)
%     for j=1:length(y_unit_A)
%         z_unit_A_A(i,j)=sqrt(((x_unit_A(i)-z_unit_A(1))^2 + (y_unit_A(j)-z_unit_A(2))^2));
%     end
% end
% z_unit_A_A=z_unit_A_A';
% contour(x_unit_A,y_unit_A,z_unit_A_A,[1, 1], 'LineWidth', 2,'LineColor','g','DisplayName','unit std A');
% 
% x_unit_B = linspace(-4, 7, 300);
% y_unit_B = linspace(-4, 4, 300);
% z_unit_B=zeros(length(mu_B),length(mu_B));
% [V_B,D_B]=eig(sigma_B);
% z_unit_B=D_B^(-1/2)*V_B'*mu_B';
% z_unit_B=z_unit_B';
% for i=1:length(x_unit_B)
%     for j=1:length(y_unit_B)
%         z_unit_B_B(i,j)=sqrt(((x_unit_B(i)-z_unit_B(1))^2 + (y_unit_B(j)-z_unit_B(2))^2));
%     end
% end
% z_unit_B_B=z_unit_B_B';
% contour(x_unit_B,y_unit_B,z_unit_B_B,[1, 1], 'LineWidth', 2,'LineColor','m','DisplayName','unit std B');
%% MAP
% x_MAP = linspace(-4, 7, 300);
% y_MAP = linspace(-4, 4, 300);
% z_MAP = zeros(length(x_MAP), length(y_MAP));
% for i = 1:length(x_MAP)
%      for j = 1:length(y_MAP)      
%          z_MAP(i,j) = 1/(2*pi*(abs(det(sigma_A)))^0.5)*exp(-0.5*([x_MAP(i) y_MAP(j)]- mu_A)*inv(sigma_A)*([x_MAP(i) y_MAP(j)]- mu_A)') - 1/(2*pi*(abs(det(sigma_B)))^0.5)*exp(-0.5*([x_MAP(i) y_MAP(j)]- mu_B)*inv(sigma_B)*([x_MAP(i) y_MAP(j)]- mu_B)');
%      end
% end
% z_MAP = z_MAP';
% contour(x_MAP,y_MAP,z_MAP,[0, 0], 'LineWidth', 2,'LineColor','y','DisplayName','MAP');
% legend('show');
%% NN
%x_N = linspace(-4, 7, 300);
%y_N = linspace(-4, 4, 300);
%z_N = zeros(length(x_N), length(x_N)); %初始化
%z_N_A = zeros(size(a,1), 1); % 200*1的零矩阵 初始化
%z_N_B = zeros(size(b,1), 1); % 200*1的零矩阵
%for i = 1:length(x_N) %300
%    for j = 1:length(y_N) %300
%         for k = 1:size(a,1) %200
%                 z_N_A(k) = (x_N(i)-a(k,1))^2+(y_N(j)-a(k,2))^2; % 网格上的每个点都与a点求距离， 总共300个数据，放入300*1的矩阵
%                 z_N_B(k) = (x_N(i)-b(k,1))^2+(y_N(j)-b(k,2))^2; % 网格上的每个点都与b点求距离      
%         end
%         z_N(i,j) = min(z_N_A)-min(z_N_B);
%    end
%end
%z_N = z_N';
%contour(x_N,y_N,z_N,[0, 0], 'LineWidth', 2,'LineColor','g','DisplayName','NN'); 
%legend('show');
%% 3NN
%x_N = linspace(-4, 7, 300);
% y_N = linspace(-4, 4, 300);
% z_N = zeros(length(x_N), length(x_N)); %初始化
% z_N_A = zeros(size(a,1), 1); % 200*1的零矩阵 初始化
% z_N_B = zeros(size(b,1), 1); % 200*1的零矩阵
% z_N_A_sort = zeros(size(a,1), 1);
% z_N_B_sort = zeros(size(b,1), 1);
% for i = 1:length(x_N) %300
%     for j = 1:length(y_N) %300
%          for k = 1:size(a,1) %200
%                  z_N_A(k) = (x_N(i)-a(k,1))^2+(y_N(j)-a(k,2))^2; % 网格上的每个点都与a点求距离， 总共300个数据，放入300*1的矩阵
%                  z_N_B(k) = (x_N(i)-b(k,1))^2+(y_N(j)-b(k,2))^2; % 网格上的每个点都与b点求距离      
%          end
%          z_N_A_sort=sort(z_N_A);
%          z_N_B_sort=sort(z_N_B);
%          z_N(i,j) = z_N_A_sort(3)-min(z_N_B);
%     end
% end
% z_N = z_N';
% contour(x_N,y_N,z_N,[0, 0], 'LineWidth', 2,'LineColor','g','DisplayName','3NN'); 
% legend('show');
%% 5NN
% x_N = linspace(-4, 7, 300);
% y_N = linspace(-4, 4, 300);
% z_N = zeros(length(x_N), length(x_N)); %初始化
% z_N_A = zeros(size(a,1), 1); % 200*1的零矩阵 初始化
% z_N_B = zeros(size(b,1), 1); % 200*1的零矩阵
% z_N_A_sort = zeros(size(a,1), 1);
% z_N_B_sort = zeros(size(b,1), 1);
% for i = 1:length(x_N) %300
%     for j = 1:length(y_N) %300
%          for k = 1:size(a,1) %200
%                  z_N_A(k) = (x_N(i)-a(k,1))^2+(y_N(j)-a(k,2))^2; % 网格上的每个点都与a点求距离， 总共300个数据，放入300*1的矩阵
%                  z_N_B(k) = (x_N(i)-b(k,1))^2+(y_N(j)-b(k,2))^2; % 网格上的每个点都与b点求距离      
%          end
%          z_N_A_sort=sort(z_N_A);
%          z_N_B_sort=sort(z_N_B);
%          z_N(i,j) = z_N_A_sort(5)-min(z_N_B);
%     end
% end
% z_N = z_N';
% contour(x_N,y_N,z_N,[0, 0], 'LineWidth', 2,'LineColor','g','DisplayName','5NN'); 
% legend('show');