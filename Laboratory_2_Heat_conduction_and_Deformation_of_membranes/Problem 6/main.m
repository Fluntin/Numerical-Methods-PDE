N = 2000;
eps = 0.000000001;

[x, u] = finite_element(eps, N);
plot_solution(x, u);

