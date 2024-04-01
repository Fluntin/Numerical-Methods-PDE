% Solve the Kepler Problem using MATLAB's ode45
% Kepler's problem involves computing the orbit of bodies in space influenced only by gravity

% Define the differential equations function for the Kepler problem
function dydt = keplerEquations(t, y)
    % y(1) and y(2) represent the position components (x, y) of the body
    % y(3) and y(4) represent the velocity components (vx, vy) of the body
    % dydt is the derivative of y, representing the rate of change of position and velocity
    dx = y(3); % Rate of change of x-position
    dy = y(4); % Rate of change of y-position
    d2x = -y(1) * (y(1)^2 + y(2)^2)^(-3/2); % Acceleration in x-direction due to gravity
    d2y = -y(2) * (y(1)^2 + y(2)^2)^(-3/2); % Acceleration in y-direction due to gravity
    dydt = [dx; dy; d2x; d2y];
end

% Initial conditions and parameters
eccentricity = 0.5; % Eccentricity of the orbit
period = 500; % Time period over which to solve the equations

% Initial position and velocity (based on the given eccentricity)
initialConditions = [1 - eccentricity; 0; 0; sqrt((1 + eccentricity) / (1 - eccentricity))];

% Solve the differential equations using ode45
% ode45 is a MATLAB function for solving ordinary differential equations
% ode45 is suitable for solving non-stiff differential equations and is more accurate for long time spans compared to Euler and midpoint methods
[time, solution] = ode45(@keplerEquations, [0, period], initialConditions);

% Plotting the solution to visualize the orbit
figure; % Create a new figure window
plot(solution(:,1), solution(:,2), 'LineWidth', 2); % Plot the orbit with a thicker line for visibility
title('Orbit computed using ode45'); % Title of the plot
xlabel('X Position'); % X-axis label
ylabel('Y Position'); % Y-axis label
grid on; % Add a grid to the plot for better readability
axis equal; % Ensure equal scaling on both axes to accurately represent the orbit shape

% Enhancing aesthetics with additional plot features
set(gca, 'FontSize', 12); % Set font size for axis labels and ticks
