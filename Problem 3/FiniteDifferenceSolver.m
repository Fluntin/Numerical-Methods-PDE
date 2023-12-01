function solutionMatrix = SolveDiffusionEquation(spatialPoints, timePoints, simulationEndTime, conditionType)
    % SolveDiffusionEquation
    % Solves the diffusion equation using the finite difference method.
    % 
    % Arguments:
    % spatialPoints   - Number of spatial points
    % timePoints      - Number of time points
    % simulationEndTime - End time for the simulation
    % conditionType    - Flag for initial condition type 
    %                    (0 for g(x) = x(pi-x), otherwise g(x) = x on [0,pi/2], 0 on [pi/2, pi])
    %
    % Returns:
    % solutionMatrix - Matrix of solution points

    solutionMatrix = zeros(spatialPoints, timePoints);
    spatialStep = pi / (spatialPoints - 1);
    timeStep = simulationEndTime / (timePoints - 1);

    % Set initial conditions
    if conditionType == 0
        for spatialIndex = 1:spatialPoints
            xPosition = spatialStep * (spatialIndex - 1);
            solutionMatrix(spatialIndex, 1) = xPosition * (pi - xPosition);
        end
    else
        for spatialIndex = 1:spatialPoints
            xPosition = spatialStep * (spatialIndex - 1);
            if xPosition < pi / 2
                solutionMatrix(spatialIndex, 1) = xPosition;
            else
                solutionMatrix(spatialIndex, 1) = 0;
            end
        end
    end

    % Compute finite difference
    for timeIndex = 2:timePoints
        for spatialIndex = 2:spatialPoints - 1
            solutionMatrix(spatialIndex, timeIndex) = solutionMatrix(spatialIndex, timeIndex - 1) + ...
                timeStep / (spatialStep^2) * (solutionMatrix(spatialIndex + 1, timeIndex - 1) - ...
                2 * solutionMatrix(spatialIndex, timeIndex - 1) + solutionMatrix(spatialIndex - 1, timeIndex - 1));
        end
    end
end

