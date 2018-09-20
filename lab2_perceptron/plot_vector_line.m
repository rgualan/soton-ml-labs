%Plots a straight line using the 
%x from
%x_to and
%w the weight vector
function plot_vector_line( w, highlitght )
    if ~exist('highlitght','var')
        highlitght = 0;
    end

    x_from = -5;
    x_to = 6; 
    x=linspace(x_from, x_to);
    y=(-w(1,1)*x-w(3,1))/w(2,1);
    hold on;
    
    if (highlitght==1)
        plot(x,y,'r:');
    elseif (highlitght==2)
        plot(x,y,'r','Linewidth',2);
    else
    	plot(x,y,'b:');
    end
    hold off;
end