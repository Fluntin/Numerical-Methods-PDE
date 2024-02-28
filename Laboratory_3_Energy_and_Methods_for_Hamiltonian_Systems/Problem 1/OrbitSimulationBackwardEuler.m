% OrbitSimulationBackwardEuler.m
% This script simulates the orbit based on the Hamiltonian dynamics using
% the Backward Euler method for numerical integration.
% The Hamiltonian H(p, q) = 0.5*|p|^2 - 1/|q| represents the energy of the system.

% Define the Hamiltonian function
Hamiltonian = @(momentum, position) (0.5*norm(momentum)^2 - 1/norm(position));

% Initial parameters setup
eccentricity = 0.5;
timeStep = 0.005;
totalSteps = 3500;

% Initialize position, momentum, and energy arrays
position = zeros(2, totalSteps);
momentum = zeros(2, totalSteps);
energyArray = zeros(1, totalSteps); % Adjusted for preallocation efficiency

% Initial conditions
position(:, 1) = [1-eccentricity; 0];
momentum(:, 1) = [0; sqrt((1+eccentricity)/(1-eccentricity))];
energyArray(1) = Hamiltonian(momentum(:,1), position(:,1));

% Main simulation loop
for step = 1:totalSteps-1
    [newMomentum, newPosition] = backwardstep(momentum(:,step), position(:,step), timeStep);
    
    position(:, step+1) = newPosition(:);
    momentum(:, step+1) = newMomentum(:);
    energyArray(step+1) = Hamiltonian(momentum(:,step+1), position(:,step+1));
end

% Plot the energy over time
figure;
plot(energyArray, 'LineWidth', 2);
title('System Energy Over Time');
xlabel('Time Step');
ylabel('Energy');
grid on;

% Plot the orbit in position space
figure;
plot(position(1,:), position(2,:), 'LineWidth', 2);
title('Orbit in Position Space');
xlabel('X Position');
ylabel('Y Position');
axis equal;
grid on;

% backwardstep function definition
function [newp, newq] = backwardstep(p, q, h)
    f = @(x) [x(1) - p(1) + h*x(3)*(x(3)^2 + x(4)^2)^(-3/2), ...
              x(2) - p(2) + h*x(4)*(x(3)^2 + x(4)^2)^(-3/2), ...
              x(3) - q(1) - h*x(1), x(4) - q(2) - h*x(2)];
    x0 = [0; 0; 1; 1];
    
    opts = optimset('Diagnostics','off', 'Display','off', 'TolFun', 10^(-10));
    new = fsolve(f, x0, opts);
    
    newp = [new(1); new(2)];
    newq = [new(3); new(4)];
end


