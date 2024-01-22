% Initialization of Finite Element and Derivative Arrays
finite_elements = {};
finite_elements_derivative = {};
num_elements = 50;
small_offset = 1e-9; % Small epsilon to avoid boundary issues
step_size = (1 - small_offset) / num_elements;

% Generation of Finite Elements and their Derivatives
for i = 0:num_elements
    point = small_offset + i * step_size;
    finite_elements{i+1} = @(x) max(0, 1 - abs((x - point) / step_size));
    finite_elements_derivative{i+1} = @(x) (1 / step_size) * (x < point & x > (point - step_size)) - ...
                                          (1 / step_size) * (x > point & x < (point + step_size));
end

% Construct Coefficient Matrix A
A = zeros(num_elements + 1, num_elements + 1);
for i = 0:num_elements
    for j = 0:num_elements
        A(i+1, j+1) = integrate(@(x) finite_elements_derivative{i+1}(x) .* finite_elements_derivative{j+1}(x) .* x, small_offset, 1);
    end
end

% Iterative Solver Parameters
max_iterations = 1e6;
tolerance = 1e-5;
adjustment_factor = 0.005;

% Initial Guess for Iterative Solver
solution_guess = rand(num_elements + 1, 1);
solution_guess(1) = 1; % Boundary Condition at start
solution_guess(num_elements + 1) = 0; % Boundary Condition at end

% Iterative Solver Loop
difference = ones(num_elements + 1, 1);
iterations = 0;
while norm(difference) > tolerance && iterations < max_iterations
    derivatives = 2 * (A * solution_guess);
    difference = adjustment_factor * derivatives;
    difference(1) = 0; % Fixing the boundary values
    difference(num_elements + 1) = 0;

    solution_guess = solution_guess - difference;
    iterations = iterations + 1;
end

% Display Results
final_norm_of_difference = norm(difference);
disp(['Final norm of difference: ', num2str(final_norm_of_difference)]);
disp(['Iterations: ', num2str(iterations)]);

% Prepare for Plotting
coefficients = solution_guess;
num_plot_points = 100;
plot_step_size = (1 - small_offset) / num_plot_points;

% Generate Plot Points
xx = zeros(num_plot_points + 1, 1);
yy = zeros(num_plot_points + 1, 1);
for j = 0:num_plot_points
    result = 0;
    x_point = small_offset + j * plot_step_size;
    for i = 1:num_elements
        result = result + finite_elements{i}(x_point) * coefficients(i);
    end
    xx(j+1) = x_point;
    yy(j+1) = result;
end

% Plotting the Solution
plot(xx, yy);
title('Finite Element Method Solution');
xlabel('x');
ylabel('Solution y');

