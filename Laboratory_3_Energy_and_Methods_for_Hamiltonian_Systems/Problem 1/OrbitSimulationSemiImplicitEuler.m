% SemiImplicitEulerOrbitSimulation.m
% This script simulates the orbit based on Hamiltonian dynamics using
% the semi-implicit (symplectic) Euler method for numerical integration.
% The Hamiltonian H(p, q) = 0.5*|p|^2 - 1/|q| represents the energy of the system.

% Define the Hamiltonian function for calculating the energy
Hamiltonian = @(momentum, position) (0.5*norm(momentum)^2 - 1/norm(position));

% Set simulation parameters
eccentricity = 0.5;  % Eccentricity of the orbit
timeStepSize = 0.05; % Time step size for numerical integration
totalTimeSteps = 5000; % Total number of steps for the simulation

% Initialize position, momentum, and energy arrays
position = zeros(2, totalTimeSteps);
momentum = zeros(2, totalTimeSteps);
energyHistory = zeros(1, totalTimeSteps); % Track energy at each time step

% Initial conditions for position and momentum
position(:, 1) = [1 - eccentricity; 0]; % Initial position
momentum(:, 1) = [0; sqrt((1 + eccentricity) / (1 - eccentricity))]; % Initial momentum
energyHistory(1) = Hamiltonian(momentum(:, 1), position(:, 1)); % Initial energy

% Main simulation loop using the semi-implicit Euler method
for step = 1:totalTimeSteps - 1
    % First update the momentum using the gravitational force
    momentum(:, step + 1) = momentum(:, step) - timeStepSize * (1 / norm(position(:, step))^3) * position(:, step);
    % Then update the position using the newly updated momentum
    position(:, step + 1) = position(:, step) + timeStepSize * momentum(:, step + 1);
    % Calculate and store the energy at the new position and momentum
    energyHistory(step + 1) = Hamiltonian(momentum(:, step + 1), position(:, step + 1));
end

% Plotting the system's energy over time
figure;
plot(energyHistory, 'LineWidth', 2);
title('System Energy Over Time');
xlabel('Time Step');
ylabel('Energy');
grid on;

% Plotting the orbit in position space
figure;
plot(position(1, :), position(2, :), 'LineWidth', 2);
title('Orbit in Position Space');
xlabel('X Position');
ylabel('Y Position');
axis equal; % Keep aspect ratio equal to correctly visualize the orbit
grid on;
