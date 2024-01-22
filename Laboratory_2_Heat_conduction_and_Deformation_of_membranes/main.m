clear all;

% Define functions f(x), a(x), and the boundary value g
f_x = @(x) exp(x);          % Function f(x)
a_x = @(x) exp(x);          % Function a(x)
boundary_value = 1;         % Boundary value at x=1

% Initialization of Finite Elements and their Derivatives
num_elements = 400;         % Number of finite elements
step_size = 1 / num_elements; % Step size for elements

finite_elements = cell(1, num_elements);
finite_elements_derivative = cell(1, num_elements);

% Generation of Finite Elements and their Derivatives
for i = 1:num_elements
    point = i * step_size;
    finite_elements{i} = @(x) max(0, 1 - abs((x - point) / step_size));
    finite_elements_derivative{i} = @(x) (1 / step_size) * (x < point & x > (point - step_size)) - ...
                                        (1 / step_size) * (x > point & x < (point + step_size));
end

% Initialize Coefficient Matrix and Target Vector
A = zeros(num_elements, num_elements);
target = zeros(num_elements, 1);

% Assemble the System of Equations
for i = 1:num_elements
    v_prime = finite_elements_derivative{i};
    v = finite_elements{i};
    target(i) = gauss_integrate(@(x) f_x(x) .* v(x), (i-1)/num_elements, (i+1)/num_elements, 2);
    
    % Add boundary condition to the target if at the last element
    if i == num_elements
        target(i) = target(i) + boundary_value;
    end
    
    % Construct the Coefficient Matrix A
    for j = 1:num_elements
        u_prime = finite_elements_derivative{j};
        A(i, j) = integrate(@(x) u_prime(x) .* v_prime(x) .* a_x(x), 0, 1);
    end
end

% Solve the Linear System
coefficients = A \ target;

% Prepare for Plotting
num_plot_points = 1000;
plot_step_size = 1 / num_plot_points;
xx = zeros(num_plot_points, 1);
yy = zeros(num_plot_points, 1);

% Generate Plot Points
for j = 1:num_plot_points
    result = 0;
    x_point = (j - 1) * plot_step_size;
    for i = 1:num_elements
        result = result + finite_elements{i}(x_point) * coefficients(i);
    end
    xx(j) = x_point;
    yy(j) = result;
end

% Plotting the Finite Element Method Solution
hold on;
plot(xx, yy);
title('Finite Element Method Solution');

% Exact Solution Plotting
exact_solution = @(x) integrate(@(y) (boundary_value + integrate(@(z) f_x(z), y, 1)) / a_x(y), 0, x);
xxx = linspace(0, 1, 200);
yyy = arrayfun(exact_solution, xxx);
plot(xxx, yyy);
legend('FEM Solution', 'Exact Solution');
hold off;
