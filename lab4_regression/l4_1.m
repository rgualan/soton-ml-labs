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


%You can predict the response variable (output variable) f, the house price, from the
%covariates (input variable) by estimating a linear regression:

% Least squares regression as pseudo inverse
%
w = inv(Y'*Y)*Y'*f;
fh = Y*w;
figure(1), clf,
plot(f, fh, 'r.', 'LineWidth', 2),
grid on
s=getenv('USERNAME');
xlabel('True House Price', 'FontSize', 14)
ylabel('Prediction', 'FontSize', 14)
title(['Linear Regression: ' s], 'FontSize', 14)

%APPROACH 1: Spliting the data in half for training and testing
%Split the data into a training set and a test set, estimate the regression model (w) on the
%training set and see how training and test errors differ.
[N M] = size(Y);
Ntrain = N/2;
Ytrain = Y(1:Ntrain, :);
Ytest  = Y(Ntrain+1:N, :);
ftrain = f(1:Ntrain);
ftest  = f(Ntrain+1:N);
% Training
w = inv(Ytrain'*Ytrain)*Ytrain'*ftrain;
fhtrain = Ytrain*w;
%figure(2), clf;
%plot(ftrain, fhtrain, 'r.', 'LineWidth', 2);
RMSE = zeros(1,2);
RMSE(1) = sqrt(mean((ftrain - fhtrain).^2));  % Root Mean Squared Error
% Validation
fhtest = Ytest*w;
%hold on;
%plot(ftest, fhtest, 'b.', 'LineWidth', 2);
RMSE(2) = sqrt(mean((ftest - fhtest).^2));  % Root Mean Squared Error
display('Conventional validation (50/50)');
display(RMSE);


%APPROACH 2: Random selecting train and test data from the dataset
% Separate into training and test sets
ii = randperm(N);
Ntr = ceil ( 0.80 * N );  % Amount of data for training
Ytr = Y(ii(1:Ntr),:); % inputs
ftr = f(ii(1:Ntr));  % target
Yts = Y(ii(Ntr+1:N),:); 
fts = f(ii(Ntr+1:N),:);

% Training
w = inv(Ytr'*Ytr)*Ytr'*ftr;
fhtr = Ytr*w;
figure(2), clf;
plot(ftr, fhtr, 'r.', 'LineWidth', 2);
RMSE = zeros(1,2);
RMSE(1) = sqrt(mean((ftr - fhtr).^2));  % Root Mean Squared Error
% Validation
fhts = Yts*w;

hold on;
plot(fts, fhts, 'b.', 'LineWidth', 2);
title('Linear Regression (80% train, 20% test)', 'FontSize', 14)
xlabel('True House Price', 'FontSize', 14)
ylabel('Prediction', 'FontSize', 14)
legend('Training', 'Validation');
RMSE(2) = sqrt(mean((fts - fhts).^2));  % Root Mean Squared Error
display('Conventional validation. Randomly chosen the rows. (80/20)');
display(RMSE);



%Implement 10-fold cross validation on the data and quantify an average prediction error
%and an uncertainty on it.
indices = crossvalind('Kfold',N,10);
RMSE = zeros(10,2);
SEE = zeros(10,2);
models = zeros(14,10);
for i = 1:10
    % split data
    its = (indices == i); % boolean array that 'activates' the test data (indices == i)
    itr = ~its; % the remaining indices are train data
    Yts = Y(its,:);
    Ytr = Y(itr,:);
    fts = f(its);
    ftr = f(itr);
    % train
    w = inv(Ytr'*Ytr)*Ytr'*ftr;
    models(:,i) = w; 
    fhtr = Ytr*w;
    %plot(ftr, fhtr, 'r.', 'LineWidth', 2);
    RMSE(i,1) = sqrt(mean((ftr - fhtr).^2));  % Root Mean Squared Error
    %Standar error of the stimate
    SEE(i,1) = sqrt(((sum(ftr - fhtr))^2)/(size(ftr,1)-2));
    
    % test
    fhts = Yts*w;
    %plot(ftr, fhtr, 'r.', 'LineWidth', 2);
    RMSE(i,2) = sqrt(mean((fts - fhts).^2));  % Root Mean Squared Error
    %Standar error of the stimate
    SEE(i,2) = sqrt(((sum(fts - fhts))^2)/(size(fts,1)-2));
end
display('10-fold-validation');
display(RMSE);
display(SEE);

figure(3), clf, boxplot(RMSE,'Labels',{'Training','Validation'});
title('Linear Regression - 10 fold cross validation', 'FontSize', 14)
xlabel('Stage', 'FontSize', 14)
ylabel('RMSE', 'FontSize', 14)


% Comparative table of RMSE
display('Mean  StDev  Median  Min  Max'); disp([means, stdevs, medians, mins, maxs]);
means = mean(RMSE)';
stdevs = std(RMSE)';
medians = median(RMSE)';
mins = min(RMSE)';
maxs = max(RMSE)';
disp('Statistics of the RMSE:'); disp([means, stdevs, medians, mins, maxs])

% Comparative table of SEE
means = mean(SEE)';
stdevs = std(SEE)';
medians = median(SEE)';
mins = min(SEE)';
maxs = max(SEE)';
disp('Statistics of the SEE:'); disp([means, stdevs, medians, mins, maxs])


%Define the model w as the mean of the ten models
w = mean(models,2);
%figure(4), clf, plot(f, Y*w, 'b.', 'LineWidth', 2);
