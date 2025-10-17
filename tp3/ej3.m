# Limpiar variables, ventanas y consola
clear all; close all; clc;

# Parámetros de muestreo
delta_t = 0.0001;
Nx = 401; %cant muestras señal x
Fc = 800; %frec corte para h
Nh = 101; %cant muestras señal h

# Tiempo discreto para x[n]
t = 0:delta_t:(Nx-1)*delta_t; %tiempoInicio: avance : tiempoFin
x = 10 * cos(2*pi*150*t) + 5 * sin(2*pi*1000*t);
nx = 0:Nx-1;

# Tiempo discreto para h[n] centrada en n=0
n_medio = floor(Nh/2); % =50
nh = -n_medio:n_medio; %desde -50 : hasta 50
h = 2*Fc*delta_t*sinc(2*Fc*delta_t*nh);

# Longitud mínima de la convolucion
Ny = Nx + Nh - 1;
Nfft = 1024; %N = 2^r -> longitud del vector conv

# Completar con ceros (zeros padding) los vectores de x[n] y h[n]
x_pad = [x, zeros(1, Nfft - Nx)]; %senal x + ceros
h_pad = [h, zeros(1, Nfft - Nh)];

# FFT de x[n] y h[n]
X = fft(x_pad);
H = fft(h_pad);

# Convolución por propiedad de la FFT
% "conv en el tiempo es multiplicacion en la Frec"
Y = X .* H; %multiplicacion punto a punto
y_fft = (ifft(Y));

# Nuevo eje de tiempo y de frecuencia
ny = 0:Nfft-1;
k = 0: Nfft-1;

# Valor máximo para escalar todos los gráficos
valor_maximo1 = max(abs(y_fft)) + 0.5;
valor_maximo2 = max(abs(x)) + 0.5;
valor_maximo3 = max(abs(h)) + 0.05;
valor_maximo_fft = max([abs(X), abs(Y)]) + 50;
margen = 50;

# Crear ventana
figure();

# x[n]
subplot(3,2,1);
stem(ny, x_pad, 'filled', 'b', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([-valor_maximo2 valor_maximo2]);
title('x[n] - Señal muestreada');
xlabel('n'); ylabel('x[n]');
grid on;

# h[n]
subplot(3,2,3);
stem(ny, h_pad, 'filled', 'r', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([-0.05 valor_maximo3]);
title('h[n] - Respuesta al impulso');
xlabel('n'); ylabel('h[n]');
grid on;

# y[n] - salida
subplot(3,2,5);
stem(ny, y_fft, 'filled', 'g', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([-valor_maximo1 valor_maximo1]);
title('y[n] - Salida por FFT');
xlabel('n'); ylabel('y[n]');
grid on;



#FRECUENCIA

# |X[k]|
subplot(3,2,2);
stem(k, abs(X), 'filled', 'b', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([0 valor_maximo_fft]);
title('|X[k]| - Espectro de entrada');
xlabel('k'); ylabel('|X[k]|');
grid on;

# |H[k]|
subplot(3,2,4);
stem(k, abs(H), 'filled', 'r', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([0 1.15]);
title('|H[k]| - Espectro del filtro');
xlabel('k'); ylabel('|H[k]|');
grid on;

# |Y[k]|
subplot(3,2,6);
stem(k, abs(Y), 'filled', 'g', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-margen Nfft-1+margen]);
ylim([0 valor_maximo_fft]);
title('|Y[k]| - Espectro de la salida');
xlabel('k'); ylabel('|Y[k]|');
grid on;