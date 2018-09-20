% =========================================================================
% Section 11. For the above classification problem, compute and plot a three dimensional graph
% of the posterior probability of one of the two classes for the Bayes optimal classifier.
% Does the graph match your expectations from theory?
load('distributions.mat');
C1=C;
C2=C;
C_inv=inv(C);

%Bayes classifier boundary (PLANE)
[Y,Z] = meshgrid(-2:6,0:1);
w=2*C_inv *(m2-m1); %L2-6/8
b=m1'*C_inv*m1 - m2'*C_inv*m2 - log(0.5/0.5);
X = (-w(2).*Y-b)/w(1);    
figure(1), clf;
surf(X,Y,Z);
title('Posterior probability', 'FontSize', 16)
xlabel('x1', 'FontSize', 14)
ylabel('x2', 'FontSize', 14)
zlabel('P[w|x]', 'FontSize', 14)
hold on;

% 3D posterior probability
[x,y] = meshgrid(-4:.2:6, -2:.2:6);
P = zeros(size(x)); % posterior probability
% SECOND class
w=2*C_inv *(m2-m1); %L2-6/8
w0=m1'*C_inv*m1 - m2'*C_inv*m2 - log(0.5/0.5);
P = 1 ./ (1 + exp(-(w(1).*x + w(2).*y + w0) ) );
surf(x, y, P); 
% FIRST class
%w=2*C_inv *(m1-m2); %L2-6/8
%w0=m2'*C_inv*m2 - m1'*C_inv*m1 - log(0.5/0.5);
%P = 1 ./ (1 + exp(-(w(1).*x + w(2).*y + w0) ) );
%surf(x, y, P); 



