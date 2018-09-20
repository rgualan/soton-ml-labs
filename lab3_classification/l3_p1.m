% =========================================================================
% Section 1
N=200; %100
m1 = [0; 2];
m2 = [1.75; 2.5];
C = [2 1; 1 2]; 
C1 = C; 
C2 = C1; % Same covariance
%X1 = mvnrnd(m1, C, N);
%%X2 = mvnrnd(m2, C, N);
load('distributions.mat');

%Density contour
numGrid = 50;
xRange = linspace(-4.0, 5.0, numGrid);
yRange = linspace(-2.0, 6.0, numGrid);
P1 = zeros(numGrid, numGrid);
P2 = P1;
for j=1:numGrid
    for i=1:numGrid;
        x = [xRange(j) yRange(i)]';
        P1(i,j) = mvnpdf(x', m1', C1);
        P2(i,j) = mvnpdf(x', m2', C2);
    end
end
Pmax = max(max([P1 P2]));
figure(1), clf,
contour(xRange, yRange, P1, [0.1*Pmax 0.5*Pmax 0.8*Pmax], 'LineWidth', 2);
hold on;
plot(m1(1), m1(2), 'b*', 'LineWidth', 4);
contour(xRange, yRange, P2, [0.1*Pmax 0.5*Pmax 0.8*Pmax], 'LineWidth', 2);
plot(m2(1), m2(2), 'r*', 'LineWidth', 4);

title('Normal distribution with C1=C2', 'FontSize', 16);
xlabel('x1', 'FontSize', 14)
ylabel('x2', 'FontSize', 14);


% Section 2
plot(X1(:,1),X1(:,2),'bx', X2(:,1),X2(:,2),'ro'); grid on;

display('Fisher');


% Section 3
wF = inv(C1+C2)*(m1-m2);
xx = -6:0.1:6;
yy = xx*wF(2)/wF(1);
plot(xx,yy,'r', 'LineWidth', 2);

return;

% Section 4
p1 = X1*wF;
p2 = X2*wF;

[xx1, xx2] = proj_distribution( p1, p2, 2 );

% Section 5
figure(3), clf;
ROC = roc_curve( xx1, xx2, p1, p2, N, 50, 3);

% Section 6
% Compute the area under the ROC
% It was implemented inside the roc generation method

% Section 7. For a suitable choice of decision threshold, compute the classication accuracy.
% It was implemented inside the roc_curve method

% Section 8. Plot the ROC curve (on the same scale) for
% A random direction (instead of the Fisher discriminant direction).
display('Random');
wRandom = rand(2,1);
p1 = X1*wRandom;
p2 = X2*wRandom;
[xx1, xx2] = proj_distribution( p1, p2, 2 );
roc_curve( xx1, xx2, p1, p2, N, 50, 3, 'c');

% Projections onto the direction connecting the means of the two classes.
display('Directions connecting the means');
wMeanCon = m2-m1;
p1 = X1*wMeanCon;
p2 = X2*wMeanCon;
[xx1, xx2] = proj_distribution( p1, p2, 2 );
roc_curve( xx1, xx2, p1, p2, N, 50, 3, 'r');
%roc_accuracy(ROC);

save('distributions.mat','N', 'C',  'm1', 'm2', 'X1','X2');  % function form

