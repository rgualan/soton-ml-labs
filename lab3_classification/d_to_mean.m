function d_to_mean( X1, X2, m1, m2, C1, C2, method )
%D_TO_MEAN Summary of this function goes here
%   Detailed explanation goes here

    if ~exist('method','var')
        method = 1;
        % 1 euclidean distance
        % 2 Mahalanobis distance
    end
    
    % Distance to mean classifier
    X = [X1; X2];
    N1 = size(X1, 1);
    N2 = size(X2, 1);
    y = [ones(N1,1); -1*ones(N2,1)];
    nCorrect = 0;
    nIncorrect = 0;
    for index = 1:(N1+N2)
        if method == 1
            % euclidian distance
            d1 = norm(X(index,:)-m1');
            d2 = norm(X(index,:)-m2');
        else
            % (x - m1)t C-1 (x-m1)
            d1 = (X(index,:)'-m1)'*inv(C1)*(X(index,:)'-m1);
            d2 = (X(index,:)'-m2)'*inv(C2)*(X(index,:)'-m2);
        end
        if (d1 < d2 && y(index) > 0 )
            nCorrect = nCorrect + 1;
        elseif (d2 < d1 && y(index) < 0 )
            nCorrect = nCorrect + 1;
        else
            nIncorrect = nIncorrect + 1;
        end
    end
    display(nIncorrect);

    % Percentage correst
    %
    pCorrect = nCorrect*100/(N1+N2);
    disp(['Distance to mean accuracy: ' num2str(pCorrect)]);
end

