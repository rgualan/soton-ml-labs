% Load Dataset from UCI ML Repository
%
load -ascii communities2.data;

dataset = communities2;

% Normalize the data, zero mean, unit standard deviation
[N, p1] = size(dataset);
p = p1-1;
X = [dataset(:,1:p) ones(N,1)]; % Use X instead of Y of the previous lab
for j=1:p
    X(:,j)=X(:,j)-mean(X(:,j));
    X(:,j)=X(:,j)/std(X(:,j));
end
y = dataset(:,p1);
y = y - mean(y);
y = y/std(y);


%Implement K-fold cross validation on the data
K_cv = 20;
indices = crossvalind('Kfold',N,K_cv);
RMSE = zeros(K_cv,2);
for fold = 1:K_cv
    % Split data
    its = (indices == fold); % boolean array that 'activates' the test data (indices == i)
    itr = ~its; % the remaining indices are train data
    Xts = X(its,:);
    Xtr = X(itr,:);
    yts = y(its);
    ytr = y(itr);
    Ntr = size(ytr,1);
    Nts = size(yts,1);

    % TRAIN
    % Calculate a sensible scale sigma
    sigma = norm(Xtr(ceil(rand*Ntr),:)-Xtr(ceil(rand*Ntr),:)); % Avoid the rnd 0 OR 10. Minor correction

    % Perform K-means clustering to find centres for the basis functions
    K = round(Ntr/10);
    %K = 120;
    [idx,C] = kmeans(Xtr,K);
    
    % Construct the design matrix
    A = zeros(Ntr,K);
    for i=1:Ntr
        for j=1:K
            A(i,j)=exp(-norm(Xtr(i,:) - C(j,:))/sigma^2);
        end
    end

    % Solve for the weights
    lambda = A \ ytr;
    
    % What does the model predict at each of the training data?
    yhtr = zeros(Ntr,1);
    u = zeros(K,1);
    for i=1:Ntr
        for j=1:K
            u(j) = exp(-norm(Xtr(i,:) - C(j,:))/sigma^2);
        end
        yhtr(i) = lambda'*u;
    end
    
    % PREDICTION: What does the model predict at each of the TEST data?
    yhts = zeros(Nts,1);
    u = zeros(K,1);
    for i=1:Nts
        for j=1:K
            u(j) = exp(-norm(Xts(i,:) - C(j,:))/sigma^2);
        end
        yhts(i) = lambda'*u;
    end
    
    %plot(ytr, yhtr, 'rx', 'LineWidth', 2), grid on
    %title('RBF Prediction on Training Data', 'FontSize', 16);
    %xlabel('Target', 'FontSize', 14);
    %ylabel('Prediction', 'FontSize', 14);
    %hold on
    %plot(yts, yhts, 'bo', 'LineWidth', 2), grid on

    RMSE(fold,1) = sqrt(mean((ytr - yhtr).^2)); %train
    RMSE(fold,2) = sqrt(mean((yts - yhts).^2)); %test
end

% Compair with the linear model
load('RMSE_lm_crime');
RMSE_c = [RMSE_lm_crime(:,2) RMSE(:,2)];

figure(2), clf, boxplot(RMSE_c,'Labels',{'Linear','RBF'});
title('RMS Prediction Error - 20 fold cross validation', 'FontSize', 14)
xlabel('Model', 'FontSize', 14)
ylabel('RMSE', 'FontSize', 14)

