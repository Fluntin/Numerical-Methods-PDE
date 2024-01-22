function result = integrate(fun, start, stop)
    % INTEGRATE Numerically integrates a given function over a specified interval.
    % Usage: result = integrate(fun, start, stop)
    % Where:
    %   fun   - A handle to the function to be integrated.
    %   start - The starting point of the integration interval.
    %   stop  - The ending point of the integration interval.
    %
    % This function uses a simple Riemann sum approach for integration,
    % which may not be highly accurate for complex functions or large intervals.
    % For more accuracy, MATLAB's built-in 'integral' function is recommended.
    
    % Set the step size for the integration
    stepSize = 0.001;

    % Initialize the result
    result = 0;

    % Iterate over the interval with the specified step size
    for x = start:stepSize:stop
        result = result + fun(x) * stepSize;
    end
end