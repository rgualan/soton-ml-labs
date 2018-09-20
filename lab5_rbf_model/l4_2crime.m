% Load Dataset from UCI ML Repository
%
load -ascii communities2.data;
% Normalize the data, zero mean, unit standard deviation
%
housing = communities2;
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


%You can predict the response variable (output variable) f, the house price, from the
%covariates (input variable) by estimating a linear regression:

%Implement 10-fold cross validation on the data and quantify an average prediction error
%and an uncertainty on it.
K_cv = 20;
indices = crossvalind('Kfold',N,K_cv);
RMSE = zeros(K_cv,2);
for i = 1:K_cv
    % split data
    its = (indices == i); % boolean array that 'activates' the test data (indices == i)
    itr = ~its; % the remaining indices are train data
    Yts = Y(its,:);
    Ytr = Y(itr,:);
    fts = f(its);
    ftr = f(itr);
    % train
    w = inv(Ytr'*Ytr)*Ytr'*ftr;
    fhtr = Ytr*w;
    %plot(ftr, fhtr, 'r.', 'LineWidth', 2);
    RMSE(i,1) = sqrt(mean((ftr - fhtr).^2));  % Root Mean Squared Error
    
    % test
    fhts = Yts*w;
    
    % plot
    %figure(1), clf;
    %plot(ftr, fhtr, 'b.', 'LineWidth', 2);
    %hold on;
    %plot(fts, fhts, 'ro', 'LineWidth', 2);
    %return;
    RMSE(i,2) = sqrt(mean((fts - fhts).^2));  % Root Mean Squared Error
end
%display('10-fold-validation');
%display(RMSE);

figure(3), clf, boxplot(RMSE,'Labels',{'Training','Validation'});
title('Linear Regression - 10 fold cross validation', 'FontSize', 14)
xlabel('Stage', 'FontSize', 14)
ylabel('RMSE', 'FontSize', 14)

%Save RMSE for comparison with RBF method
RMSE_lm_crime=RMSE;
save('RMSE_lm_crime','RMSE_lm_crime');