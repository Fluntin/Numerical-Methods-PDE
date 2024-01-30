function error_values = calculate_convergence(initial_values, initial_delta, count)
    % Calculate convergence with given parameters
    
    epsilon_value = 0.1;
    iteration_limit = 2^10;
    reference_values = calculate_gradient(initial_values, initial_delta * 2^(count+2), iteration_limit, epsilon_value);

    delta_values = initial_delta ./ (2.^(1:count));
    error_values = [];
    
    for delta = delta_values
        calculated_values = calculate_gradient(initial_values, delta, iteration_limit, epsilon_value);
        error_values = [error_values norm(calculated_values - reference_values)];
    end
end

