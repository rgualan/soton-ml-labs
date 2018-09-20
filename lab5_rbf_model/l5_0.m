% Load Boston Housing Data from UCI ML Repository
%
load -ascii housing.data;

% Normalize the data, zero mean, unit standard deviation
[N, p1] = size(housing);
p = p1-1;
X = [housing(:,1:p) ones(N,1)]; % Use X instead of Y of the previous lab
for j=1:p
    X(:,j)=X(:,j)-mean(X(:,j));
    X(:,j)=X(:,j)/std(X(:,j));
end
y = housing(:,p1);
y = y - mean(y);
y = y/std(y);

%Ntr = size(ytr,1);
%Nts = size(yts,1);
        
%K = round(Ntr/10); 
K = 48; 
K_fold = 20;


%Implement 20-fold cross validation on the data
indices = crossvalind('Kfold',N,K_fold);
RMSE = zeros(K_fold,2);
for fold = 1:K_fold
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
    %K = round(Ntr/10);
    %K = 120;
    [~,C] = kmeans(Xtr,K);
    %display(C)
    %size(idx)
    %size(C)

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

    if fold == 1
        figure(1);
        plot(ytr, yhtr, 'rx', 'LineWidth', 2), grid on
        title('RBF model', 'FontSize', 16);
        xlabel('Target', 'FontSize', 14);
        ylabel('Prediction', 'FontSize', 14);
        hold on
        plot(yts, yhts, 'bo', 'LineWidth', 2), grid on
        legend('training','validation','Location','Best');
    end

    RMSE(fold,1) = sqrt(mean((ytr - yhtr).^2));
    RMSE(fold,2) = sqrt(mean((yts - yhts).^2));
end

figure(2), clf, boxplot(RMSE, 'Labels', {'Training', 'Validation'});
title('RMSE of a RBF model using 20-fold cross-val', 'FontSize', 14)
xlabel('Phase', 'FontSize', 14)
ylabel('RMSE', 'FontSize', 14)




