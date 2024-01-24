clear all;
%----------------------------------------------------------------
% Define functions f(x) and a(x), as well as the boundary value g
%----------------------------------------------------------------

% Alternative => 1
% f_x = @(x) exp(x); a_x = @(x) exp(x);  

%----------------------------------------------------------------

% Alternative => 2
f_x = @(x) 0; a_x = @(x) 1 + x;          
     
%----------------------------------------------------------------

boundary_value = 1;              % Boundary value at x=1
real_solution = @(x) (1+exp(1))*(1-exp(-1*x)) - x; % Exact solution

%----------------------------------------------------------------
% Define the number of mesh points
num_mesh_points = 100;           % Number of mesh points
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

    % Plot the results
    num_plot_points = num_mesh_points;
    plot_step = 1 / num_plot_points;

    xx = zeros(num_plot_points, 1);
    yy = zeros(num_plot_points, 1);

    node_step = 1 / (num_mesh_points - 1);
    for j = 1:num_plot_points
        x_j = (j-1) * plot_step;
        xx(j) = x_j;
        yy(j) = sum(arrayfun(@(i) max(0, 1 - abs(x_j - (i-1) * node_step) / node_step) * u(i), 1:num_mesh_points));
    end
    figure;
    hold on;
    
    % Plot FEM Solution
    plot(xx, yy, 'LineWidth', 2, 'LineStyle', '-', 'Color', [1, 0, 0], 'DisplayName', 'FEM Solution'); % Red
    
    % Plot Exact Solution
    plot(xx, arrayfun(real_solution, xx), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0, 0, 0], 'DisplayName', 'Exact Solution'); % Black
    
    % Enhance the plot with labels, legend, and grid
    xlabel('x', 'FontSize', 12);
    ylabel('Solution', 'FontSize', 12);
    title(['Gaussian Quadrature Order: ', num2str(gauss_order)], 'FontSize', 14);
    legend('Location', 'best');
    grid on;
    box on;

% Calculate the difference between FEM and exact solution
diff = yy' - arrayfun(real_solution, x_values(1:end-1)); % Ensure diff has size n

% Calculate the energy norm
energy_norm = calculate_energy_norm(a_x, diff, x_values);
disp(['Energy norm for Gauss order ', num2str(gauss_order), ': ', num2str(energy_norm)]);

end

function energy_norm = calculate_energy_norm(a, diff, x_values)
    energy_norm = sqrt(sum(arrayfun(@(i) a((x_values(i) + x_values(i+1))/2) * (diff(i+1) - diff(i))^2 / (x_values(i+1) - x_values(i)), 1:length(x_values)-2)));
end