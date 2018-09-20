%Now try the following
N = 1000;
x1 = zeros(N,1);
for n=1:N
  %x1(n,1) = sum(rand(12,1))/12;
  x1(n,1) = sum(rand(12,1));
end
%figure;
hist(x1,40);
