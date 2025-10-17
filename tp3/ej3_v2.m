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


%-------------------------------Graficos en el tiempo---------------------------------%
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





%-------------------------------Graficos en frecuencia---------------------------------%

%% FIGURA ADICIONAL: Espectros centrados en frecuencia (Hz)
Fs = 1/delta_t; % Frecuencia de muestreo en Hz
f = (-Nfft/2:Nfft/2-1) * (Fs/Nfft); % Eje de frecuencia centrado en Hz

% Centrar espectros con fftshift
Xc = fftshift(X);
Hc = fftshift(H);
Yc = fftshift(Y);

# |X[k]| (espectro discreto)
subplot(3,2,2);
stem(f, abs(Xc), 'filled', 'b', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-Fs/2 Fs/2]); ylim([0 valor_maximo_fft]);
title('|X(f)| - Espectro de entrada centrado');
xlabel('Frecuencia [Hz]'); ylabel('|X(f)|'); grid on;
% Anotar picos principales en X: ±150 Hz y ±1000 Hz
hold on;
frecsX = [150, 1000];
ymaxX = max(abs(Xc));
for f0 = frecsX
    [~, ip] = min(abs(f - f0));
    [~, in] = min(abs(f + f0));
    plot(f(ip), abs(Xc(ip)), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
    plot(f(in), abs(Xc(in)), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
    text(f(ip), abs(Xc(ip)) + 0.05*ymaxX, sprintf('%.0f Hz', f(ip)), 'Color', 'b', 'HorizontalAlignment', 'center', 'FontSize', 8);
    text(f(in), abs(Xc(in)) + 0.05*ymaxX, sprintf('%.0f Hz', f(in)), 'Color', 'b', 'HorizontalAlignment', 'center', 'FontSize', 8);
end
hold off;

# |H[k]| (espectro discreto)
subplot(3,2,4);
stem(f, abs(Hc), 'filled', 'r', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-Fs/2 Fs/2]); ylim([0 1.15]);
title('|H(f)| - Espectro del filtro centrado (escalón pasa-bajos)');
xlabel('Frecuencia [Hz]'); ylabel('|H(f)|'); grid on;
hold on;
plot([Fc Fc], [0 1.15], 'k--', 'LineWidth', 1);
plot([-Fc -Fc], [0 1.15], 'k--', 'LineWidth', 1);
text(Fc+50, 0.5, sprintf('Fc=%d Hz', Fc), 'FontSize', 9);
hold off;

# |Y[k]| (espectro discreto)
subplot(3,2,6);
stem(f, abs(Yc), 'filled', 'g', 'LineWidth', 0.2, 'MarkerSize', 1);
xlim([-Fs/2 Fs/2]); ylim([0 valor_maximo_fft]);
title('|Y(f)| - Espectro de salida centrado');
xlabel('Frecuencia [Hz]'); ylabel('|Y(f)|'); grid on;
% Anotar picos que permanecen en Y (después del filtrado): ±150 Hz
hold on;
frecsY = [150];
ymaxY = max(abs(Yc));
for f0 = frecsY
    [~, ip] = min(abs(f - f0));
    [~, in] = min(abs(f + f0));
    plot(f(ip), abs(Yc(ip)), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 4);
    plot(f(in), abs(Yc(in)), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 4);
    text(f(ip), abs(Yc(ip)) + 0.05*ymaxY, sprintf('%.0f Hz', f(ip)), 'Color', 'g', 'HorizontalAlignment', 'center', 'FontSize', 8);
    text(f(in), abs(Yc(in)) + 0.05*ymaxY, sprintf('%.0f Hz', f(in)), 'Color', 'g', 'HorizontalAlignment', 'center', 'FontSize', 8);
end
hold off;

annotation('textbox', [0.1, 0.96, 0.8, 0.04], ...
    'String', 'Espectros centrados con fftshift - Eje en Hz', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
    'FontSize', 12, 'FontWeight', 'bold');

