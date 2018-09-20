C=[1 0; 0 1];
%C=[1 0.5; 0.5 1];
%C=[1 -0.5; -0.5 1];
A = chol(C);
A'*A;
X=randn(1000,2);
Y=X*A;
figure;clf;
%plot(X(:,1),X(:,2),'c.', Y(:,1),Y(:,2),'mx');
plot(Y(:,1),Y(:,2),'mx');

o=pi/4;
R=[cos(o) -sin(o); sin(o) cos(o)]*[5 0; 0 5];
x=[2;0];
y=R*x;
y,norm(y)


C1 = [2 1; 1 2];
C2 = 1.5*[1 0; 0 1];
det(C1), det(C2),
inv(C1), inv(C2),