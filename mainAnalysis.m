M = 1000;
points = rand(M, 2);

v1 = @(x) x(:, 2);
v2 = @(x) 1 - x(:, 1);

%Heaviside describes a function that is 1 if the argument is positive and 0 otherwise.
f = @(x) heaviside(0.1 - vecnorm(x - [0.5 0.5], 2, 2));
numPoints = size(points, 1);
N = 15;
paramsF = leastSquaresFit(points, f(points), N, numPoints, 2 * pi);
paramsV1 = leastSquaresFit(points, v1(points), N, numPoints, 2 * pi);
paramsV2 = leastSquaresFit(points, v2(points), N, numPoints, 2 * pi);

% The code above describes a procedure for fitting a function to a set of points.