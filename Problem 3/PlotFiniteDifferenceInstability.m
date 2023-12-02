function PlotFiniteDifferenceInstability(initialConditionType)
    % PlotFiniteDifferenceInstability
    % Illustrates instability in the finite difference solution.
    %
    % Arguments:
    % initialConditionType - Flag for initial condition type 
    % (0 for g(x) = x(pi-x), otherwise g(x) = x on [0,pi/2], 0 on [pi/2, pi])

    spatialResolution = 16; % High spatial resolution
    spatialAxis = linspace(0, pi, spatialResolution);
    deltaX = pi / (spatialResolution - 1); % Calculating spatial step size

    % Choosing time step to intentionally violate the stability condition
    desiredRatio = 0.75; % Desired ratio
    timeStep = desiredRatio * deltaX^2; % This ensures Delta tau / (Delta x)^2 > 1/2
    timeSteps = round(2.5 / timeStep); % Reduce the time range to focus on instability
    timeAxis = linspace(0, 2.5, timeSteps); % Adjust the time range

    % Solving the equation with the chosen resolution
    solutionPoints = FiniteDifferenceSolver(spatialResolution, timeSteps, 2.5, initialConditionType); % Adjust the simulation time to 2.5
    [XGrid, TGrid] = meshgrid(spatialAxis, timeAxis);

    figure; % Create a new figure window
    colormap jet; % Set colormap
    mesh(XGrid', TGrid', solutionPoints); % Create mesh plot

    title(sprintf('Instability Illustration at Spatial Resolution: %d', spatialResolution)); % Title for the plot
    colorbar; % Add colorbar to display the heat legend
end



