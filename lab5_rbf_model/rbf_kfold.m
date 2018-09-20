function [ RMSE ] = rbf_kfold( X, y, N, K, K_cv )
    %Implement 20-fold cross validation on the data
    %K_cv = 20;
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
        
%         figure;
%         plot(ytr, yhtr, 'rx', 'LineWidth', 2), grid on
%         title('RBF model', 'FontSize', 16);
%         xlabel('Target', 'FontSize', 14);
%         ylabel('Prediction', 'FontSize', 14);
%         hold on
%         plot(yts, yhts, 'bo', 'LineWidth', 2), grid on
%         return
 
        RMSE(fold,1) = sqrt(mean((ytr - yhtr).^2));
        RMSE(fold,2) = sqrt(mean((yts - yhts).^2));
    end
    
end

