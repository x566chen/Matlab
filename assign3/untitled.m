close all;
clear all; 
load('assign3 2018.mat');

%% regular selected-linear classifier
q = 10;

selected_a = datasample(a,q,'Replace',false);
selected_b = datasample(b,q,'Replace',false);
errors = [];

for i = 1:10
    mu_a = selected_a(i,:);
    mu_b = selected_b(i,:);
    q_wrong = 0;
    
    for j = 1:200
        if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end

        if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end
    end
    errors = [errors,q_wrong/400];
end

[M,I] = min(errors);
sl_mu_a = selected_a(I,:);
sl_mu_b = selected_b(I,:);
sl_P_error = M

%% choosing d1
d1_a = datasample(a,50,'Replace',false);
d1_b = datasample(b,50,'Replace',false); 

%% train c1 using d1
q = 10;
selected_a = datasample(d1_a,q,'Replace',false);
selected_b = datasample(d1_b,q,'Replace',false);
errors = [];

for i = 1:10
    mu_a = selected_a(i,:);
    mu_b = selected_b(i,:);
    q_wrong = 0;
    
    for j = 1:200
        if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end

        if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end
    end
    errors = [errors,q_wrong/400];
end

[M,I] = min(errors);
c1_mu_a = selected_a(I,:);
c1_mu_b = selected_b(I,:);
c1_P_error = M
%% classify by c1 and create d2
c1_a_correct = [];
c1_a_incorrect = [];
c1_b_correct = [];
c1_b_incorrect = [];   
c1_a_wrong = 0;
c1_b_wrong = 0;

for j = 1:200
    if ((a(j,:)-c1_mu_a)*(a(j,:)-c1_mu_a)') > ((a(j,:)-c1_mu_b)*(a(j,:)-c1_mu_b)')
        c1_a_wrong = c1_a_wrong + 1;
        c1_a_incorrect = [c1_a_incorrect;a(j,:)];
    else
        c1_a_correct = [c1_a_correct;a(j,:)];
    end

    if ((b(j,:)-c1_mu_a)*(b(j,:)-c1_mu_a)') < ((b(j,:)-c1_mu_b)*(b(j,:)-c1_mu_b)')
        c1_b_wrong = c1_b_wrong + 1;
        c1_b_incorrect = [c1_b_incorrect;b(j,:)];
    else
        c1_b_correct = [c1_b_correct;b(j,:)];
    end
end

c1_wrong = c1_a_wrong + c1_b_wrong;

d2_a = datasample(c1_a_correct,floor(c1_a_wrong/2),'Replace',false);
d2_a = [d2_a;datasample(c1_a_incorrect,floor(c1_a_wrong/2),'Replace',false)];

d2_b = datasample(c1_b_correct,ceil(c1_b_wrong/2),'Replace',false);
d2_b = [d2_b;datasample(c1_b_incorrect,ceil(c1_b_wrong/2),'Replace',false)];

%% train c2 using d2
if q < size(selected_a,1)
	selected_a = datasample(d2_a,q,'Replace',false);
else
	selected_a = datasample(d2_a,q,'Replace',true);
end

if q < size(selected_b,1)
	selected_b = datasample(d2_b,q,'Replace',false);
else
	selected_b = datasample(d2_b,q,'Replace',true);
end

errors = [];
for i = 1:10
    mu_a = selected_a(i,:);
    mu_b = selected_b(i,:);
    q_wrong = 0;
    
    for j = 1:200
        if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end

        if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end
    end
    errors = [errors,q_wrong/400];
end

[M,I] = min(errors);
c2_mu_a = selected_a(I,:);
c2_mu_b = selected_b(I,:);
c2_P_error = M
%% selecting d3 using c1 and c2
c2_a_incorrect = [];
c2_b_incorrect = [];
c2_a_wrong = 0;
c2_b_wrong = 0;

for j = 1:200
    if (((a(j,:)-c1_mu_a)*(a(j,:)-c1_mu_a)') > ((a(j,:)-c1_mu_b)*(a(j,:)-c1_mu_b)')) && (((a(j,:)-c2_mu_a)*(a(j,:)-c2_mu_a)') < ((a(j,:)-c2_mu_b)*(a(j,:)-c2_mu_b)'))
        c2_a_wrong = c2_a_wrong + 1;
        c2_a_incorrect = [c2_a_incorrect;a(j,:)];
    end

    if (((a(j,:)-c1_mu_a)*(a(j,:)-c1_mu_a)') < ((a(j,:)-c1_mu_b)*(a(j,:)-c1_mu_b)')) && (((a(j,:)-c2_mu_a)*(a(j,:)-c2_mu_a)') > ((a(j,:)-c2_mu_b)*(a(j,:)-c2_mu_b)'))
        c2_a_wrong = c2_a_wrong + 1;
        c2_a_incorrect = [c2_a_incorrect;a(j,:)];
    end
    
    if (((b(j,:)-c1_mu_a)*(b(j,:)-c1_mu_a)') > ((b(j,:)-c1_mu_b)*(b(j,:)-c1_mu_b)')) && (((b(j,:)-c2_mu_a)*(b(j,:)-c2_mu_a)') < ((b(j,:)-c2_mu_b)*(b(j,:)-c2_mu_b)'))
        c2_b_wrong = c2_b_wrong + 1;
        c2_b_incorrect = [c2_b_incorrect;b(j,:)];
    end

    if (((b(j,:)-c1_mu_a)*(b(j,:)-c1_mu_a)') < ((b(j,:)-c1_mu_b)*(b(j,:)-c1_mu_b)')) && (((b(j,:)-c2_mu_a)*(b(j,:)-c2_mu_a)') > ((b(j,:)-c2_mu_b)*(b(j,:)-c2_mu_b)'))
        c2_b_wrong = c2_b_wrong + 1;
        c2_b_incorrect = [c2_b_incorrect;b(j,:)];
    end
    
