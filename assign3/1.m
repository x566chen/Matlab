%% selected linear methods
close all;
clear all; 
load('assign3 2017.mat');

%% regular MED classifier
mu_a = mean(a);
mu_b = mean(b);

wrong = 0;
for j = 1:200
    if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
        wrong = wrong + 1;
    end

    if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
        wrong = wrong + 1;
    end
end
wrong
MED_error = wrong/400

%% chossing d1
d1_a = datasample(a,50,'Replace',false);
d1_b = datasample(b,50,'Replace',false); 

%% train c1 using d1
c1_mu_a = mean(d1_a);
c1_mu_b = mean(d1_b);

%% classify by c1 and create d2
c1_a_correct = [];
c1_a_incorrect = [];
c1_b_correct = [];
c1_b_incorrect = [];
c1_a_wrong = 0;
c1_b_wrong = 0;
for j = 1:200
    if ((a(j,:)-mu_a)*(a(j,:)-mu_a)') > ((a(j,:)-mu_b)*(a(j,:)-mu_b)')
        c1_a_wrong = c1_a_wrong + 1;
        c1_a_incorrect = [c1_a_incorrect;a(j,:)];
    else
        c1_a_correct = [c1_a_correct;a(j,:)];
    end

    if ((b(j,:)-mu_a)*(b(j,:)-mu_a)') < ((b(j,:)-mu_b)*(b(j,:)-mu_b)')
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



%% using d2 to train c2
c2_mu_a = mean(d2_a);
c2_mu_b = mean(d2_b);

%% using c1 and c2 to get d3
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

%% using d3 to train c3
c3_mu_a = mean(d3_a);
c3_mu_b = mean(d3_b);

%% majority vote for C1,C2,C3
boosting_med_wrong = 0;
for j = 1:200
    c1_a_a = (a(j,:)-c1_mu_a)*(a(j,:)-c1_mu_a)';
    c1_a_b = (a(j,:)-c1_mu_b)*(a(j,:)-c1_mu_b)';
    c2_a_a = (a(j,:)-c2_mu_a)*(a(j,:)-c2_mu_a)';
    c2_a_b = (a(j,:)-c2_mu_b)*(a(j,:)-c2_mu_b)';
    c3_a_a = (a(j,:)-c3_mu_a)*(a(j,:)-c3_mu_a)';
    c3_a_b = (a(j,:)-c3_mu_b)*(a(j,:)-c3_mu_b)';
    
    if (c1_a_a>c1_a_b & c2_a_a>c2_a_b) | (c1_a_a>c1_a_b & c3_a_a>c3_a_b) | (c2_a_a>c2_a_b & c3_a_a>c3_a_b)
        boosting_med_wrong = boosting_med_wrong + 1;
    end
    
    c1_b_a = (b(j,:)-c1_mu_a)*(b(j,:)-c1_mu_a)';
    c1_b_b = (b(j,:)-c1_mu_b)*(b(j,:)-c1_mu_b)';
    c2_b_a = (b(j,:)-c2_mu_a)*(b(j,:)-c2_mu_a)';
    c2_b_b = (b(j,:)-c2_mu_b)*(b(j,:)-c2_mu_b)';
    c3_b_a = (b(j,:)-c3_mu_a)*(b(j,:)-c3_mu_a)';
    c3_b_b = (b(j,:)-c3_mu_b)*(b(j,:)-c3_mu_b)';
    
    if (c1_b_a<c1_b_b & c2_b_a<c2_b_b) | (c1_b_a<c1_b_b & c3_b_a<c3_b_b) | (c2_b_a<c2_b_b & c3_b_a<c3_b_b)
        boosting_med_wrong = boosting_med_wrong + 1;
    end
end

boosting_MED_error = boosting_med_wrong/400

plot(a(:,1),a(:,2),'b*');
hold
plot(b(:,1),b(:,2),'ro');

syms x y 
z=[x,y];
med_boundary = (((z-mu_a)*(z-mu_a)') - ((z-mu_b)*(z-mu_b)'));
c1_boundary = (((z-c1_mu_a)*(z-c1_mu_a)') - ((z-c1_mu_b)*(z-c1_mu_b)'));
c2_boundary = (((z-c2_mu_a)*(z-c2_mu_a)') - ((z-c2_mu_b)*(z-c2_mu_b)'));
c3_boundary = (((z-c3_mu_a)*(z-c3_mu_a)') - ((z-c3_mu_b)*(z-c3_mu_b)'));


line0 = ezplot(med_boundary==0,[0,500],[0,350]);
set(line0,'color','k','Linewidth',1);

line1 = ezplot(c1_boundary==0,[0,500],[0,350]);
set(line1,'color','y','Linewidth',1);

line2 = ezplot(c2_boundary==0,[0,500],[0,350]);
set(line2,'color','b','Linewidth',1);

line3 = ezplot(c3_boundary==0,[0,500],[0,350]);
set(line3,'color','g','Linewidth',1);

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

legend('Class a','Class b','Regular med','C1','C2','C3','decision boundary');
title('Classifier boosting MED');