% =========================================================================
% Section 9
load('distributions.mat');

% Nearest neighbour classifier
% (Caution: The following code is very inefficient)
X = [X1; X2];
N1 = size(X1, 1);
N2 = size(X2, 1);
y = [ones(N1,1); -1*ones(N2,1)];
d = zeros(N1+N2-1,1);
nCorrect = 0;
nIncorrect = 0;
for jtst = 1:(N1+N2)
    % pick a point to test
    %
    xtst = X(jtst,:);
    ytst = y(jtst);
    % All others form the training set
    %
    jtr = setdiff(1:N1+N2, jtst);
    Xtr = X(jtr,:);
    ytr = y(jtr,1);
    % Compute all distances from test to training points
    %
    for i=1:(N1+N2-1)
        d(i) = norm(Xtr(i,:)-xtst);
    end
    % Which one is the closest?
    %
    [imin] = find(d == min(d));
    % Does the nearest point have the same class label?
    %
    if ( ytr(imin(1)) * ytst > 0 )
        nCorrect = nCorrect + 1;
    else
        %disp('Incorrect classification');
        nIncorrect = nIncorrect + 1;
    end
end
display(nIncorrect);

% Percentage correst
%
pCorrect = nCorrect*100/(N1+N2);
disp(['Nearest neighbour accuracy: ' num2str(pCorrect)]);