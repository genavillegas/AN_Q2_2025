# Limpiar variables, ventanas y consola
clear all; close all; clc;

# Parámetros
Fm = 10000;
delta_t = 1 / Fm;
Nx = 401;
Fc = 800;
Nh = 101;
Nfft = 1024;

# Señal de entrada x[n]
t = (0:Nx-1) * delta_t;
x = 10 * cos(2*pi*150*t) + 5 * sin(2*pi*1000*t);
nx = 0:Nx-1;

# Respuesta al impulso h[n] con ventana de Hamming
n_medio = floor(Nh/2);
nh = -n_medio:n_medio;
h_ideal = 2*Fc*delta_t * sinc(2*Fc*delta_t*nh);

w_hamming = hamming(Nh)'; %
h = h_ideal .* w_hamming;

% Normalizar el filtro para ganancia unitaria en DC
h = h / sum(h);

% Convolución en tiempo discreto
y_conv = conv(x, h);

% Zero padding para FFT
x_pad = [x, zeros(1, Nfft - length(x))];
h_pad = [h, zeros(1, Nfft - length(h))];

% FFTs
X = fft(x_pad);
H = fft(h_pad);
Y = X .* H;
y_fft = real(ifft(Y));

% Ejes
ny = 0:Nfft-1;
t_n = ny * delta_t;
f_k = (0:Nfft-1) * Fm / Nfft;

% Escalado visual
max_y = max(abs(y_conv)) + 0.5;
max_x = max(abs(x)) + 0.5;
max_h = max(abs(h)) + 0.05;
max_fft = max([abs(X), abs(Y)]) + 50;

% Crear ventana
figure();

% Columna 1: Señales en t
subplot(4,2,1);
stem(t_n, x_pad, 'filled', 'b', 'MarkerSize', 1);
xlim([-0.01 max(t_n)]); ylim([-max_x max_x]);
title('x[n] - Entrada');
xlabel('n (s)'); ylabel('x[n]');
grid on;

subplot(4,2,3);
stem(t_n, h_pad, 'filled', 'r', 'MarkerSize', 1);
xlim([0 max(t_n)]); ylim([-0.05 max_h]);
title('h[n] - Filtro paso bajo (Hamming)');
xlabel('n (s)'); ylabel('h[n]');
grid on;

subplot(4,2,5);
stem(t_n, y_fft, 'filled', 'g', 'MarkerSize', 1);
xlim([0 max(t_n)]); ylim([-max_y max_y]);
title('y[n]) - Salida por FFT');
xlabel('n (s)'); ylabel('y[n]');
grid on;

subplot(4,2,7);
stem((0:length(y_conv)-1)*delta_t, y_conv, 'filled', 'm', 'MarkerSize', 1);
xlim([0 max(t_n)]); ylim([-max_y max_y]);
title('y[n] - Salida por convolución directa');
xlabel('n (s)'); ylabel('y[n]');
grid on;



% Columna 2: Espectros en F
subplot(4,2,2);
stem(f_k, abs(X), 'filled', 'b', 'MarkerSize', 1);
xlim([0 Fm/2]); ylim([0 max_fft]);
title('|X(f)| - Espectro entrada');
xlabel('f (Hz)'); ylabel('|X(f)|');
grid on;

subplot(4,2,4);
stem(f_k, abs(H), 'filled', 'r', 'MarkerSize', 1);
xlim([0 Fm/2]); ylim([0 1.1]);
title('|H(f)| - Espectro del filtro');
xlabel('f (Hz)'); ylabel('|H(f)|');
grid on;

subplot(4,2,6);
stem(f_k, abs(Y), 'filled', 'g', 'MarkerSize', 1);
xlim([0 Fm/2]); ylim([0 max_fft]);
title('|Y(f)| - Espectro salida por FFT');
xlabel('f (Hz)'); ylabel('|Y(f)|');
grid on;

subplot(4,2,8);
Y_conv_fft = fft([y_conv, zeros(1, Nfft - length(y_conv))]);
stem(f_k, abs(Y_conv_fft), 'filled', 'm', 'MarkerSize', 1);
xlim([0 Fm/2]); ylim([0 max_fft]);
title('|Y(f)| - Espectro salida por convolución directa');
xlabel('f (Hz)'); ylabel('|Y(f)|');
grid on;

% Título general
annotation('textbox', [0.1, 0.95, 0.8, 0.05], ...
    'String', sprintf('Filtro Paso Bajo con Ventana Hamming - Fm = %d Hz, Δt = %.5f s', Fm, delta_t), ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
    'FontSize', 14, 'FontWeight', 'bold');

