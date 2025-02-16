% Constants
mass = 5.0; % kg (UAV mass)
gravity = 9.81; % m/s^2
rho = 1.225; % kg/m^3 (air density)
wing_area = 0.5; % m^2 (wing area)
drag_coefficient = 0.05; % dimensionless
efficiency = 0.8; % propulsion efficiency

% Energy consumption model
function power_required = energy_consumption(speed, altitude)
    global rho wing_area drag_coefficient efficiency
    drag_force = 0.5 * rho * speed^2 * wing_area * drag_coefficient;
    power_required = drag_force * speed / efficiency; % Power in Watts
end

% Gradient descent optimization
function [speed_history, energy_history] = gradient_descent(learning_rate, epochs)
    global rho wing_area drag_coefficient efficiency
    
    speed = 10.0; % Initial speed (m/s)
    altitude = 100.0; % Initial altitude (m)
    
    speed_history = zeros(epochs, 1);
    energy_history = zeros(epochs, 1);
    
    for i = 1:epochs
        energy = energy_consumption(speed, altitude);
        energy_history(i) = energy;
        speed_history(i) = speed;
        
        % Compute the gradients (partial derivatives)
        grad_speed = (energy_consumption(speed + 0.1, altitude) - energy) / 0.1;
        
        % Update the speed (gradient descent step)
        speed = speed - learning_rate * grad_speed;
    end
end

% Run optimization
learning_rate = 0.1;
epochs = 100;
[speed_history, energy_history] = gradient_descent(learning_rate, epochs);

% Visualization
figure;
subplot(1, 2, 1);
plot(1:epochs, speed_history, 'b', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Speed (m/s)');
title('Speed Optimization');
grid on;
legend('Speed');

subplot(1, 2, 2);
plot(1:epochs, energy_history, 'r', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Energy Consumption (W)');
title('Energy Consumption');
grid on;
legend('Energy');

sgtitle('UAV Energy Optimization using Gradient Descent');

% Save the plot as an image
saveas(gcf, 'uav_energy_optimization.png');
