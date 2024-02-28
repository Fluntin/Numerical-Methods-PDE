% EnhancedOrbitSimulationForwardEuler.m
% This script simulates the orbit based on Hamiltonian dynamics using
% the forward Euler method for numerical integration.
% The Hamiltonian H(p, q) = 0.5*|p|^2 - 1/|q| represents the energy of the system.

% Define the Hamiltonian function for energy calculation
HamiltonianEnergy = @(momentum, position) (0.5*norm(momentum)^2 - 1/norm(position));

% Set parameters
eccentricity = 0.5; % Eccentricity of the orbit, must be between 0 and 1
timeStepSize = 0.05; % Time step size for numerical integration
totalTimeSteps = 5000; % Total number of time steps for the simulation

% Initialize arrays for position, momentum, and energy
position = zeros(2, totalTimeSteps);
momentum = zeros(2, totalTimeSteps);
energyHistory = zeros(1, totalTimeSteps); % Store energy at each time step

% Set initial conditions for position and momentum
position(:, 1) = [1 - eccentricity; 0]; % Initial position
momentum(:, 1) = [0; sqrt((1 + eccentricity) / (1 - eccentricity))]; % Initial momentum
energyHistory(1) = HamiltonianEnergy(momentum(:, 1), position(:, 1)); % Initial energy

% Main simulation loop using forward Euler method
for stepIndex = 1:totalTimeSteps - 1
    % Update position based on current momentum
    position(:, stepIndex + 1) = position(:, stepIndex) + timeStepSize * momentum(:, stepIndex);
    % Update momentum based on gravitational force, assuming a central force field
    momentum(:, stepIndex + 1) = momentum(:, stepIndex) - timeStepSize * (1 / norm(position(:, stepIndex))^3) * position(:, stepIndex);
    % Calculate and store the energy at the new position and momentum
    energyHistory(stepIndex + 1) = HamiltonianEnergy(momentum(:, stepIndex + 1), position(:, stepIndex + 1));
end

% Plotting the energy of the system over time for visualization
figure;
plot(energyHistory, 'LineWidth', 2);
title('System Energy Over Time');
xlabel('Time Step');
ylabel('Energy');
grid on;

% Plotting the orbit in position space for visualization
figure;
plot(position(1, :), position(2, :), 'LineWidth', 2);
title('Orbit in Position Space');
xlabel('X Position');
ylabel('Y Position');
axis equal; % Ensure equal scaling for x and y axis to visualize the orbit correctly
grid on;
