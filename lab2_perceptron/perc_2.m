%# load your data
input = [
    0.832 64.643
    0.818 78.843
    1.776 45.049
    0.597 88.302
    1.412 63.458
];
target = [
    0 0 1
    0 0 1
    0 1 0
    0 0 1
    0 0 1
];

%# parameters of the learning algorithm
LEARNING_RATE = 0.1;
MAX_ITERATIONS = 100;
MIN_ERROR = 1e-4;

[numInst numDims] = size(input);
numClasses = size(target,2);

%# three output nodes connected to two-dimensional input nodes + biases
weights = randn(numClasses, numDims+1);

isDone = false;               %# termination flag
iter = 0;                     %# iterations counter
while ~isDone
    iter = iter + 1;

    %# for each instance
    err = zeros(numInst,numClasses);
    for i=1:numInst
        %# compute output: Y = W*X + b, then apply threshold activation
        output = ( weights * [input(i,:)';1] >= 0 );                       %#'

        %# error: err = T - Y
        err(i,:) = target(i,:)' - output;                                  %#'

        %# update weights (delta rule): delta(W) = alpha*(T-Y)*X
        weights = weights + LEARNING_RATE * err(i,:)' * [input(i,:) 1];    %#'
    end

    %# Root mean squared error
    rmse = sqrt(sum(err.^2,1)/numInst);
    fprintf(['Iteration %d: ' repmat('%f ',1,numClasses) '\n'], iter, rmse);

    %# termination criteria
    if ( iter >= MAX_ITERATIONS || all(rmse < MIN_ERROR) )
        isDone = true;
    end
end

%# plot points and one-against-all decision boundaries
[~,group] = max(target,[],2);                     %# actual class of instances
%gscatter(input(:,1), input(:,2), group), hold on
xLimits = get(gca,'xlim'); yLimits = get(gca,'ylim');
for i=1:numClasses
    ezplot(sprintf('%f*x + %f*y + %f', weights(i,:)), xLimits, yLimits)
end
title('Perceptron decision boundaries')
hold off