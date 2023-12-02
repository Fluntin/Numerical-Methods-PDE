% This is code for the Math described in the problem stament.

function result = evaluateFit(x, y, coefficients, kappa)
    [numParams, ~] = size(coefficients);
    N = floor((sqrt(numParams) - 1) / 2);
    result = zeros(size(x));
    
    for i = -N:N
        for j = -N:N
            result = result + coefficients((i + N) * (2 * N + 1) + j + N + 1) * exp(1i * kappa * (i * x + j * y));
        end
    end
    
    result = real(result);
end