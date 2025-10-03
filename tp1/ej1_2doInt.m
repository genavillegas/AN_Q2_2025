#limpiar variables, ventanas y consola
clear; close all; clc;


#definimos intervalos de tiempo [desde;hasta]
%para la senal x
nx = -2:2;
%para la senal h
nh = 0:2;


# Señales de Pulsos rectangulares
% senal de pulsos unitarios con longitud = vector nx
x = ones(1, length(nx));
%h = randi([1 3], 1, length(nh));
h = [1,2,3];

# Convolución
y = conv(x, h);
%en cual rango se hizo la convolucion
ny = nx(1) + nh(1) : nx(end) + nh(end);

# Rango para todos los gráficos - valor n
t_min = min([nx, nh, ny]) - 1;
t_max = max([nx, nh, ny])+ 1;


%Definimos valor máximo eje y
valor_maximo = max([x, h, y]) + 1;

% Crear ventana
figure('Position', [100, 100, 700, 580]);

# Senal x[n]
subplot(3,1,1);
stem(nx, x, 'filled', 'y', 'LineWidth', 1.5);
xlim([t_min t_max]);
xticks(t_min:t_max);
ylim([0 valor_maximo]);
title('x[n] - Senal de Entrada');
xlabel('n'); ylabel('x[n]');
grid on;
for k = 1:length(nx)
    text(nx(k), x(k)+0.1, num2str(x(k)), 'HorizontalAlignment', 'center');
end

#Senal h[n]
subplot(3,1,2);
stem(nh, h, 'filled', 'r', 'LineWidth', 1.5);
xlim([t_min t_max]);
xticks(t_min:t_max);
ylim([0 valor_maximo]);
title('h[n] - Respuesta al Impulso');
xlabel('n'); ylabel('h[n]');
grid on;
for k = 1:length(nh)
    text(nh(k), h(k)+0.1, num2str(h(k)), 'HorizontalAlignment', 'center');
end

% y[n]
subplot(3,1,3);
stem(ny, y, 'filled', 'g', 'LineWidth', 1.5);
xlim([t_min t_max]);
xticks(t_min:t_max);
ylim([0 valor_maximo]);
title('y[n] - Salida del sistema');
xlabel('n'); ylabel('y[n]');
grid on;
for k = 1:length(ny)
    text(ny(k), y(k)+0.1, num2str(y(k)), 'HorizontalAlignment', 'center');
end
