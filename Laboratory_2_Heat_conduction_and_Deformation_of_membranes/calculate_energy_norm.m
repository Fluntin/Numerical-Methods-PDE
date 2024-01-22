function energy_norm = calculate_energy_norm(coefficients, derivative)
    energy_norm = 0;
    [n, ~] = size(derivative);
    h = 1 / n;
    
    for i = 1:n-1
        dydx = (derivative(i+1) - derivative(i)) / h;
        ai = coefficients(i / n);
        energy_norm = energy_norm + ai * dydx * dydx * h;
    end
    
    energy_norm = sqrt(energy_norm);
end
