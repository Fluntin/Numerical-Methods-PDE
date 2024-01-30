% Main script
initial_values = linspace(1, 0, 100)';
epsilon_value = 10^-2;

delta_step = 10^-3;
max_iterations = 5000;

x_values = linspace(epsilon_value, 1, length(initial_values));
resultant_values = calculate_gradient(initial_values, delta_step, max_iterations, epsilon_value);

plot(x_values, resultant_values)
