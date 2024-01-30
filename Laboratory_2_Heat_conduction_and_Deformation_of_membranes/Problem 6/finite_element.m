function [x_result, u_result] = finite_element(epsilon, num_intervals)
    % Inputs:
    % epsilon: Lower bound such that epsilon <= r <= 1
    % num_intervals: Number of intervals (one less than the number of x values)

    % Generate evenly spaced x values from epsilon to 1
    x_result = linspace(epsilon, 1, num_intervals + 1);

    % Calculate the left and right neighbor x values
    x_left_neighbor = [x_result(2:end), 1];
    x_right_neighbor = [epsilon, x_result(1:end - 1)];

    % Define the main, super, and sub-diagonals of the sparse matrix A
    main_diagonal = (num_intervals / (1 - epsilon))^2 / 2 .* (x_left_neighbor.^2 - x_right_neighbor.^2);
    super_diagonal = -(num_intervals / (1 - epsilon))^2 / 2 .* (x_result.^2 - x_right_neighbor.^2);
    sub_diagonal = -(num_intervals / (1 - epsilon))^2 / 2 .* (x_left_neighbor.^2 - x_result.^2);

    % Create the sparse matrix A using the diagonals
    A = spdiags([sub_diagonal', main_diagonal', super_diagonal'], -1:1, num_intervals + 1, num_intervals + 1);

    % Remove the boundary values and corresponding rows/columns
    L = A(2:end - 1, 1);
    A = A(2:end - 1, 2:end - 1);
    x_result = x_result(2:end - 1);

    % Solve for u_result using A and L
    u_result = A \ -L;
end
