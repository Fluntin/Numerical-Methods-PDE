function coefficients = CalculateFourierCoefficients(numberOfCoefficients, conditionType)
    % CalculateFourierCoefficients
    % Calculates Fourier coefficients based on the specified initial condition type.
    %
    % Arguments:
    % numberOfCoefficients - Number of Fourier coefficients to compute
    % conditionType - Type of initial condition (0 for g(x) = x(pi-x), otherwise g(x) = x on [0,pi/2], 0 on [pi/2, pi])
    %
    % Returns:
    % coefficients - Array of calculated Fourier coefficients

    coefficients = zeros(1, numberOfCoefficients);
    if conditionType == 0
        for termIndex = 1:numberOfCoefficients
            if mod(termIndex, 2) == 0
                coefficients(termIndex) = 0;
            else
                coefficients(termIndex) = 8/(pi * termIndex^3);
            end
        end
    else
        for termIndex = 1:numberOfCoefficients
            switch mod(termIndex, 4)
                case 0
                    coefficients(termIndex) = -pi/(2 * termIndex);
                case 1
                    coefficients(termIndex) = 1/(termIndex^2);
                case 2
                    coefficients(termIndex) = pi/(2 * termIndex);
                case 3
                    coefficients(termIndex) = -1/(termIndex^2);
            end
        end
    end
end