function [ROC, optThreshold] = roc_curve( xx1, xx2, p1, p2, N, resolution, figureNumber, color)
%ROC_PLOT Summary of this function goes here
%   Detailed explanation goes here

    if ~exist('color','var')
        color = 'b';
    end

    thmin = min([xx1 xx2]);
    thmax = max([xx1 xx2]);
    rocResolution = resolution;
    thRange = linspace(thmin, thmax, rocResolution);
    ROC = zeros(rocResolution,2);
    accuracy = zeros(rocResolution,1);
    for jThreshold = 1: rocResolution
        threshold = thRange(jThreshold);
        tPos = length(find(p1 > threshold))*100 / N;
        fPos = length(find(p2 > threshold))*100 / N;
        ROC(jThreshold,:) = [fPos tPos];
        
        % Calculate the accuracy per threshold
        % Formula = true postive + true negative / total number of data
        tPos = length(find(p1 > threshold));
        tNeg = length(find(p2 < threshold));
        accuracy(jThreshold) = (tPos + tNeg )/(2*N);
    end
    % Plot the accuracy bar chart
    %figure; clf; bar(1:rocResolution,accuracy);
    th = thRange(accuracy == max(accuracy));
    %optThreshold = [th(floor(size(th)/2)); max(accuracy)];
    optThreshold = [th(1); max(accuracy)];
    
    figure(figureNumber),
    hold on;
    plot(ROC(:,1), ROC(:,2), color, 'LineWidth', 2);
    axis([0 100 0 100]);
    grid on, 
    %hold on
    plot(0:100, 0:100, 'b-');
    xlabel('False Positive', 'FontSize', 16)
    ylabel('True Positive', 'FontSize', 16);
    title('Receiver Operating Characteristic Curve', 'FontSize', 20);
    hold off;
    
    %Print accuracy
    disp('Threshold:');
    disp(optThreshold(1));

    disp('Accuracy:');
    disp(optThreshold(2));
    
    %Area under the ROC curve
    roc_area(ROC);
end

