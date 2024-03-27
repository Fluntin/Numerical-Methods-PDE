% Solving the wave equation u_tt(x,t) = c^2 u_xx(x,t) with initial condition u_t(x, 0) = 0
% Using d'Alembert's formula and generating an aesthetically pleasing visualization

clear all
close all

% Simulation parameters
numIntervals = 200; % Number of intervals
waveSpeed = 1; % Wave propagation speed
domainLength = 1.0; % Length of the spatial domain
finalTime = 1.0; % End time for the simulation
dx = domainLength / (numIntervals + 1); % Spatial step size
dt = dx / 1.1; % Time step size, consider stability conditions
numTimeSteps = fix(finalTime / dt); % Number of time steps

% Initial condition function
initialCondition = @(x) sin(pi * x); % Example initial condition

% Defining d'Alembert's formula for the wave solution
waveSolution = @(x, t) (0.5 * initialCondition(x + waveSpeed * t) + 0.5 * initialCondition(x - waveSpeed * t));

% Preparing the plot
figure('Color', 'w'); % Set background color to white
plotHandle = plot(NaN, NaN, 'LineWidth', 2); % Initial plot setup with thicker line
axis([0 1 -1 1]);
xlabel('Position, x', 'FontSize', 12);
ylabel('Displacement, u(x,t)', 'FontSize', 12);
title('Wave Equation Simulation', 'FontSize', 14);
grid on; % Add grid lines for better readability

% Preparing video recording with higher quality
videoFile = VideoWriter('WaveEquationDalembert_Simulation.avi', 'Motion JPEG AVI');
videoFile.FrameRate = 30; % Increase frame rate for smoother playback
open(videoFile);

% Memory allocation
xPositions = linspace(0, domainLength, numIntervals);

% Time stepping and plotting
for timeStep = 1:numTimeSteps
    displacements = arrayfun(@(x) waveSolution(x, timeStep * dt), xPositions);
    set(plotHandle, 'XData', xPositions, 'YData', displacements, 'Color', 'b'); % Update plot data
    drawnow; % Update the plot
    frame = getframe(gcf);
    writeVideo(videoFile, frame);
end

% Close the video file
close(videoFile);

