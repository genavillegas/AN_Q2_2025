EJERCICIO 2: En base a lo programado en el EJERCICIO 1, 

Definir una señal de entrada en tiempo discreto x[n], como muestras de la señal analógica 
x(t) = 10 cos (2.π.150.t) + 5 sen (2.π.1000.t) -(señal con frecuencias de 30 hz y 1000 hz).

Seleccionar una ventana de muestreo de Nx muestras, y un valor de Δt.
(por ejemplo 401 muestras separadas 0.0001 s) con inicio en t = 0 s.

Definir el vector de tiempo discreto, correspondiente a la respuesta al impulso del sistema. 
Para ello introducir un parámetro Fc (frecuencia de corte) cuyo valor esté comprendido ENTRE las frecuencias de la señal analógica x(t)
( por ejemplo Fc = 1000 hz).    
Con el mismo Δt utilizado en el muestreo de x(t), definimos    h[n]=2.Fc. Δt. sinc(2. Fc. Δt. n). Esta señal, se posiciona centrada en el eje [n], por lo que si el vector tiene dimensiones Nh (impar), sus valores no nulos van de –(Nh-1)/2 a (Nh-1)/2.

Obtener la respuesta y[n], utilizando como antes el comando conv,

Realizar los gráficos de las tres señales vs [n], como en el EJERCICIO 1, ajustando la representación en una misma escala de tiempos n, cuyos límites coincidan con los elementos no nulos de la respuesta.

Resolver el ejercicio nuevamente cambiando el valor de Δt de 0.0001 a 0.0005 y a 0.001, Tambien modificando el valor de Nh. Observar las diferencias y sacar conclusiones.