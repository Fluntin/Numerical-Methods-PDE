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
