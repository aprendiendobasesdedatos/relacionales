-- Script 5.1
SELECT Canciones.título, 
       Géneros.nombre AS género
FROM Canciones, 
     Géneros
WHERE Géneros.idGénero = Canciones.idGénero
ORDER BY Canciones.título

-- Script 5.2
SELECT título, 
       nombre AS género
FROM Canciones
     INNER JOIN Géneros ON Géneros.idGénero = Canciones.idGénero
ORDER BY Canciones.título

-- Script 5.3
SELECT título, 
       (SELECT nombre
        FROM Géneros
        WHERE Géneros.idGénero = Canciones.idGénero) AS género
FROM Canciones
ORDER BY título

-- Script 5.4
SELECT Canciones.título, 
       Calificaciones.calificación
FROM Canciones
     INNER JOIN Calificaciones
           ON Canciones.idCanción = Calificaciones.idCanción

-- Script 5.5
SELECT Usuarios.nombres, 
       Usuarios.apellidos,
       Canciones.título,  
       Calificaciones.calificación
FROM Canciones
     INNER JOIN Calificaciones 
        ON Canciones.idCanción = Calificaciones.idCanción
     INNER JOIN Usuarios 
        ON Usuarios.idUsuario = Calificaciones.idUsuario

-- Script 5.6
SELECT CONCAT(Usuarios.nombres, ' ', Usuarios.apellidos) AS nombreCompleto,
       Canciones.título, 
       Calificaciones.calificación
FROM Canciones
     INNER JOIN Calificaciones 
        ON Canciones.idCanción = Calificaciones.idCanción
     INNER JOIN Usuarios 
        ON Usuarios.idUsuario = Calificaciones.idUsuario
		
-- Script 5.7
SELECT título, 
       duración, 
       idioma
FROM Canciones
WHERE idGénero = (SELECT idGénero
                  FROM Géneros
                  WHERE nombre = 'Salsa')
				  

-- Script 5.8
SELECT título, 
       duración, 
       idioma
FROM Canciones
     INNER JOIN Géneros 
        ON Géneros.idGénero = Canciones.idGénero
WHERE Géneros.nombre = 'Salsa'

-- Script 5.9
SELECT Usuarios.paísResidencia, 
       COUNT(DISTINCT Usuarios.idUsuario) AS cantidadUsuarios, 
       SUM(Pagos.montoPagado) AS dineroRecaudado
FROM Usuarios
     INNER JOIN Pagos 
        ON Pagos.idUsuario = Usuarios.idUsuario
GROUP BY Usuarios.paísResidencia
ORDER BY dineroRecaudado DESC

-- Script 5.10
SELECT *
FROM Pagos
     INNER JOIN Planes ON Pagos.idPlan = Planes.idPlan AND 
                          Pagos.fechaPago > Planes.fechaFinVigencia
						  
-- Script 5.11
SELECT *
FROM Pagos
     INNER JOIN Planes ON Pagos.idPlan = Planes.idPlan AND 
                          (Pagos.fechaPago < Planes.fechaInicioVigencia OR 
                           Pagos.fechaPago > Planes.fechaFinvigencia)
						   
-- Script 5.12
SELECT idIntérpretePrincipal, 
       COUNT(*) AS cantidadReproducciones
FROM Canciones
     JOIN Reproducciones ON Canciones.idCanción = Reproducciones.idCanción
GROUP BY idIntérpretePrincipal

-- Script 5.13
SELECT idIntérpretePrincipal, 
       AVG(calificación) AS calificaciónPromedio
FROM Canciones
     JOIN Calificaciones ON Canciones.idCanción = Calificaciones.idCanción
GROUP BY idIntérpretePrincipal

-- Script 5.14
SELECT nombre, 
       cantidadReproducciones, 
       calificaciónPromedio
FROM Intérpretes
INNER JOIN(SELECT idIntérpretePrincipal, 
                       AVG(calificación) AS calificaciónPromedio
                FROM Canciones
                     JOIN Calificaciones 
			 ON Canciones.idCanción = Calificaciones.idCanción
                GROUP BY idIntérpretePrincipal) AS CalificacionesPromedio 
 ON Intérpretes.idIntérprete = CalificacionesPromedio.idIntérpretePrincipal
 INNER JOIN(SELECT idIntérpretePrincipal, 
                       COUNT(*) AS cantidadReproducciones
                FROM Canciones
                     JOIN Reproducciones 
			 ON Canciones.idCanción = Reproducciones.idCanción
                GROUP BY idIntérpretePrincipal) AS CantidadesReproducciones 
ON Intérpretes.idIntérprete = CantidadesReproducciones.idIntérpretePrincipal

-- Script 5.15
SELECT U.idUsuario, 
       COUNT(C.calificación) AS cantidadCalificaciones
FROM Calificaciones AS C
     INNER JOIN Usuarios AS U
     ON C.idUSuario = U.idUsuario
GROUP BY U.idUsuario
ORDER BY cantidadCalificaciones DESC

-- Script 5.16
SELECT U.idUsuario, 
       COUNT(C.calificación) AS cantidadCalificaciones
FROM Usuarios AS U
     LEFT JOIN Calificaciones AS C
     ON C.idUSuario = U.idUsuario
GROUP BY U.idUsuario
ORDER BY cantidadCalificaciones DESC

-- Script 5.17
SELECT U.idUsuario, 
       COUNT(C.calificación) AS cantidadCalificaciones
FROM Calificaciones AS C
     RIGHT OUTER JOIN Usuarios AS U
     ON C.idUSuario = U.idUsuario
GROUP BY U.idUsuario
ORDER BY cantidadCalificaciones DESC

-- Script 5.18
SELECT C.idCanción, 
       C.título, 
       R.idReproducción
FROM Canciones AS C
     INNER JOIN Reproducciones AS R
     ON C.idCanción = R.idCanción
	 
-- Script 5.19
SELECT DISTINCT 
       C.idCanción, 
       C.título
FROM Canciones AS C
     INNER JOIN Reproducciones AS R
     ON C.idCanción = R.idCanción
     LEFT JOIN CancionesLista AS CL
     ON R.idCanción = CL.idCanción
WHERE CL.idListaReproducción IS NULL

-- Script 5.20
SELECT A.título, 
       C.título
FROM Álbumes AS A
     FULL OUTER JOIN Canciones AS C
     ON A.idalbum = C.idÁlbumoriginal
	 
-- Script 5.21
SELECT *
FROM ListasReproducción, Canciones;

-- Script 5.22
SELECT *
FROM ListasReproducción CROSS JOIN Canciones;

-- Script 5.23
SELECT LR.título, 
       C.título
FROM ListasReproducción AS LR
     CROSS JOIN Canciones AS C
WHERE C.idcanción NOT IN(SELECT idcanción
                         FROM CancionesLista AS CL
                         WHERE CL.idListaReproducción = LR.idListaReproducción)
      AND LR.idListaReproducción = 2
ORDER BY LR.idlistareproducción



















