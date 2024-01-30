function matrix_A = generate_A_matrix(N, epsilon)
    % Generate A matrix with specified dimensions and epsilon value
    
    x_values = linspace(epsilon, 1, N);
    x_left = [x_values(2:end) 1];
    x_right = [epsilon x_values(1:end - 1)];
    
    main_diag = (N ./ (1 - epsilon))^2 ./ 2 .* (x_left.^2 - x_right.^2);
    super_diag = -(N ./ (1 - epsilon))^2 ./ 2 .* (x_values.^2 - x_right.^2);
    sub_diag = -(N ./ (1 - epsilon))^2 ./ 2 .* (x_left.^2 - x_values.^2);

    matrix_A = spdiags([sub_diag', main_diag', super_diag'], -1:1, N, N);
end