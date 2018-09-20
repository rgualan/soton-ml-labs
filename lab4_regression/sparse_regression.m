function [ iNzero ] = sparse_regression( Y, f, p, gamma, figureNumber )
    %Let us now regularize the regression: w2 = minw jY w ? fj + 
    % jwj1. You can implement
    %this as follows:
    %gamma = 8.0;
    cvx_begin quiet
        variable w2( p+1 );
        minimize( norm(Y*w2-f) + gamma*norm(w2,1) );
    cvx_end
    fh2 = Y*w2;
    %figure(2), clf,
    %figure(figureNumber), clf,
    %plot(f, fh2, 'co', 'LineWidth', 2), %fh1 or fh2?
    %legend('Regression', 'Sparse Regression');
    %You can find the non-zero coeficients that are not switched off by the regularizer:
    [iNzero] = find(abs(w2) > 1e-5);
    %disp('Relevant variables');
    %disp(iNzero);
end

