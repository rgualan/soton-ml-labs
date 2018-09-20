%Linear equation: a1x + b1y + c1 = 0 
%It intersects the x and y axes at -c1/b1 and -c1/a1 respectively.
%Equation 3x + 4y + 12 = 0,
a1=3; b1=4; c1=12;
%plot([0 -4], [-3 0], 'b', 'LineWidth', 2);

xlabel('x')
ylabel('y')
title('Line')
plot([0 -c1/a1], [-c1/b1 0], 'b', 'LineWidth', 3);
axis([-5 5 -5 5]); grid on;

hold on
%plot([0 0], [-36/25 -48/25], 'b', 'LineWidth', 2);
plot([0 -36/25], [0 -48/25], 'r', 'LineWidth', 3);
hold off


% The perpendicular distance from the origin to the straight line above is
% abs(c1) / SQRT( a1^2 + b1^2 )
% Confirm this is correct on the plot you have drawn.
d1=abs(-c1) / sqrt(a1^2 + b1^2);
display(d1);

% Equation of the straight line in vector notation:
% a1x + b1y + c1 = 0 
% w'x + b = 0 
% the vector w contains information about the slope and the bias term b relates to the
% offset of the line.
% The distance from the origin to the line is thus abs(b)=|w|.
w=[a1 b1];
b=c1;
d2=abs(b)/norm(w);
display(d2);





