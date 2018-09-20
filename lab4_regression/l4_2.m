% Load Boston Housing Data from UCI ML Repository
%
load -ascii housing.data;
% Normalize the data, zero mean, unit standard deviation
%
[N, p1] = size(housing);
p = p1-1;
Y = [housing(:,1:p) ones(N,1)];
for j=1:p
    Y(:,j)=Y(:,j)-mean(Y(:,j));
    Y(:,j)=Y(:,j)/std(Y(:,j));
end
f = housing(:,p1);
f = f - mean(f);
f = f/std(f);


%Regression using the CVX Tool:
%The least squares regression you have done in the above section can be implemented as
%follows in the cvx tool:
cvx_begin quiet
variable w1( p+1 );
minimize norm( Y*w1 - f )
cvx_end
fh1 = Y*w1;

%Check if the two methods produce the same results.
figure(1), clf,
%plot(w, w1, 'mx', 'LineWidth', 2);
plot(Y*w, Y*w1, 'b.', 'LineWidth', 2);
grid on;
title('Linear Regression: w1 vs w2', 'FontSize', 14)
xlabel('Regression output w1 (10-fold cross-validation)', 'FontSize', 14)
ylabel('Regression output w2 (CVX toolbox)', 'FontSize', 14)
disp('Errors between the models (max):'); disp(max(abs(w1-w)));
disp('Errors between the ouputs (max):'); disp(max(abs(Y*w1-Y*w)));
return;

%Sparse Regression:
iNzero = sparse_regression(Y, f, p, 8.0, 2);
display(iNzero);

%Find out from housing.names which of the variables are selected as relevant to the house
%price prediction problem. Do they appear more relevant than those that were not selected
%as relevant?
%    6. RM        average number of rooms per dwelling
%    11. PTRATIO  pupil-teacher ratio by town
%    13. LSTAT    % lower status of the population

% The amount of regularization is controlled by gamma
% for which I have selected a convenient
% value. Write a program to change this parameter over the range 0:01 ! 40 in 100 steps
% and plot a graph of how the number of non-zero coecients changes with increasing
% regularization.
gammas=linspace(0.01,40,100)';
nonZeros=zeros(100,1);
for i=1:100
    iNzero = sparse_regression(Y, f, p, gammas(i), 2);
    [nonZeros(i), ~] = size(iNzero);
end
figure, clf, plot(gammas,nonZeros,'b-');
title('Sparse Regression', 'FontSize', 14)
xlabel('Gamma', 'FontSize', 14)
ylabel('# non-zero coeficients', 'FontSize', 14)


