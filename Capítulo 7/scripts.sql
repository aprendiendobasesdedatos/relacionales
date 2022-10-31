-- Script 7.1
SELECT CONCAT(U.nombres, ' ', U.apellidos) AS nombreCompleto,
       CASE
           WHEN COUNT(calificación) > 8 
             THEN 'más de ocho canciones'
           WHEN COUNT(calificación) > 3 AND COUNT(calificación) <= 8
             THEN 'entre cuatro y ocho canciones'
           WHEN COUNT(calificación) >= 1 AND COUNT(calificación) <= 3
              THEN 'entre 1 y tres canciones'
           ELSE 'Ninguna canción'
       END AS clasificación
FROM Usuarios U LEFT JOIN Calificaciones C ON U.idUsuario = C.idUsuario
GROUP BY U.idUsuario, CONCAT(U.nombres, ' ', U.apellidos)
ORDER BY COUNT(calificación) DESC;

-- Script 7.2
SELECT CASE
           WHEN cantidadCalificaciones > 8
           THEN 'más de ocho canciones'
           WHEN cantidadCalificaciones BETWEEN 4 AND 8
           THEN 'entre cuatro y ocho canciones'
           WHEN cantidadCalificaciones BETWEEN 1 AND 3
           THEN 'entre 1 y tres canciones'
           ELSE 'Ninguna canción'
       END, 
       COUNT(idUsuario) AS cantidadUsuarios
FROM(SELECT U.idUsuario, 
            COUNT(calificación) cantidadCalificaciones
     FROM Usuarios U
          LEFT JOIN Calificaciones C ON U.idUsuario = C.idUsuario
     GROUP BY U.idUsuario) CalificacionesporUsuario
GROUP BY CASE
             WHEN cantidadCalificaciones > 8
             THEN 'más de ocho canciones'
             WHEN cantidadCalificaciones BETWEEN 4 AND 8
             THEN 'entre cuatro y ocho canciones'
             WHEN cantidadCalificaciones BETWEEN 1 AND 3
             THEN 'entre 1 y tres canciones'
             ELSE 'Ninguna canción'
         END;
		 
-- Script 7.3
SELECT C.título
FROM Reproducciones R
     INNER JOIN Canciones C ON R.idCanción = R.idCanción
ORDER BY R.fechaReproducción, 
         R.horaReproducción
		 
-- Script 7.4
SELECT C.título
FROM Reproducciones R
     INNER JOIN Canciones C ON R.idCanción = R.idCanción
ORDER BY R.fechaReproducción, 
         R.horaReproducción
LIMIT 5;

-- Script 7.5
SELECT idListaReproducción, 
       COUNT(idCanción) "Cantidad de canciones"
FROM CancionesLista
GROUP BY idListaReproducción
ORDER BY "Cantidad de canciones" DESC
LIMIT 1 OFFSET 10;

-- Script 7.6
SELECT idCanción,
COUNT(CASE EXTRACT (year FROM fechaReproducción) WHEN 2017 THEN idReproducción END) AS "2017",
COUNT(CASE EXTRACT (year FROM fechaReproducción) WHEN 2018 THEN idReproducción END) AS "2018",
COUNT(CASE EXTRACT (year FROM fechaReproducción) WHEN 2019 THEN idReproducción END) AS "2019",
COUNT(CASE EXTRACT (year FROM fechaReproducción) WHEN 2020 THEN idReproducción END) AS "2020",
COUNT(CASE EXTRACT (year FROM fechaReproducción) WHEN 2021 THEN idReproducción END) AS "2021"
FROM Reproducciones 
GROUP BY idCanción 
ORDER BY 1


-- Script 7.7
CREATE extension tablefunc;

-- Script 7.8
SELECT idCanción, EXTRACT (year FROM fechaReproducción), COUNT(idReproducción) AS Cantidad
FROM Reproducciones 
GROUP BY idCanción,  EXTRACT (year FROM fechaReproducción) ORDER BY 1,2

-- Script 7.9
SELECT DISTINCT EXTRACT (year FROM fechaReproducción) 
FROM Reproducciones ORDER BY 1;

-- Script 7.10
SELECT * FROM crosstab(
   -- Consulta centra
   'SELECT idCanción, EXTRACT (year FROM fechaReproducción), COUNT(idReproducción)::NUMERIC AS Cantidad
    FROM Reproducciones GROUP BY idCanción,  EXTRACT (year FROM fechaReproducción) ORDER BY 1,2',
   -- Consultas para generar las nuevas columnas
   'SELECT DISTINCT EXTRACT (year FROM fechaReproducción) FROM Reproducciones ORDER BY 1')
  AS ("idCanción" INTEGER,
      "2017" NUMERIC,
      "2018" NUMERIC,
      "2019" NUMERIC,
      "2020" NUMERIC,
      "2021" NUMERIC);







