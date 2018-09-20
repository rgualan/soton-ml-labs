function roc_area( ROC )
%ACCURACY Summary of this function goes here
%   Detailed explanation goes here

    area=(trapz(ROC(:,1),ROC(:,2)));
    area = abs(area);
    display(area);
    disp('Ratio');
    disp(area/(100*100));
end

