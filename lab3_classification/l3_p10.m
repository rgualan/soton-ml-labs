% =========================================================================
% Section 10. For the dataset you have generated, construct a distance-to-mean classifire using (a)
% Euclidean distance and (b) Mahalanobis distance as distance measures and compare
% their classification accuracies.

load('distributions.mat');
C1=C;
C2=C;

display('Euclidian distance');
d_to_mean( X1, X2, m1, m2, C1, C2, 1 );

display('Mahalanobis distance');
d_to_mean( X1, X2, m1, m2, C1, C2, 2 );
