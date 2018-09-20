function [xx1, xx2] = proj_distribution( p1, p2, figureNumber )
%PROJ_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here

    plo = min([p1; p2]);
    phi = max([p1; p2]);
    [nn1, xx1] = hist(p1);
    [nn2, xx2] = hist(p2);
    hhi = max([nn1 nn2]);
    figure(figureNumber), clf
    subplot(2,1,1), bar(xx1, nn1);
    axis([plo phi 0 hhi]);
    title('Distribution of Projections', 'FontSize', 16)
    ylabel('Class 1', 'FontSize', 14)
    subplot(2,1,2), bar(xx2, nn2);
    axis([plo phi 0 hhi])
    ylabel('Class 2', 'FontSize', 14)


end

