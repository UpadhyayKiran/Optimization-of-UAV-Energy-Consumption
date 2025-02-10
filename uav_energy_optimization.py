import numpy as np
import matplotlib.pyplot as plt

# Constants
mass = 5.0  # kg (UAV mass)
gravity = 9.81  # m/s^2
rho = 1.225  # kg/m^3 (air density)
wing_area = 0.5  # m^2 (wing area)
drag_coefficient = 0.05  # dimensionless
efficiency = 0.8  # propulsion efficiency

# Energy consumption model
def energy_consumption(speed, altitude):
    drag_force = 0.5 * rho * speed**2 * wing_area * drag_coefficient
    power_required = drag_force * speed / efficiency  # Power in Watts
    return power_required

# Gradient descent optimization
def gradient_descent(learning_rate=0.1, epochs=100):
    speed = 10.0  # Initial speed (m/s)
    altitude = 100.0  # Initial altitude (m)
    
    speed_history = []
    energy_history = []
    
    for _ in range(epochs):
        energy = energy_consumption(speed, altitude)
        energy_history.append(energy)
        speed_history.append(speed)
        
        # Compute the gradients (partial derivatives)
        grad_speed = (energy_consumption(speed + 0.1, altitude) - energy) / 0.1
        
        # Update the speed (gradient descent step)
        speed -= learning_rate * grad_speed
        
    return speed_history, energy_history

# Run optimization
speed_history, energy_history = gradient_descent()

# Visualization
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(speed_history, label='Speed (m/s)')
plt.xlabel('Iteration')
plt.ylabel('Speed')
plt.legend()

plt.subplot(1, 2, 2)
plt.plot(energy_history, label='Energy Consumption (W)')
plt.xlabel('Iteration')
plt.ylabel('Energy')
plt.legend()

plt.suptitle('UAV Energy Optimization using Gradient Descent')

# Save the plot as an image
plt.savefig("uav_energy_optimization.png", dpi=300, bbox_inches='tight')

# Show the plot
plt.show()