function output_values = calculate_gradient(input_values, delta, iterations, epsilon)
    % Calculate gradient with given parameters
    
    N = length(input_values);
    A_matrix = generate_A_matrix(N, epsilon);
    
    for n = 1:iterations
        input_values = input_values - 2 .* delta .* A_matrix * input_values;
        input_values(1) = 1;
        input_values(end) = 0;
    end
    
    output_values = input_values;
end