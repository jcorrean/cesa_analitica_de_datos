library(tidyr)
library(tidyverse)

data("table1")
head(table1)
# "Table 1" tiene cuatro columnas 
# (country, year, cases, population) y seis filas.

# "Table 2" tiene 12 filas y cuatro columnas
# (country, year, type, count)

data("table2")
head(table2)


# "Table 3" tiene seis filas y tres columnas
# (country, year, rate)
data("table3")
head(table3)

# "Table4a" tiene tres columnas 
# (country, 1999, 2000) y tres filas.

data("table4a")
head(table4a)

# "Table4b" tiene tres columnas (country, 1999, 2000).
data("table4b")
head(table4b)

# Si recordamos el slide 13 de la sesión 3B, 
# será inmediatamente evidente que de todas estas
# tablas, la única que cumple con el principio de
# datos limpios es Table1, mientras que las 
# demás son versiones sucias de Table1. 
# Por fortuna, en R (y también en Python) 
# existen sintaxis que le permiten limpiar 
# bases de datos para dejarlas en formato limpio 
# y listo para usar.

### Aplicación 1: Gathering

# Gathering (del verbo reunir en inglés) 
# sirve para arreglar bases de datos que tienen
# columnas que en realidad muestran los valores 
# de una variable no mencionada explícitamente. Ejemplo:
  
table4a %>% gather(`1999`, `2000`, key = "year", value = "cases")


### Aplicación 2: Spreading

# Spreading (del verbo esparcir en inglés) 
# sirve para arreglar bases de datos que tienen 
# observaciones o registros esparcidos en diversas 
# filas (es la función opuesta a gathering). Ejemplo:
  
spread(table2, key = type, value = count)

### Aplicación 3: Separate

# Separate (del verbo separar en inglés) sirve 
# para separar registros que muestran observaciones 
# mezcladas de variables. Ejemplo:
  
table3 %>% separate(rate, into = c("cases", "population"))

### Aplicación 4: Unite

# Unite (del verbo unir en inglés) es el
# opuesto de separate. Ejemplo:
  
table5 %>% unite(new, century, year)


## Aplicaciones de datos relacionales

# Las aplicaciones de datos relacionales en R 
# dependen de la librería "dplyr" que también 
# pertenece al ecosistema de librerías "tidyverse".

library(nycflights13)

### Aplicación 5: Mutating joins

# Mutating joins (del inglés unión mutante) 
# sirve para combinar variables que provienen
# de dos tablas. En este ejemplo vamos a 
# combinar variables dispuestas en la tabla 
# flights con variables dispuestas en la tabla 
# airlines, a través de la función "left_join".

flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)
head(flights2)
flights2 %>% select(-origin, -dest) %>% left_join(airlines, by = "carrier")


Para los próximos ejemplos, vamos a usar estas bases de datos de juguete:

x <- tribble(~key, ~val_x,
             1, "x1",
             2, "x2",
             3, "x3")

y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2",
             4, "y3")

x
y


### Aplicación 6: Inner join

# Inner join (del inglés unión interna) 
# sirve para unir observaciones que 
# compartan una misma variable clave (key).

x %>% inner_join(y, by = "key")


### Aplicación 7: Outer join

# Outer join (del inglés unión externa) 
# sirve para mantener las observaciones 
# o registros que aparecen en al menos 
# una de las bases de datos. Hay tres 
# tipos de outer joins: left_join 
# (mantiene todas las observaciones de x), 
# right_join (mantiene todas las observaciones de y),
# y full_join (mantiene todas las observaciones
# de x y de y). Estas funciones trabajan al
# añadir una observación virtual adicional 
# en cada tabla, llenándola con un caso vacío o NA.


left_join(x, y)

right_join(x, y)

full_join(x, y)