% This is the function that computes the least squares fit of the input.
% The input is a set of points and the corresponding values at those points.
% The output is the coefficients of the least squares fit.

function coefficients = leastSquaresFit(inputPoints, inputValues, N, numPoints, kappa)
    numParams = (2 * N + 1) ^ 2;
    matrix = zeros(numPoints, numParams);

    for i = -N:N
        for j = -N:N
            for k = 1:numPoints
                matrix(k, (i + N) * (2 * N + 1) + j + N + 1) = exp(1i * kappa * (i * inputPoints(k, 1) + j * inputPoints(k, 2)));
            end
        end
    end

    % Use below only when K is large and/or N is large in the main code!
    coefficients = lsqr(matrix, inputValues, 10^(-6), 1000);
end
