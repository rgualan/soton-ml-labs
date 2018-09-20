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

Ntr = size(ytr,1);
Nts = size(yts,1);
        
K_array = [5 20 30 round(Ntr/10) 60 80 200 300]'; % First value=default=46
K_fold = 20;
Nk = size(K_array,1);
%RMSE_all = zeros(Nk,K_fold,2);
%RMSE_all = zeros(Nk*2,K_fold);
RMSE_all = zeros(K_fold,Nk*2);
labels = cell(Nk,1);
%labels = zeros(20,2);
for i = 1: Nk
    RMSE = rbf_kfold( X, y, N, K_array(i), K_fold );
    RMSE_all(:,2*i-1:2*i) = RMSE;
    labels{2*i-1} = strcat( num2str(K_array(i)),  '-Tr' );
    labels{2*i}   = strcat( num2str(K_array(i)), '-Ts');
end

figure(1), clf, boxplot(RMSE_all, 'Labels', labels);
title('RMS (train, test) per different # basis functions (K) ', 'FontSize', 14)
xlabel('# basis functions (training, test)', 'FontSize', 14)
ylabel('RMSE', 'FontSize', 14)




