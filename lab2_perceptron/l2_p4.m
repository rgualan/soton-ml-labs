% From the previous part, we have two matrices (Nx2) X1 and Y1
load('distributions.mat');
%X1(:,2)= X1(:,2)+2 % trick
%Y1(:,2)= Y1(:,2)-2; % trick
plot(X1(:,1),X1(:,2),'c.', Y1(:,1),Y1(:,2),'mx'); axis([-5 6 -5 6]);
%axis([-3 5 -5 7]); 


% X1 -> Y=+1 (1st class)
% Y1 -> Y=-1 (2nd class)
X = [ X1; 
      Y1];
y = [ ones(N,1); 
      -1*ones(N,1)];
N=2*N; % New N due two the matrix concatenation


% X N by 2 matrix of data
% y classlabels -1 or +1
% include column of ones for bias
X = [X ones(N,1)];

% Separate into training and test sets
ii = randperm(N);
Ntr = ceil ( 0.60 * N );  % Amount of data for training
Xtr = X(ii(1:Ntr),:); 
%ytr = X(ii(1:N/2),:); % I think this is wrong. Review later
ytr = y(ii(1:Ntr),:); % Correction
Xts = X(ii(Ntr+1:N),:);
yts = y(ii(Ntr+1:N),:);

% initialize weights
w = randn(3,1);
plot_vector_line(w,1);


% Error correcting learning
%eta = 0.001;
eta = 0.001;
for iter=1:5000
  j = ceil(rand*Ntr);
  
  if ( ytr(j)*Xtr(j,:)*w < 0 )
    w = w + eta * ytr(j) * Xtr(j,:)';
  end
 
  %compute output: Y = W*X + b, then apply threshold activation
  %output = ( w' * Xtr(j,:)' >= 0 );
  %output = w' * Xtr(j,:)';
  %err = ytr(j) - output;
  %w = w + eta * err * Xtr(j,:)';

  if ( mod(iter,10) == 0)
	plot_vector_line(w);
  end
  
end

% Performance on test data
yhts = Xts*w;
disp([yts yhts]);
Nts=size(yts,1); % Addition
PercentageError = 100 * size(find(yts .* yhts < 0),1)/Nts;
display(PercentageError);

plot_vector_line(w,2);

% Print line equation info
display('Slope:');
disp(-w(1,1)/w(2,1));
display('Bias:');
disp(-w(3,1)/w(2,1));
