EJERCICIO 4: Realizar la implementación en Octave, de un filtro paso bajo, con 
el ejemplo del sistema y señal de entrada de los ejercicios anteriores. 

Dada  la  importancia  conceptual  de  la  frecuencia  de  muestreo  (Fm),  introducir 
este  parámetro  como  dato  en  el programa,  y  utilizarlo  en  las  expresiones  que 
corresponda, sustituyendo principalmente al Δt. 

A diferencia de la respuesta al impulso h[n] utilizada en los EJERCICIOS 2 y 3, 
utilizar  una  ventana  de  Hamming  (con  el  comando  haming)  para  reducir  el 
fenómeno de Gibbs en el espectro y mejorar la respuesta del sistema, realizando 
posteriormente su correspondiente normalizado. 

Obtener la respuesta del sistema, utilizando convolución en el tiempo y 
convolución FFT, para comparar resultados. 

Representar  en  una  figura,  8  gráficos  en  4  filas  y  2  columnas.  En  la  primer 
columna, las señales en el tiempo, identificando en el eje horizontal los tiempos 
continuos (en segundos), correspondientes a los valores de las muestras. En la 
segunda columna, los módulos de los espectros correspondientes, en función de 
los valores de frecuencias analógicas (en hz) correspondientes a las muestras.  
Para el espectro de la respuesta, utilizar el gráfico obtenido del proceso FFT, en 
la representación de las dos salidas (por tiempo y por FFT). 
Verificar la mejora en el espectro H(f) reduciendo el fenómeno de Gibbs. 
Investigar  los  cambios  en  la  calidad  de  su  comportamiento  en  la  banda  de 
transición, donde el filtro ideal es discontinuo, al modificar las dimensiones del 
Núcleo del filtro (h[n]). 
Investigar  los  cambios  en  la  calidad  del  espectro  de  la  señal  de  entrada,  al 
modificar el tamaño de la ventana no nula, y verifique el efecto enventanado, si 
se lo compara con el espectro de la misma señal cuando su longitud es infinita. 
Verifique, las modificaciones en la calidad de representación de las señales en 
tiempo discreto y frecuencias, al modificar la frecuencia de muestreo Fm. 