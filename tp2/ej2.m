#limpiar variables, ventanas y consola
clear; close all; clc;

#definir parametros
f1 = 30; % Primera componente
f2 = 1000; % Segunda componente (F max)

Nx = 401; % Numero de muestras
#Deltas tiempos propuestas enunciado
delta_t= 0.0001; % Delta tiempo inicial propuesta
delta_t2= 0.0005;
delta_t3= 0.001;

#Fc (frecuencia de corte) cuyo valor este
#comprendido ENTRE las frecuencias de la señal analógica x(t)
Fc = 800; % Frecuencia de corte parametro

#Definimos x[n] (señal analogica) dentro de la ventana
nx = 0:Nx - 1; %desde 0 al 400 -> 401 valores
x = 10 * cos(2*pi*f1*delta_t*nx) + 5 * sin(2*pi*f2*delta_t*nx);


# Definimos h[n] (filtro paso bajo dado que es un sinc)
Nh = 51; %cant muestras del sinc (con mismo delta_t)
nh = -(Nh-1)/2:(Nh-1)/2;
h = 2*Fc*delta_t*sinc(2*Fc*delta_t*nh);

# Obtenemos y[n]
ny = nx(1) + nh(1) : nx(end) + nh(end);%tamaño en abscisas de y
y = conv(x, h);

# Creacion de grafico
figure('Position', [100, 100, 800, 580]);
limInf = -(Nh-1)/2; limSup = Nx -1 +50; %limites auto de eje abscisas

# Gráfica de la x[n] - señal de entrada
subplot(3,1,1);
stem(nx, x, 'k.');
title('x[n] - Señal de Entrada - Comb de sen y cos');
legend('x[n]');
xlabel('n');
ylabel('Amplitud');
xlim([limInf, limSup]); % Como son 300 muestras
grid on;

# Gráfica de la h[n] - respuesta al impulso
subplot(3,1,2);
stem(nh, h, 'r.');
title('h[n] - Respuesta al Impulso - Señal sinc');
legend('h[n]');
xlabel('n');
ylabel('Amplitud');
xlim([limInf, limSup]);
grid on;

# Gráfica de la y[n] - señal de salida
subplot(3,1,3);
stem(ny, y, 'g.');
title('y[n] - Señal de Salida');
legend('y[n]');
xlabel('n');
ylabel('Amplitud');
xlim([limInf, limSup]);
grid on;


# Título del Grafico
annotation('textbox', [0.1, 0.95, 0.8, 0.05], ...
    'String', 'Convolución de señales x[n] * h[n]', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
    'FontSize', 14, 'FontWeight', 'bold');

# Guardar figura
%print -dpng 'convolucion-temporal.png';
