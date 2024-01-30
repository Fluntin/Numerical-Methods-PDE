iteration_count = 7;
epsilon_value = 0.1;
initial_values = linspace(1, 0, 100)';

initial_delta = 10^(-10);

error_result = calculate_convergence(initial_values, initial_delta, iteration_count)
