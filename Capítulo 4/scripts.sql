-- Script 4.1
SELECT idGénero
FROM Géneros
WHERE nombre = 'Salsa'

-- Script 4.2
SELECT título, 
       duración, 
       idioma
FROM Canciones
WHERE idGénero = 3

-- Script 4.3
SELECT título, 
       duración, 
       idioma
FROM Canciones
WHERE idGénero = (SELECT idGénero
                  FROM Géneros
                  WHERE nombre = 'Salsa')
				  

-- SCript 4.4
SELECT idIntérprete
FROM Intérpretes
WHERE nombre = 'Yuri Buenaventura'

-- Script 4.5
SELECT título, 
       duración, 
       idioma
FROM Canciones
WHERE idGénero = (SELECT idGénero
                  FROM Géneros
                  WHERE nombre = 'Salsa') AND 
      idIntérpretePrincipal = (SELECT idIntérprete
                               FROM Intérpretes
                               WHERE nombre = 'Yuri Buenaventura')
							   
-- Script 4.6
SELECT MAX(duración)
FROM Canciones

-- Script 4.7
SELECT MIN(duración)
FROM Canciones

-- Script 4.8
SELECT título, 
       duración
FROM Canciones
WHERE duración IN((SELECT MIN(duración)
                   FROM Canciones), 
                  (SELECT MAX(duración)
      FROM Canciones))
	  
-- Script 4.9
SELECT AVG(segundosreproducidos)
FROM reproducciones

-- Script 4.10
SELECT idcanción, 
       AVG(segundosreproducidos)
FROM reproducciones
WHERE DATE_PART('year', fechareproducción) = 2020
GROUP BY idcanción

-- Script 4.11
SELECT idcanción, 
       COUNT(*) AS cantidadReproducciones 
FROM reproducciones
WHERE DATE_PART('year', fechareproducción) = 2020
GROUP BY idcanción
HAVING AVG(segundosreproducidos) < (SELECT AVG(segundosreproducidos)
                                    FROM reproducciones)
									
-- Script 4.12
SELECT idIntérprete
FROM Intérpretes
WHERE tipointérprete = 'Solista'

-- Script 4.13
SELECT título, 
       duración
FROM Canciones
WHERE idIntérpretePrincipal IN (1, 3, 5, 7, 9)
ORDER BY título

--Script 4.14
SELECT título, 
       duración, 
       idIntérpretePrincipal 
FROM Canciones
WHERE idIntérpretePrincipal IN (SELECT idIntérprete
                                FROM Intérpretes
                                WHERE tipoIntérprete = 'Solista')
ORDER BY título

-- Script 4.15
SELECT idUsuario
FROM Usuarios
WHERE sexo = 'F' AND paísNacimiento = 'Colombia'

-- Script 4.16
SELECT idCanción
FROM Reproducciones
WHERE idUsuario IN (SELECT idUsuario
                    FROM Usuarios
                    WHERE sexo = 'F' AND 
                          paísNacimiento = 'Colombia')
						  
-- Script 4.17
SELECT título
FROM Canciones
WHERE idCanción IN (SELECT idCanción
                    FROM Reproducciones
                    WHERE idUsuario IN (SELECT idUsuario
                                        FROM Usuarios
                                        WHERE sexo = 'F' AND 
                                              paísNacimiento = 'Colombia'))
											  
-- Script 4.18
SELECT título
FROM Canciones
WHERE idCanción IN (SELECT idCanción
                    FROM Reproducciones
                    WHERE idUsuario IN (SELECT idUsuario
                                        FROM Usuarios
                                        WHERE sexo = 'F' AND 
                                              paísNacimiento = 'Colombia'))
  AND idGénero = (SELECT idGénero
                  FROM Géneros
                  WHERE nombre = 'Salsa')
				  
-- Script 4.19
SELECT título
FROM Canciones
WHERE idCanción IN (SELECT idCanción
                    FROM CancionesLista
                    WHERE idListaReproducción IN
                      (SELECT idListaReproducción
                       FROM ListasReproducción
                       WHERE idUsuario IN
                         (SELECT idUsuario
                           FROM Usuarios
                           WHERE email = 'alex@gmail.com'))) AND 
      idCanción NOT IN (SELECT idCanción
                        FROM Reproducciones
                        WHERE idUsuario IN
                          (SELECT idUsuario
                           FROM Usuarios
                           WHERE email = 'alex@gmail.com'))
						   
-- Script 4.20
SELECT idCanción, COUNT(*)
FROM Reproducciones
WHERE idCanción IN (SELECT idCanción
                    FROM Canciones
                    WHERE idGénero = (SELECT idGénero
                                      FROM Géneros
                                      WHERE nombre = 'Salsa'))
GROUP BY idCanción


