# Explicación de la tarea 1

En esta tarea se han generado 5 ficheros:

```
shell.sh
pipe-1.sh
pipe-2.sh
public-transports-sql.py
leisure-sql.py
```

El script `shell.sh` contiene las funciones necesarias para instalar todas las herramientas y ficheros necesarios. Por otra parte en este script también se reduce la cantidad de datos solo a la ciudad de Madrid. Se ha realizado de este modo porque _osmfilter_ no puede leer de entrada de estándar. Se podría haber hecho el recorte con el polígono de la ciudad de Madrid en cada uno de los dos pipes, usando el pipe `| true |` para concatenar, pero eso genera una duplicidad de código, cosa que en la asignatura se considera de mala praxis, además que aumentaría el tiempo de ejecución, ya que el recorte usando el polígono tarda de media unos ~5 segundos.

El contenido de los ficheros `pipe-1.sh` y `pipe-2.sh` son los respectivos pipes que se piden en el enunciado. El primero está asociado al transporte público que filtra primero por los nodos del fichero `madrid.o5m` y llama posteriormente al script de python correspondiente para meter los datos en la base de datos. El segundo pipe realiza lo mismo pero con las cafeterías, bares y restaurantes.
