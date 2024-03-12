clear all
close all

N = 100; % Number of spatial steps
a = 1.0; % Length of the spatial domain
T = 1.0; % Total time of the simulation
dx = a / (N + 1); % Spatial step size
dt = dx / 1.0; % Time step size, chosen based on stability condition
M = fix(T / dt); % Number of time steps

u = zeros(N, M); % Matrix to store the solution u at each grid point and time step
p = zeros(N, M); % Matrix to store the auxiliary variable (velocity) at each grid point and time step
A = zeros(N, N); % Coefficient matrix for the spatial discretization
F = zeros(N, 1); % Not used in the provided code, but typically for source terms or forcing functions
X = zeros(N, 1); % Vector to store the spatial grid points

% Initialization of the coefficient matrix A for the spatial discretization
for n = 2:N-1
    x = n * dx;
    X(n) = x;
    A(n, n) = -2 / dx^2;
    A(n, n+1) = 1 / dx^2;
    A(n, n-1) = 1 / dx^2;
    u(n, 1) = x * (1 - x); % Setting the initial condition for u
end

% Setting the boundary conditions for the spatial discretization matrix A
A(1, 1) = -2 / dx^2;
A(1, 2) = 1 / dx^2;
A(N, N) = -2 / dx^2;
A(N, N-1) = 1 / dx^2;
X(1) = dx;
X(N) = N * dx;

% Setting the boundary values for the initial condition of u
u(1, 1) = dx * (1 - dx);
u(N, 1) = (1 - dx) * dx;

% Time-stepping loop
for m = 1:M
    u(:, m+1) = u(:, m) + dt * p(:, m); % Updating u based on the previous u and p
    p(:, m+1) = p(:, m) + dt * A * u(:, m+1); % Updating p based on A and the new u
    % Plotting can be done here to visualize the solution at each time step
end

% Plotting the final wave profile
figure(2)
plot([0; X; 1], [0; u(:, M); 0], 'b', 'Linewidth', 1)
