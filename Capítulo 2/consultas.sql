-- script 2.1
SELECT identificador, 
       nombre, 
       "año de lanzamiento", 
       "año de retiro", 
       tipo, 
       "género principal"
FROM Artistas

-- script 2.2
select	identiFICADOR, nombre, 
       "año de lanzamiento", "año de retiro", 
tipo, "género principal"
from	ARTISTAS

-- script 2.3
SELECT	* FROM	Artistas

-- script 2.4
SELECT identificador, 
       nombre, 
       tipo, 
       "género principal", 
       "año de lanzamiento", 
       "año de retiro"
FROM Artistas

-- script 2.5
SELECT título, 
       "fecha de lanzamiento", 
       "sello discográfico"
FROM Álbumes

-- script 2.6
SELECT título AS álbum, 
       "fecha de lanzamiento" AS lanzamiento, 
       "sello discográfico" disquera
FROM Álbumes

-- script 2.7
SELECT tipo
FROM Artistas

-- script 2.8
SELECT DISTINCT 
       tipo
FROM Artistas

-- script 2.9
SELECT DISTINCT 
       género, 
       idioma
FROM Canciones

-- script 2.10
SELECT título AS álbum, 
       "fecha de lanzamiento" AS lanzamiento, 
       "sello discográfico" disquera
FROM Álbumes
ORDER BY álbum ASC

-- script 2.11
SELECT título álbum, 
       "fecha de lanzamiento" lanzamiento, 
       "sello discográfico" disquera
FROM Álbumes
ORDER BY título

-- script 2.12
SELECT nombre, 
       tipo, 
       "año de lanzamiento", 
       2021 - "año de lanzamiento" AS "años de actividad al 2021"
FROM Artistas
ORDER BY tipo, 
         "años de actividad al 2021" DESC
		 

-- script 2.13
SELECT título, 
       género, 
       duración
FROM Canciones
WHERE duración >= '00:04:00' AND 
      duración <= '00:05:00'
	  
-- script 2.14	  
SELECT título, 
       género, 
       duración
FROM Canciones
WHERE duración BETWEEN '00:04:00' AND '00:04:51'

-- script 2.15
SELECT nombre, 
       "año de lanzamiento"
FROM Artistas
WHERE tipo = 'Solista' AND 
      (2021 - "año de lanzamiento" >= 10) AND 
      (2021 - "año de lanzamiento" <= 20)
	  
-- script 2.16
SELECT nombre, 
       "año de lanzamiento"
FROM Artistas
WHERE tipo = 'Solista' AND 
      2021 - "año de lanzamiento" BETWEEN 10 AND 20
	  
-- script 2.17
SELECT nombre, 
       tipo
FROM Artistas
WHERE (2021 - "año de lanzamiento") > 40 AND 
     ("género principal" = 1 OR 
      "género principal" = 3)
	  
-- script 2.18	  
SELECT título, 
       duración
FROM Canciones
WHERE género = 1 OR 
      género = 2 OR 
      género = 3
	  
-- script 2.19
SELECT título, 
       duración
FROM Canciones
WHERE género IN (1, 2, 3)

-- script 2.20
SELECT título, 
       duración
FROM Canciones
WHERE idioma = 'español' AND 
      género IN (1, 2, 3) AND 
      duración BETWEEN '00:03:00' AND '00:04:00'
ORDER BY duración DESC

-- script 2.21
SELECT título,
    "sello discográfico"
FROM Álbumes
WHERE título LIKE 'E%'

-- script 2.22
SELECT título, 
       "fecha de lanzamiento", 
       "sello discográfico"
FROM Álbumes
WHERE "fecha de lanzamiento" IS NULL

-- script 2.23
SELECT título, 
       "fecha de lanzamiento", 
       "sello discográfico"
FROM Álbumes
WHERE "fecha de lanzamiento" <= '31/12/2000'



















