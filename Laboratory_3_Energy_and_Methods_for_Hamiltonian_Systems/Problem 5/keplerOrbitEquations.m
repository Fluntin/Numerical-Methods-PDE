function derivatives = keplerOrbitEquations(time, state)
    % KeplerOrbitEquations: Computes the derivatives for Kepler's problem
    % Input:
    %   time: Time variable (not used in the calculation but required by ode45)
    %   state: Current state vector of the orbit [x position; y position; x velocity; y velocity]
    % Output:
    %   derivatives: Derivatives of the state vector [x velocity; y velocity; x acceleration; y acceleration]

    xPosition = state(1);
    yPosition = state(2);
    xVelocity = state(3);
    yVelocity = state(4);

    % Gravitational acceleration components
    rSquared = xPosition^2 + yPosition^2;
    rCubed = rSquared^(3/2);
    xAcceleration = -xPosition / rCubed;
    yAcceleration = -yPosition / rCubed;

    % Returning the derivatives
    derivatives = [xVelocity; yVelocity; xAcceleration; yAcceleration];
end
