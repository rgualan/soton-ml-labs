% =========================================================================
% SECTION 2: Generate 100 samples each from two bi-variate Gaussian densities with distinct means
N=500; %100
m1 = [0; 2];
m2 = [1.5; 0];
C = [2 1; 1 2];
A = chol(C);

X=randn(N,2);
Y=randn(N,2);
X=X*A;
Y=Y*A;

%plot(X(:,1),X(:,2),'c.', Y(:,1),Y(:,2),'mx'); return;

% Shift the mean of the distributions (with kron)
X1 = X + kron(ones(N,1), m1');
Y1 = Y + kron(ones(N,1), m2');
%plot(X1(:,1),X1(:,2),'c.', Y1(:,1),Y1(:,2),'mx'); return;

% Save variables for future use
save('distributions.mat','N', 'C', 'm1', 'm2', 'X', 'Y', 'X1','Y1');  % function form