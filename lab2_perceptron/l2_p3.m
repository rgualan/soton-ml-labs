% =========================================================================
% SECTION 2: Compute the Bayes' optimal class boundary

% load variables
load('distributions.mat');

% plot distributions
plot(X1(:,1),X1(:,2),'c.', Y1(:,1),Y1(:,2),'mx'); axis([-5 6 -5 6]);

%Boundary - Bayes classifier
%w' x + b = 0
Cinv=inv(C);
w=2*Cinv*(m2-m1);
display(w);
b=(m1'*Cinv*m1 - m2'*Cinv*m2) - log(0.5/0.5);
display(b);
% plot classifier
x=linspace(-5,6);
y=(-w(1,1)*x-b)/w(2,1);
hold on;
plot(x,y);
hold off;
print -djpeg img/sep_bayes.jpg


% Print line equation info
display('Slope:');
disp(-w(1,1)/w(2,1));
display('Bias:');
disp(-b/w(2,1));

