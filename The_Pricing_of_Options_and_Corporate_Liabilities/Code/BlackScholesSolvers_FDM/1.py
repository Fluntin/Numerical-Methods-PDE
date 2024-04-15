import matplotlib.pyplot as plt
import numpy as np

# Define the budget lines
x = np.linspace(0, 300000, 100)
y1 = 300000 - x  # Original budget line without subsidy
y2 = np.clip(100000 + (300000 - x), 0, 300000)  # New budget line with subsidy

# Plot the budget lines
plt.figure(figsize=(8, 6))
plt.plot(x, y1, label='Without Subsidy', linestyle='--', color='blue')
plt.plot(x, y2, label='With Subsidy', color='green')

# Add example indifference curves
utility_levels = [150000, 250000, 290000]  # Example utility levels for indifference curves
colors = ['grey', 'darkgrey', 'lightgrey']
for u, color in zip(utility_levels, colors):
    y_util = np.clip(u - 0.75 * x, 0, 300000)
    plt.plot(x, y_util, label=f'Utility = {u}', linestyle=':', color=color)

# Mark points that describe the different scenarios
plt.scatter([200000], [100000], color='red', zorder=5, label='Resources on education remain the same')  # Point where resources on education are the same
plt.scatter([250000], [50000], color='purple', zorder=5, label='Resources on education decrease')  # Point where resources on education decrease
plt.scatter([150000], [150000], color='orange', zorder=5, label='Resources on education increase')  # Point where resources on education increase

# Set axis titles and legend
plt.title('Family Budget Lines and Indifference Curves with and without Public Schooling Subsidy')
plt.xlabel('Spending on Other Goods')
plt.ylabel('Spending on Education')
plt.legend()

plt.grid(True)
plt.show()
