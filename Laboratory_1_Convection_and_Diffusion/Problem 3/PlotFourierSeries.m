function PlotFourierSeries(initialConditionType)
    % PlotFourierSeries
    % Plots the Fourier series approximation for different numbers of terms.
    %
    % Arguments:
    % initialConditionType - Flag for initial condition type 
    % (0 for g(x) = x(pi-x), otherwise g(x) = x on [0,pi/2], 0 on [pi/2, pi])
    % Test 123
    termsArray = [2, 8, 64]; % Number of Fourier terms
    spatialPoints = 30;        % Number of spatial points
    timePoints = 20;           % Number of time points
    spatialStep = pi/(spatialPoints - 1);  % Spatial step size
    timeStep = spatialStep;                % Time step size
    
    xSpace = linspace(0, pi, spatialPoints);
    tSpace = linspace(0, timeStep*timePoints, timePoints);
    [XGrid, TGrid] = meshgrid(xSpace, tSpace);

    for numTerms = termsArray
        fourierCoefficients = FourierCoefficients(numTerms, initialConditionType);
        seriesValues = zeros(spatialPoints, timePoints);
        for timeIndex = 1:timePoints
            currentTime = (timeIndex - 1)*timeStep;
            for spatialIndex = 1:spatialPoints
                currentX = (spatialIndex - 1)*spatialStep;
                for termIndex = 1:numTerms
                    seriesValues(spatialIndex, timeIndex) = seriesValues(spatialIndex, timeIndex) + ...
                        fourierCoefficients(termIndex)*sin(termIndex*currentX)*exp(-1*termIndex^2*currentTime);
                end
            end
        end
        
        figure; % Create a new figure window
        colormap jet; % Set colormap
        surf(XGrid', TGrid', seriesValues); % Create surface plot

        title(sprintf('Number of Fourier Terms: %d', numTerms)); % Add title displaying number of Fourier terms
        colorbar; % Add colorbar to display the heat legend
    end
end
