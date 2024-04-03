% Solve Kepler's Orbit Problem using MATLAB's ode45
Eccentricity = 0.5; % Eccentricity of the orbit
Time_period = 333; % Time period to simulate the orbit

% Initial conditions for the orbit based on eccentricity
initialConditions = [1-Eccentricity; 0; 0; sqrt((1+Eccentricity)/(1-Eccentricity))];

% Solving the orbit using ode45
[t, orbit] = ode45(@keplerOrbitEquations, [0, Time_period], initialConditions);

% Enhanced Plotting of Kepler's Orbit Simulation
figure; % Create a new figure window
plot(orbit(:,1), orbit(:,2), 'LineWidth', 1, 'Color', [0, 0.4470, 0.7410]); % Use a thicker line and a pleasant color
title('Kepler''s Orbit Simulation', 'FontSize', 14); % Larger title font
xlabel('X Position in Orbit', 'FontSize', 12); % Larger label fonts
ylabel('Y Position in Orbit', 'FontSize', 12);
grid on; % Keep the grid
axis equal; % Equal aspect ratio to ensure the orbit looks circular if it is supposed to
set(gca, 'FontSize', 10); % Set the font size for axis tick labels
box on; % Enclose the plot in a box

% If you want to highlight the starting point
hold on; % Keep the current plot
startPoint = plot(orbit(1,1), orbit(1,2), 'ro'); % Mark the starting point in red
legend(startPoint, 'Starting Position', 'FontSize', 10); % Add a legend for clarity
hold off; % Release the plot hold
