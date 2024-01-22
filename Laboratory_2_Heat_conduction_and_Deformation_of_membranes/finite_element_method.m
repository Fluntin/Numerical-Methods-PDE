clear all;

% Define functions f(x) and a(x), as well as the boundary value g
f_x = @(x) exp(x);               % Function f(x)
a_x = @(x) exp(x);               % Function a(x)
boundary_value = 1;             % Boundary value at x=1

% Define the number of mesh points
num_mesh_points = 100;          % Number of mesh points: 5, 10, 20, 40, 80, 160
x_values = linspace(0, 1, num_mesh_points + 1); % Equally spaced mesh points

for gauss_order = 1:2
    % Define weights and nodes for Gaussian quadrature on [-1, 1]
    if gauss_order == 2
        gauss_nodes = [-1/sqrt(3), 1/sqrt(3)];
        gauss_weights = [1, 1];
    elseif gauss_order == 1
        gauss_nodes = [0];
        gauss_weights = [2];
    else
        disp('Invalid number of points for Gaussian quadrature!');
        return;
    end

    % Initialize coefficient matrix (A) and load vector (L)
    A = zeros(num_mesh_points, num_mesh_points); % Coefficient matrix
    L = zeros(num_mesh_points, 1);               % Load vector

    for element = 1:num_mesh_points-1
        left_endpoint = x_values(element);       % Left endpoint of the element
        right_endpoint = x_values(element+1);    % Right endpoint of the element

        for gauss_point = 1:gauss_order
            % Gaussian quadrature points and weights
            xi = (right_endpoint - left_endpoint) / 2 * gauss_nodes(gauss_point) + ...
                 (left_endpoint + right_endpoint) / 2;
            weight = gauss_weights(gauss_point) * (right_endpoint - left_endpoint) / 2;

            % Shape functions and their derivatives
            phi_left = 1 - (xi - left_endpoint) / (right_endpoint - left_endpoint);
            phi_right = 1 - (right_endpoint - xi) / (right_endpoint - left_endpoint);
            phi_left_prime = -1 / (right_endpoint - left_endpoint);
            phi_right_prime = 1 / (right_endpoint - left_endpoint);

            % Evaluate f(x) and a(x) at the Gaussian point
            f_xi = f_x(xi);
            a_xi = a_x(xi);

            % Update the coefficient matrix A and the load vector L
            A(element, element) = A(element, element) + weight * a_xi * phi_left_prime * phi_left_prime;
            A(element, element+1) = A(element, element+1) + weight * a_xi * phi_left_prime * phi_right_prime;
            A(element+1, element) = A(element+1, element) + weight * a_xi * phi_right_prime * phi_left_prime;
            A(element+1, element+1) = A(element+1, element+1) + weight * a_xi * phi_right_prime * phi_right_prime;
            L(element) = L(element) + weight * phi_left * f_xi;
            L(element+1) = L(element+1) + weight * phi_right * f_xi;
        end

        % Apply boundary condition a(1)u'(1) = g:
        if element+1 == num_mesh_points
            L(element+1) = L(element+1) + boundary_value;
        end
    end

    % Apply boundary condition u(0) = 0:
    A(1, :) = 0;
    A(1, 1) = 1;
    L(1) = 0;

    % Solve the system of equations
    u = A \ L;

    % Plot the results (code to plot the exact solution is not provided)
    num_plot_points = 100;
    plot_step = 1 / num_plot_points;

    xx = zeros(num_plot_points, 1);
    yy = zeros(num_plot_points, 1);

    node_step = 1 / (num_mesh_points - 1);
    for j = 1:num_plot_points
        result = 0;
        x_j = (j-1) * plot_step;
        for i = 1:num_mesh_points
            node = (i-1) * node_step;
            diff = abs(x_j - node);
            phi_i = max(0, 1 - abs(diff / node_step));
            result = result + phi_i * u(i);
        end
        xx(j) = x_j;
        yy(j) = result;
    end
    figure;
    hold on
    plot(xx, yy);

    % Plot the exact solution (code for the exact solution plot is not provided)

    gauss_order
    num_mesh_points
    diff = yy - real(xx);          % Calculate the difference between FEM and exact
    energy_norm = energynorm(a_x, diff); % Calculate the energy norm
end