end
d3_a = c2_a_incorrect;
d3_b = c2_b_incorrect;

%% train c3 using d3
if q < size(selected_a,1)
	selected_a = datasample(d3_a,q,'Replace',false);
else
	selected_a = datasample(d3_a,q,'Replace',true);
end

if q < size(selected_b,1)
	selected_b = datasample(d3_b,q,'Replace',false);
else
	selected_b = datasample(d3_b,q,'Replace',true);
end

errors = [];
for i = 1:10
    mu_a = selected_a(i,:);
    mu_b = selected_b(i,:);
    q_wrong = 0;
    
    for j = 1:200
        if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end

        if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
            q_wrong = q_wrong + 1;
        end
    end
    errors = [errors,q_wrong/400];
end
[M,I] = min(errors);
c3_mu_a = selected_a(I,:);
c3_mu_b = selected_b(I,:);
c3_P_error = M
%% majority vote for C1,C2,C3
boosting_sl_wrong = 0;
for j = 1:200
    c1_a_a = (a(j,:)-c1_mu_a)*(a(j,:)-c1_mu_a)';
    c1_a_b = (a(j,:)-c1_mu_b)*(a(j,:)-c1_mu_b)';
    c2_a_a = (a(j,:)-c2_mu_a)*(a(j,:)-c2_mu_a)';
    c2_a_b = (a(j,:)-c2_mu_b)*(a(j,:)-c2_mu_b)';
    c3_a_a = (a(j,:)-c3_mu_a)*(a(j,:)-c3_mu_a)';
    c3_a_b = (a(j,:)-c3_mu_b)*(a(j,:)-c3_mu_b)';
    
    if (c1_a_a>c1_a_b & c2_a_a>c2_a_b) | (c1_a_a>c1_a_b & c3_a_a>c3_a_b) | (c2_a_a>c2_a_b & c3_a_a>c3_a_b)
        boosting_sl_wrong = boosting_sl_wrong + 1;
    end
    
    c1_b_a = (b(j,:)-c1_mu_a)*(b(j,:)-c1_mu_a)';
    c1_b_b = (b(j,:)-c1_mu_b)*(b(j,:)-c1_mu_b)';
    c2_b_a = (b(j,:)-c2_mu_a)*(b(j,:)-c2_mu_a)';
    c2_b_b = (b(j,:)-c2_mu_b)*(b(j,:)-c2_mu_b)';
    c3_b_a = (b(j,:)-c3_mu_a)*(b(j,:)-c3_mu_a)';
    c3_b_b = (b(j,:)-c3_mu_b)*(b(j,:)-c3_mu_b)';
    
    if (c1_b_a<c1_b_b & c2_b_a<c2_b_b) | (c1_b_a<c1_b_b & c3_b_a<c3_b_b) | (c2_b_a<c2_b_b & c3_b_a<c3_b_b)
        boosting_sl_wrong = boosting_sl_wrong + 1;
    end
end

boosting_P_error = boosting_sl_wrong/400

plot(a(:,1),a(:,2),'+');
hold
plot(b(:,1),b(:,2),'o');

syms x y 
z=[x,y];
sl_boundary = (((z-sl_mu_a)*(z-sl_mu_a)') - ((z-sl_mu_b)*(z-sl_mu_b)'));
c1_boundary = (((z-c1_mu_a)*(z-c1_mu_a)') - ((z-c1_mu_b)*(z-c1_mu_b)'));
c2_boundary = (((z-c2_mu_a)*(z-c2_mu_a)') - ((z-c2_mu_b)*(z-c2_mu_b)'));
c3_boundary = (((z-c3_mu_a)*(z-c3_mu_a)') - ((z-c3_mu_b)*(z-c3_mu_b)'));


line0 = ezplot(sl_boundary==0,[0,500],[0,350]);
set(line0,'color','y','Linewidth',1);

line1 = ezplot(c1_boundary==0,[0,500],[0,350]);
set(line1,'color','k','Linewidth',1);

line2 = ezplot(c2_boundary==0,[0,500],[0,350]);
set(line2,'color','g','Linewidth',1);

line3 = ezplot(c3_boundary==0,[0,500],[0,350]);
set(line3,'color','b','Linewidth',1);

x = 0:500;
y = 0:350;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xy=[x(m),y(n)]; 
		    c1_a_a = (xy-c1_mu_a)*(xy-c1_mu_a)';
		    c1_a_b = (xy-c1_mu_b)*(xy-c1_mu_b)';
		    c2_a_a = (xy-c2_mu_a)*(xy-c2_mu_a)';
		    c2_a_b = (xy-c2_mu_b)*(xy-c2_mu_b)';
		    c3_a_a = (xy-c3_mu_a)*(xy-c3_mu_a)';
		    c3_a_b = (xy-c3_mu_b)*(xy-c3_mu_b)';
		    if (c1_a_a>c1_a_b & c2_a_a>c2_a_b) | (c1_a_a>c1_a_b & c3_a_a>c3_a_b) | (c2_a_a>c2_a_b & c3_a_a>c3_a_b)
		        Z(n,m) = 1;
		    else
		    	Z(n,m) = 0;
            end
        end
    end
%figure;
contour(X,Y,Z,'r','LineWidth',1.5);

legend('Class a','Class b','Regular SL','C1','C2','C3','decision boundary');
title('Classifier boosting selected linear');