-- Script 4.21
SELECT idCanción 
FROM Reproducciones
WHERE idCanción IN (SELECT idCanción
                    FROM Canciones
                    WHERE idGénero = (SELECT idGénero
                                      FROM Géneros
                                      WHERE nombre = 'Salsa'))
GROUP BY idCanción
HAVING COUNT(*) > ANY (SELECT COUNT(*)
                       FROM Reproducciones
                       WHERE idCanción IN (SELECT idCanción
                                           FROM Canciones
                                           WHERE idGénero = 
                                             (SELECT idGénero
                                              FROM Géneros
                                              WHERE nombre = 'Pop'))
                       GROUP BY idCanción)
					   
-- Script 4.22				   
SELECT idListaReproducción, 
       COUNT(idCanción) AS cantidadCanciones
FROM CancionesLista
GROUP BY idListaReproducción

-- Script 4.23
SELECT MAX(cantidadCanciones)
FROM (SELECT idListaReproducción, 
            COUNT(idCanción) AS cantidadCanciones
     FROM CancionesLista
     GROUP BY idListaReproducción) AS CancionesPorlista
	 
-- Script 4.24
SELECT idListaReproducción, 
       COUNT(idCanción) AS cantidadCanciones
FROM Cancioneslista
GROUP BY idListaReproducción
HAVING COUNT(idCanción) > 10

-- Script 4.25
SELECT COUNT(*) AS cantidadListas
FROM (SELECT idListaReproducción, 
             COUNT(idCanción) AS cantidadCanciones
      FROM Cancioneslista
      GROUP BY idListaReproducción
      HAVING COUNT(idCanción) > 10) AS ListasConCantidadCanciones
	  
-- Script 4.26
SELECT COUNT(*) AS cantidadListas
FROM (SELECT idListaReproducción, 
             COUNT(idCanción) AS cantidadCanciones
      FROM Cancioneslista
      GROUP BY idListaReproducción) AS ListasConCantidadCanciones
WHERE cantidadCanciones > 10


-- Script 4.27
SELECT idListaReproducción
FROM Cancioneslista
GROUP BY idListaReproducción
HAVING COUNT(idCanción) = (SELECT MAX(cantidadCanciones)
                           FROM (SELECT idListaReproducción, 
                                      COUNT(idCanción) AS cantidadCanciones
                                  FROM CancionesLista
                                  GROUP BY idListaReproducción
                                 ) AS CancionesPorlista)
								 

-- Script 4.28
SELECT título, 
       fechaCreación
FROM ListasReproducción
WHERE idListaReproducción IN (SELECT idListaReproducción
                              FROM Cancioneslista
                              GROUP BY idListaReproducción
                              HAVING COUNT(idCanción) = 
                                (SELECT MAX(cantidadCanciones)
                                 FROM (SELECT idListaReproducción, 
                                      COUNT(idCanción) AS cantidadCanciones
                                      FROM CancionesLista
                                      GROUP BY idListaReproducción
                                 ) AS CancionesPorlista))
								 
								 
-- Script 4.29
SELECT idGénero, 
       título, 
       duración
FROM Canciones
WHERE duración = (SELECT MAX(duración)
                  FROM Canciones
                  WHERE idGénero = 4)
				 
-- Script 4.30
SELECT idGénero, 
       título, 
       duración
FROM Canciones AS TablaPrincipal
WHERE duración = (SELECT MAX(duración)
                  FROM Canciones AS TablaSubconsulta
                  WHERE TablaSubconsulta.idGénero = TablaPrincipal.idGénero)

-- Script 4.31
SELECT idListaReproducción, 
       idCanción
FROM CancionesLista
WHERE idCanción IN (SELECT idCanción
                    FROM Canciones
                    WHERE idIntérpretePrincipal IN (SELECT idIntérprete
                                                    FROM Intérpretes
                                                    WHERE 
                                                    nombre='Carlos Vives'))
-- Script 4.32
SELECT título
FROM Canciones
WHERE idCanción = 5 

-- Script 4.33
SELECT título
FROM ListasReproducción
WHERE idListaReproducción = 3 

-- Script 4.34
SELECT
   (SELECT título
    FROM ListasReproducción
    WHERE ListasReproducción.idListaReproducción =      
          Cancioneslista.idlistareproducción) AS títuloLista, 
    (SELECT título
     FROM Canciones
     WHERE Canciones.idCanción = CancionesLista.idCanción) AS títuloCanción
FROM CancionesLista
WHERE idCanción IN (SELECT idCanción
                    FROM Canciones
                    WHERE idIntérpretePrincipal IN (SELECT idIntérprete
                                                    FROM Intérpretes
                                                    WHERE 
                                                    nombre='Carlos Vives'))















						  


						  
















