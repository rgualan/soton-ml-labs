load('distributions.mat');
C1=C;
C2=C;
C_inv=inv(C);
numGrid=50;

%Bayes classifier boundary (PLANE)
[Y,Z] = meshgrid(-2:6,0:1);
X = (-w(2).*Y-b)/w(1);    
figure(1), clf;
surf(X,Y,Z);
hold on;

% 3D posterior probability
%[x,y] = meshgrid(linspace(-6,6,50));
[x,y] = meshgrid(-4:.2:6, -2:.2:6);
P = zeros(numGrid, numGrid); % posterior probability
w=2*C_inv *(m2-m1); %L2-6/8
w0=m1'*C_inv*m1 - m2'*C_inv*m2 - log(0.5/0.5);
P = 1 ./ (1 + exp(-(w(1).*x + w(2).*y + w0) ) );
%figure(1); clf;
surf(x, y, P); 
%hold on;
return;


%Bayes classifier boundary
%w' x + b = 0
Cinv=inv(C);
w=2*Cinv*(m2-m1);
b=(m1'*Cinv*m1 - m2'*Cinv*m2) - log(0.5/0.5);
x=linspace(-4,6,numGrid);
y=(-w(1,1)*x-b)/w(2,1);
%figure;
%line(x,y,0*ones(size(x)),'linewidth',2)
%axis([-4 6 -2 6 0 2]);

P1 = [(-w(2)*(-2)-b)/w(1) -2 0 1];
P2 = [(-w(2)*( 6)-b)/w(1)  6 0 1];
P3 = [(-w(2)*(-2)-b)/w(1) -2 2 1];
P4 = [(-w(2)*( 6)-b)/w(1)  6 2 1];
%patch(P1, P2, P3, P4);  
%patch([P1(1) P2(1) P3(1) P4(1)], [P1(2) P2(2) P3(2) P4(2)], [P1(3) P2(3) P3(3) P4(3)], [1 1 -1 -1])  

[x y] = meshgrid(-1:0.1:1); % Generate x and y data
z = zeros(size(x, 1)); % Generate z data
surf(x, y, z) % Plot the surface

