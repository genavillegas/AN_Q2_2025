EJERCICIO 1: Utilizando el programa Octave, definir las siguientes señales de 
tiempo discreto: 
• x[n] como pulsos rectangulares de valor unitario, cuyos valores no nulos, 
se producen en un intervalo de tiempo discreto, guardado en el vector 
nx, tal que incluya valores de n positivos y negativos. 
•  h[n] con valores iguales a n, en un intervalo de tiempo guardados en un 
vector nh, comenzando por n=0 y todos positivos. 
Siendo x[n] la señal de entrada, y h[n] la respuesta al impulso de un sistema LTI, 
obtener la respuesta del mismo y[n], utilizando el comando conv.  
Representar en una figura, los gráficos de las tres señales (x[n], h[n] e y[n] vs 
[n]), en tres filas distintas utilizando los comandos subplot y stem. Emplear las 
mismas escalas de tiempo discreto en todos ellos (utilizar el comando xlim), 
teniendo en cuenta los tiempos necesarios, que incluyan todos los valores del 
resultado de la convolución.  