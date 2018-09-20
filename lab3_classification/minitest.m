x=linspace(-10,10,100);

for i = 1:size(x,1)
  y(i) = 1 / (1+exp(-x(i)));
end
figure, clf;
plot(x,y,'b');


 y = [;
 