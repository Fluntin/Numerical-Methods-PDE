function PlotFiniteDifference(initialConditionType)
    % PlotFiniteDifference
    % Plots the finite difference solution for different spatial resolutions.
    %
    % Arguments:
    % initialConditionType - Flag for initial condition type 
    % (0 for g(x) = x(pi-x), otherwise g(x) = x on [0,pi/2], 0 on [pi/2, pi])

    resolutionLevels = [8, 16, 32]; % Array of spatial resolutions to plot
    for currentResolution = resolutionLevels
        solutionPoints = FiniteDifferenceSolver(currentResolution, 50*currentResolution, 5, initialConditionType);
        spatialAxis = linspace(0, pi, currentResolution);
        [~, timeSteps] = size(solutionPoints);
        timeAxis = linspace(0, 5, timeSteps);
        [XGrid, TGrid] = meshgrid(spatialAxis, timeAxis);

        figure; % Create a new figure window
        colormap jet; % Set colormap
        mesh(XGrid', TGrid', solutionPoints); % Create mesh plot

        title(sprintf('Spatial Resolution: %d', currentResolution)); % Add title displaying spatial resolution
        colorbar; % Add colorbar to display the heat legend
    end
end