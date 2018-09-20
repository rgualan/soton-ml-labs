%1000 uniform random numbers and plot a histogram
disp('Histogram of 1000 random numbers')
x = rand(1000,1);
hist(x,40);
print('-djpeg', 'img/hist_rand_1000.jpg');
print('-depsc', 'img/eps/hist_rand_1000.eps');

%Repeat the above with 1000 random numbers drawn from a Gaussian distribution of mean
%0 and standard deviation 1 using x = randn(1000,1);
disp('Histogram of 1000 random numbers drawn from a Gaussian distribution')
x = randn(1000,1);
%figure;
%std(x)
%mean(x)
hist(x,40);
print('-djpeg', 'img/hist_randn_1000.jpg');
print('-depsc', 'img/eps/hist_randn_1000.eps');

%Now try the following
N = 1000;
x1 = zeros(N,1);
for n=1:N
  x1(n,1) = sum(rand(12,1))-sum(rand(12,1));
end
%figure;
hist(x1,40);
print('-djpeg', 'img/hist_clt_1000.jpg');
print('-depsc', 'img/eps/hist_clt_1000.eps');



%SECTION 3
disp 'Firs case C1';
C1=[2 1; 1 2];
part2(C1,1);

disp 'Second case C2';
C2=[2 -1; -1 2];
part2(C2,2);
