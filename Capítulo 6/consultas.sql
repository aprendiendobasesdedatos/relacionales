-- Script 6.1
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento
FROM Usuarios

-- Script 6.2
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento
FROM Músicos

-- Script 6.3
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento
FROM Usuarios
UNION
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento
FROM Músicos

-- Script 6.4
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento, 
       'Usuario' AS tipoPersona
FROM Usuarios
UNION ALL
SELECT nombres, 
       apellidos, 
       sexo, 
       fechaNacimiento, 
       paísNacimiento, 
       'Músico' AS tipoPersona
FROM Músicos

-- Script 6.5
SELECT idMúsico
FROM Solistas
UNION ALL
SELECT idMúsico
FROM ParticipacionesEnGrupos

-- Script 6.6
SELECT CONCAT(M.nombres, ' ', M.apellidos) AS nombreCompleto, 
       M.sexo, 
       M.paísNacimiento
FROM Músicos AS M
WHERE idMúsico IN(SELECT idMúsico
                  FROM Solistas
                  UNION ALL
                  SELECT idMúsico
                  FROM ParticipacionesEnGrupos);

-- Script 6.7
SELECT C.idCanción, 
       título, 
       'Más reproducida' AS Criterio
FROM Reproducciones R
     INNER JOIN Canciones C ON R.idCanción = C.idCanción
GROUP BY C.idCanción
HAVING COUNT(idReproducción) = 
             (SELECT MAX(CantidadReproducciones)
              FROM
              (SELECT COUNT(idReproducción) CantidadReproducciones
               FROM Reproducciones
               GROUP BY idCanción) ReproduccionesPorCanción)
			   
-- Script 6.8
SELECT idCanción, 
       (SELECT título
        FROM Canciones C
        WHERE C.idCanción = Cal.idCanción), 
       'Mejor Valorada' AS Criterio
FROM Calificaciones Cal
GROUP BY idCanción
HAVING AVG(Calificación) = (SELECT MAX(CalificaciónPromedio)
                            FROM
                            (SELECT AVG(Calificación) CalificaciónPromedio
                             FROM Calificaciones
                             GROUP BY idCanción) CalificacionesPorCanción)

-- Script 6.9
SELECT C.idCanción, 
       título, 
       'Más reproducida' AS Criterio
FROM Reproducciones R
     INNER JOIN Canciones C ON R.idCanción = C.idCanción
GROUP BY C.idCanción
HAVING COUNT(idReproducción) = 
             (SELECT MAX(CantidadReproducciones)
              FROM
              (SELECT COUNT(idReproducción) CantidadReproducciones
               FROM Reproducciones
               GROUP BY idCanción) ReproduccionesPorCanción)
UNION
SELECT idCanción, 
       (SELECT título
        FROM Canciones C
        WHERE C.idCanción = Cal.idCanción), 
       'Mejor Valorada' AS Criterio
FROM Calificaciones Cal
GROUP BY idCanción
HAVING AVG(Calificación) = (SELECT MAX(CalificaciónPromedio)
                            FROM
                            (SELECT AVG(Calificación) CalificaciónPromedio
                             FROM Calificaciones
                             GROUP BY idCanción) CalificacionesPorCanción)
							 
-- Script 6.10
SELECT idMúsico
FROM Solistas
INTERSECT
SELECT idMúsicoCompositor
FROM Compositores
INTERSECT
SELECT idMúsico
FROM ParticipacionesEnGrupos;

-- Script 6.11
SELECT M.paísNacimiento, 
       COUNT(*) AS CantidadMúsicos
FROM Músicos AS M
WHERE idMúsico IN(SELECT idMúsico
                  FROM Solistas
                  INTERSECT
                  SELECT idMúsicoCompositor
                  FROM Compositores
                  INTERSECT
                  SELECT idMúsico
                  FROM ParticipacionesEnGrupos)
GROUP BY M.paísNacimiento;

-- Script 6.12
SELECT idMúsico
FROM Solistas
EXCEPT
SELECT idMúsicoCompositor
FROM Compositores;

