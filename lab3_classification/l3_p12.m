% =========================================================================
% Basic
N=200; %100
m1 = [0; 2];
m2 = [1.75; 2.5];
m2 = m2 + [3; 0];
C1 = [2 1; 1 2]; 
C2 = 1.5 * eye(2); 
X1 = mvnrnd(m1, C1, N);
X2 = mvnrnd(m2, C2, N);

%Probability contour plot
numGrid = 50;
xRange = linspace(-3.0, 6.0, numGrid);
yRange = linspace(-1.0, 7.0, numGrid);
P1 = zeros(numGrid, numGrid);
P2 = zeros(numGrid, numGrid);
for j=1:numGrid
    for i=1:numGrid;
        x = [xRange(j) yRange(i)]';
        P1(i,j) = mvnpdf(x', m1', C1);
        P2(i,j) = mvnpdf(x', m2', C2);
    end
end
Pmax = max(max([P1 P2]));
figure(1), clf,
contour(xRange, yRange, P1, [0.1*Pmax 0.5*Pmax 0.8*Pmax], 'LineWidth', 1);
hold on;
contour(xRange, yRange, P2, [0.1*Pmax 0.5*Pmax 0.8*Pmax], 'LineWidth', 1);
plot(m1(1), m1(2), 'b*', 'LineWidth', 4);
plot(m2(1), m2(2), 'r*', 'LineWidth', 4);
% Plot distributions
plot(X1(:,1),X1(:,2),'bx', X2(:,1),X2(:,2),'ro'); grid on;
%title('Normal distribution with C1 != C2', 'FontSize', 16);
xlabel('x1', 'FontSize', 14)
ylabel('x2', 'FontSize', 14);

% Plot quadratic classification boundary
% gi(x) = x^t W_i x + w^t_i x + w_i0,   
C1_inv = inv(C1);
C2_inv = inv(C2);
W1=(-1/2)*C1_inv;
W2=(-1/2)*C2_inv;
w1=C1_inv*m1;
w2=C2_inv*m2;
omega01=(-1/2)*m1'*C1_inv*m1 - (1/2)*log(det(C1)) + log(0.5);
omega02=(-1/2)*m2'*C2_inv*m2 - (1/2)*log(det(C2)) + log(0.5);

%Solve
x = sym('x',[2 1])
x = sym(x,'real');
g1= x'*W1*x + w1'*x + omega01;
g2= x'*W2*x + w2'*x + omega02;


%Plot solution
xi1=linspace(-6,0.9,numGrid);
yi1=zeros(1,numGrid);
xi2=linspace(1.1,6,numGrid);
yi2=zeros(1,numGrid);

for i=1:numGrid
    % First part
    x1 = sym('x1');
    y = solve(g1 == g2, x(2,1));
    x1 = xi1(i);
    yi1(i) = subs(y);
    % Second part
    y = solve(g1 == g2, x(2,1));
    x1 = xi2(i);
    yi2(i) = subs(y);
end
plot(xi1,yi1,'r', 'LineWidth', 4);
plot(xi2,yi2,'r', 'LineWidth', 4);


%Plot Bayes classifier



return;




% Test
x1 = sym('x1');
x2 = sym('x2');
g_test = 11*x1 + 2*x2 - 2*x1*x2 - 2 * 1.627;
y = solve( g_test == 0, x1 );
%Plot solution
xi=linspace(-6,6,numGrid);
yi=zeros(1,numGrid);
for i=1:numGrid
    x1 = sym('x1');
    y = solve(g_test == 0, x2);
    x1 = xi(i);
    yi(i) = subs(y);
end
figure; clf;
plot(xi,yi,'b');

