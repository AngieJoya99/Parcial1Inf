# Parcial 1 Inf. Paralelas - Angie Joya - 2322609

# Desarrollo y Ejecución

La ejecución de las versiones secuencial y paralelas del programa se encuentran documentadas en el archivo Parcial1.ipynb

El programa se ejecutó en un computador con un procesador de 12 núcleos, como se puede observar en el archivo

# Modificaciones

Las modificaciones que se realizaron respecto al código inicial son las siguientes: 

**Makefile:** Se añadió el argumento -fopenmp en la instrucción compile para hacer uso de la librería OpenMP en las versiones paralelas.

**all.sh:** Se añadió un directorio de imágenes en vez de una imagen puntual. El procesamiento y llamados a funciones auxiliares en python se realizó dentro de un for que recorre el directorio donde están las imágenes para queel proceso se realizara en todas las instancias. Además, dentro del for se usó un comando de python para calcular el ancho y alto de las imagenes, puesto que inicialmente el programa solo funcionaba para imágenes de 1028 x 1028, y estos valores se le pasaron como argumento al main y a fromBin2PNG.py.

**fromBin2PNG.py:** Se leyeron el alto y ancho de las imágenes de los argumentos que recibió en vez de usar 1024 para ambos.

**main.c - Versión Secuencial:** Se leyeron el alto y ancho de las imágenes de los argumentos que recibió en vez de usar 1024 para ambos. Se cambió la condición para imprimir el mensaje "Dar un nombre de archivo de entrada" de 2 argumentos a 4. Se cambió la función aplicarFiltro a la indicada en el enunciado del parcial.

**main.c - Versión Paralela - Hilos = Nucleos:** Además de los cambios implementados en la versión secuencial, se importó <omp.h> para hacer uso de openmp, se implementó openMP en el for de la función aplicarFiltro, se implementó openMP en el for de la función calcularSumaPixeles con el argumento reduction(+:suma).

**main.c - Versión Paralela - Hilos = 2 x Nucleos:** Además de los cambios implementados en la versión paralela anterior, se calculó la cantidad de núcleos del procesador con el comando omp_get_num_procs(), este número se multiplicó por dos, y el resultado se ingresó dentro del argumento num_threads() en las definiciones de OpenMP para modificar 

# Mediciones

**Versión Secuencial:** Se obtuvieron los siguentes tiempos de ejecución

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 24,87     |
| 2    | 25,49     |
| 3    | 24,96     |
| 4    | 24,88    |
| 5    | 25,48     |

Se elimina el peor y el mejor tiempo y se calcula el promedio con los restantes, se obtiene

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 24,96     |
| 2    | 24,88    |
| 3    | 25,48     |
| Promedio    | 25,0    |

**Versión Paralela - 12 hilos** Se obtuvieron los siguentes tiempos de ejecución

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 21,47    |
| 2    | 22,97 |
| 3    | 20,93   |
| 4    | 21,85 |
| 5    | 22,78    |

Se elimina el peor y el mejor tiempo y se calcula el promedio con los restantes, se obtiene

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 21,47    |
| 2    | 21,85 |
| 3    | 22,78    |
| Promedio    | 22,03    |

**Versión Paralela - 24 hilos** Se obtuvieron los siguentes tiempos de ejecución

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 21,22   |
| 2    | 21,07|
| 3    | 20,15   |
| 4    | 20,35|
| 5    | 20,39  |

Se elimina el peor y el mejor tiempo y se calcula el promedio con los restantes, se obtiene

| Iteración | Tiempo (s) |
|------|------------|
| 1    | 21,07|
| 2    | 20,35|
| 3    | 20,39  |
| Promedio    | 20,60   |

# Speedup y conclusiones

Para calcular el speedup se debe definir cuál es la proporción del código que es parelelizable. Para definir esto, se contaron las líneas que se pueden paralelizar (23) entre el total de líneas (75) omitiendo las lineas vacías y los comentarios, y esto nos da una proporción del 0.32

**Versión Paralela - 12 hilos**: 

p = 0.32

1-p = 0.68

s = 25,0/22,03 = 1,13

S latency = 1/(0.68+(0.32/1.13)) = 1.04

Eficiencia = S latency / # hilos = 1.04/12 = 0.0866 = 8.67%


**Versión Paralela - 24 hilos**: 

p = 0.32

1-p = 0.68

s = 25,0/20,60 = 1,21

S latency = 1/(0.68+(0.32/1.21)) = 1.06

Eficiencia = S latency / # hilos = 1.06/24 = 0.0441 = 4.41%

**Conclusión**

El procesamiento en paralelo sí disminuye los tiempos de ejecución, pero requiere recursos adicionales y su rendimiento depende de la tarea a realizar. Si procesaramos mayor cantidadd de imágenes o imágenes de mayor tamaño, la eficiencia mejoraría. Utilizar 2 veces la cantidad de hilos disminuye el speedup, pero la diferencia no es muy grande por lo que la eficiencia disminuye considerablemente, pues se necesitan muchos más recursos, lo que no es proporcional a la mejora en tiempo.