-- Script 6.13
SELECT CONCAT(M.nombres, ' ', M.apellidos) AS nombreCompleto, 
       M.sexo, 
       M.paísNacimiento
FROM Músicos AS M
WHERE idMúsico IN(SELECT idMúsico
                  FROM Solistas 
                  EXCEPT
                  SELECT idMúsicoCompositor
                  FROM Compositores);
				  
-- Script 6.14
SELECT AVG(duración)
FROM Canciones
GROUP BY idGénero

-- Script 6.15
SELECT idGénero,
   AVG(duración) AS duraciónPromedioPorGénero
FROM Canciones
GROUP BY idGénero

-- Script 6.16
SELECT idCanción, 
       título, 
       Canciones.idGénero, 
       duración, 
       duraciónPromedioPorGénero
FROM Canciones
     INNER JOIN(SELECT idGénero, 
                       AVG(duración) AS duraciónPromedioPorGénero
                FROM canciones
                GROUP BY idgénero) AS DuracionesPromedioPorGénero
            ON Canciones.idGénero = DuracionesPromedioPorGénero.idGénero
ORDER BY idGénero

-- Script 6.17
SELECT idCanción, 
       título, 
       idGénero, 
       duración, 
       (SELECT AVG(duración)
        FROM Canciones AS C2
        WHERE C2.idGénero = C1.idGénero) AS duraciónPromedioPorGénero
FROM Canciones AS C1
ORDER BY idGénero

-- Script 6.18
SELECT idCanción,
     título,
     idGénero,
     duración,
     AVG(duración) OVER(PARTITION BY idGénero) AS duraciónPromedioPorGénero
FROM Canciones

-- Script 6.19
SELECT G.nombre, 
       C.título, 
       COUNT(idReproducción) AS CantidadReproducciones
FROM Canciones C
     INNER JOIN Géneros G ON C.idGénero = G.idGénero
     LEFT JOIN Reproducciones R ON R.idCanción = C.idCanción
GROUP BY G.nombre, 
         C.título
ORDER BY CantidadReproducciones DESC

-- Script 6.20
SELECT G.nombre, 
       C.título, 
       COUNT(idReproducción) AS CantidadReproducciones, 
       ROW_NUMBER() OVER(ORDER BY COUNT(idReproducción) DESC) fila, 
       RANK() OVER(ORDER BY COUNT(idReproducción) DESC) puesto, 
       DENSE_RANK() OVER(ORDER BY COUNT(idReproducción) DESC) puestoDenso
FROM Canciones C
     INNER JOIN Géneros G ON C.idGénero = G.idGénero
     LEFT JOIN Reproducciones R ON R.idCanción = C.idCanción
GROUP BY G.nombre, 
         C.título
ORDER BY CantidadReproducciones DESC

-- Script 6.21
SELECT 
 C.título, 
 COUNT(idReproducción) AS CantidadReproducciones, 
 DENSE_RANK() OVER(PARTITION BY G.idGénero ORDER BY COUNT(idReproducción) DESC)
FROM Canciones C
     INNER JOIN Géneros G ON C.idGénero = G.idGénero
     INNER JOIN Reproducciones R ON R.idCanción = C.idCanción
GROUP BY G.idGénero, 
         C.idCanción, 
         C.título
		 
-- Script 6.22
SELECT 
 R.idCanción, 
 COUNT(*) OVER() AS CRT,
 COUNT(*) OVER(PARTITION BY R.idCanción) AS CRC,
 100.0 * COUNT(*) OVER(PARTITION BY R.idCanción) / COUNT(*) OVER() AS porcentaje  
FROM Reproducciones R
ORDER BY idCanción

-- Script 6.23
SELECT DISTINCT
 R.idCanción, 
 COUNT(*) OVER() AS CRT,
 COUNT(*) OVER(PARTITION BY R.idCanción) AS CRC,
 100.0 * COUNT(*) OVER(PARTITION BY R.idCanción) / COUNT(*) OVER() AS porcentaje  
FROM Reproducciones R
ORDER BY idCanción





















