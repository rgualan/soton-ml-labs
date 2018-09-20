function part2( C, id )
%PART2 Runs the second part of the lab practice with a given C (covariance matrix)

    %SECTION 3
    %A'A = C using A = chol(C).
    %C=[2 1; 1 2];
    A = chol(C);
    A'*A
    X=randn(1000,2);
    Y=X*A;
    plot(X(:,1),X(:,2),'c.', Y(:,1),Y(:,2),'mx');
    figName1=strcat('img/x_y_',int2str(id),'.jpg');
    figName2=strcat('img/eps/x_y_',int2str(id),'.eps');
    print('-djpeg',figName1);    
    print('-depsc',figName2);

    %Construct a vector u = [sin theta cos theta], parameterized by the variable theta and compute the
    %variance of projections of the data in Y along this direction:
    theta = 0.25;
    yp = Y*[sin(theta); cos(theta)];
    %answer = var(yp);
    hist(yp,40);

    %Plot how this projected variance changes as a function of theta:
    N = 50;
    plotArray = zeros(N,1);
    thRange = linspace(0,2*pi,N);
    for n=1:N
        yp = Y*[sin(thRange(n)); cos(thRange(n))];
        plotArray(n,1) = var (yp);
    end
    plot(plotArray(:,1))
    figName1=strcat('img/yp_var_',int2str(id),'.jpg');
    figName2=strcat('img/eps/yp_var_',int2str(id),'.eps');
    print('-djpeg', figName1);
    print('-depsc', figName2);
    [V,D] = eig(C)

end

