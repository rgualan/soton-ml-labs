% load variables
load('distributions.mat');

plot(X(:,1),X(:,2),'c.', X1(:,1),X1(:,2),'mx'); axis([-5 6 -5 6]);
print -djpeg img/shift_mean_1.jpg
plot(Y(:,1),Y(:,2),'c.', Y1(:,1),Y1(:,2),'mx'); axis([-5 6 -5 6]);
print -djpeg img/shift_mean_2.jpg

% Shift the mean of the distributions (with repmat)
X2 = X + repmat(m1',N,1);
Y2 = Y + repmat(m2',N,1);
plot(X(:,1),X(:,2),'c.', X2(:,1),X2(:,2),'mx'); axis([-5 6 -5 6]);
print -djpeg img/shift_mean_1_.jpg
plot(Y(:,1),Y(:,2),'c.', Y2(:,1),Y2(:,2),'mx'); axis([-5 6 -5 6]);
print -djpeg img/shift_mean_2_.jpg


% Save X1 Y1 to a file for posterior use
save('distributions.mat','N', 'C', 'm1', 'm2', 'X1','Y1');  % function form
