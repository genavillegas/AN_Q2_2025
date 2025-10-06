EJERCICIO 3: Resolver el EJERCICIO 2, realizando la convolución por medio de la propiedad de la transformada de Fourier, utilizado el algoritmo FFT.
Para ello, redefinir los vectores x[n] y h[n] , con dimensión N = 2r (por ej.N=1024), de manera que tengan la misma longitud, agregando la zona nula necesaria en cada uno, teniendo en cuenta que la dimensión final N, debe ser suficiente para incluir todos los elementos no nulos de la respuesta y[n].
Realizar una Figura con 6 gráficos, en 3 filas y 2 columnas. En la primer columna, representar las señales en el tiempo discreto [n], en la segunda columna en las frecuencias discretas [k] de la FFT. Por ser las transformadas una variable compleja, representar sus módulos utilizando en comando abs.
Comparar los resultados obtenidos con los del EJERCICIO 2.
Notar el fenómeno de Gibbs en el espectro, debido al enventanado rectangular. Comparar los espectros de la señal de entrada y de salida.


EXPLICACION A GRANDES RASGOS
https://www.youtube.com/watch?v=OAXbLJkIFt0
min 1:35:00