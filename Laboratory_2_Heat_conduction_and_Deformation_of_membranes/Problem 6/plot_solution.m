function plot_solution(x_values, u_values)
    figure; % Create a new figure window
    plot(x_values, u_values, 'b', 'LineWidth', 1); % Plot the solution with a blue line and thicker line width
    xlabel('x'); % Label the x-axis
    ylabel('u(x)'); % Label the y-axis
    title('Finite Element Solution'); % Add a title to the plot
    grid on; % Display grid lines
    axis tight; % Fit the axis limits to the data
    set(gca, 'FontSize', 12); % Increase font size for better readability
    legend('u(x)', 'Location', 'Best'); % Add a legend
end

