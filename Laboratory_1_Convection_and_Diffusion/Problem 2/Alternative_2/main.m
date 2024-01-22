% FILEPATH: /Users/erikbou/Documents/MATLAB/PDE/LABB_1/getCoeff.m

fourierMatrix = zeros(1000, 169);

randomx = rand(1000, 2); % 1000 random points in [0,1]x[0,1]

index = 1;

for n1 = -6:6
    for n2 = -6:6
        for i = 1:1000
            x1 = randomx(i, 1);
            x2 = randomx(i, 2);
            fourierMatrix(i, index) = exp(2*pi*1i*(n1*x1 + n2*x2)); 
        end
        index = index + 1;
    end
end

f = zeros(1000, 1);

for i = 1:1000
    if norm(randomx(i, :) - [0.5, 0.5]) < 0.1
        f(i) = 1;
    else
        f(i) = 0;
    end
end 

vx = randomx(:, 2);
vy = 1-randomx(:, 1);

v_x_hat = fourierMatrix \ vx; 
v_y_hat = fourierMatrix \ vy;
f_hat = fourierMatrix \ f;


K = 50;
kh = 1/K; %step size for the respective value in the domain
h = 0.1;

U_matrix = getUValues(K, h, [v_x_hat v_y_hat], f_hat); %calculate the u values


[x, y] = meshgrid(0:kh:1); 

mesh(x, y, U_matrix'); %U_matrix is transposed to get the correct orientation was wrong without
title('Mesh plot with K = 50');
hold on;

figure; 
contour(x, y, U_matrix');
title('Contour plot with K = 50');
