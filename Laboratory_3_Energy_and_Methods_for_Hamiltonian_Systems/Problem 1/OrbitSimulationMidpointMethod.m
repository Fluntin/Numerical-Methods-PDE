% OrbitSimulationMidpointMethod.m
% This script simulates the orbit based on Hamiltonian dynamics using
% the midpoint method for numerical integration.
% The Hamiltonian H(p, q) = 0.5*|p|^2 - 1/|q| represents the energy of the system.

% Define the Hamiltonian function
Hamiltonian = @(momentum, position) (0.5*norm(momentum)^2 - 1/norm(position));

% Initialization parameters
eccentricity = 0.5;  % Eccentricity of the orbit
timeStep = 0.005;    % Time step size for numerical integration
totalSteps = 20000;  % Total number of steps for the simulation

% Initialize arrays for position, momentum, and energy
position = zeros(2, totalSteps);
momentum = zeros(2, totalSteps);
energyHistory = zeros(1, totalSteps);  % To track energy at each step

% Initial conditions for position and momentum
position(:, 1) = [1 - eccentricity; 0];
momentum(:, 1) = [0; sqrt((1 + eccentricity) / (1 - eccentricity))];
energyHistory(1) = Hamiltonian(momentum(:, 1), position(:, 1));

% Simulation loop using the midpoint method
for step = 1:totalSteps - 1
    [newMomentum, newPosition] = midstep(momentum(:, step), position(:, step), timeStep);
    
    position(:, step + 1) = newPosition;
    momentum(:, step + 1) = newMomentum;
    energyHistory(step + 1) = Hamiltonian(momentum(:, step + 1), position(:, step + 1));
end

% Plotting the energy of the system over time
figure;
plot(energyHistory, 'LineWidth', 2);
title('System Energy Over Time');
xlabel('Time Step');
ylabel('Energy');
grid on;

% Plotting the orbit in the position space
figure;
plot(position(1, :), position(2, :), 'LineWidth', 2);
title('Orbit in Position Space');
xlabel('X Position');
ylabel('Y Position');
axis equal;
grid on;

% Midpoint method function definition
function [newMomentum, newPosition] = midstep(momentum, position, timeStep)
    % Midpoint method for updating position and momentum
    midpointFunc = @(x) [x(1) - momentum(1) + timeStep * (0.5 * x(3) + 0.5 * position(1)) * ((0.5 * x(3) + 0.5 * position(1))^2 + (0.5 * x(4) + 0.5 * position(2))^2)^(-3/2), ...
                         x(2) - momentum(2) + timeStep * (0.5 * x(4) + 0.5 * position(2)) * ((0.5 * x(3) + 0.5 * position(1))^2 + (0.5 * x(4) + 0.5 * position(2))^2)^(-3/2), ...
                         x(3) - position(1) - timeStep * (0.5 * x(1) + 0.5 * momentum(1)), ...
                         x(4) - position(2) - timeStep * (0.5 * x(2) + 0.5 * momentum(2))];
    initialGuess = [0; 0; 1; 1];
    options = optimset('Diagnostics', 'off', 'Display', 'off', 'TolFun', 10^(-10));
    solution = fsolve(midpointFunc, initialGuess, options);
    
    newMomentum = [solution(1); solution(2)];
    newPosition = [solution(3); solution(4)];
end