-- Script 3.1
SELECT CONCAT(nombres, ' ', apellidos) AS nombreCompleto, 
       EXTRACT(YEAR FROM fecharegistro) AS añoRegistro
FROM Usuarios
ORDER BY añoregistro DESC, 
         nombreCompleto
		 
-- Script 3.2		 
SELECT CONCAT(nombres, ' ', apellidos) AS nombreCompleto, 
YEAR(fechaRegistro) AS añoRegistro
FROM Usuarios
ORDER BY añoregistro DESC, 
         nombreCompleto
		 
-- Script 3.3	 
SELECT CONCAT(nombres, ' ', apellidos) AS nombreCompleto, 
       DATE_PART('year', fechaRegistro) AS añoRegistro
FROM Usuarios
ORDER BY añoregistro DESC, 
         nombreCompleto
		 
-- Script 3.4
SELECT email, 
       sexo, 
       AGE(fechaNacimiento) AS edadActual, 
       AGE(fechaRegistro, fechaNacimiento) AS edadAlRegistrarse, 
       AGE(fechaRegistro) AS tiempoComoUsuario, 
       paísResidencia
FROM Usuarios

-- Script 3.5
SELECT CONCAT(nombres, ' ', apellidos) AS nombreCompleto, 
       email, 
       SUBSTRING(email,
                 POSITION('@' in email) + 1,
                 CHAR_LENGTH(email) - POSITION('@' in email)
                 ) AS servicioEmail
FROM Usuarios
WHERE EXTRACT (YEAR FROM AGE(fechaNacimiento)) BETWEEN 20 AND 39
ORDER BY servicioEmail, email

-- Script 3.6
SELECT idCanción, 
       título, 
       idGénero
FROM Canciones
WHERE idGénero = 4

-- Script 3.7
SELECT COUNT(*) AS cantidadCancionesGénero4
FROM Canciones
WHERE idGénero = 4

-- Script 3.8
SELECT título, idÁlbumoriginal
FROM Canciones
WHERE idgénero IN (3,6)

-- Script 3.9
SELECT COUNT(*) AS cantidadÁlbumes
FROM Canciones
WHERE idgénero IN (3, 6)


-- Script 3.10
SELECT COUNT(idÁlbumoriginal) AS cantidadÁlbumes
FROM Canciones
WHERE idgénero IN (3, 6)

-- Script 3.11
SELECT COUNT(DISTINCT idÁlbumoriginal) AS cantidadÁlbumes
FROM Canciones
WHERE idgénero IN (3, 6)

-- Script 3.12
SELECT SUM(duración) AS duraciónTotal
FROM Canciones
WHERE idÁlbumOriginal = 15

-- Script 3.13
SELECT MIN(fechaLanzamiento) AS fechaLancamientoAlbumMásAntiguo
FROM Álbumes
WHERE sellodiscográfico = 'Codiscos'

-- Script  3.14
SELECT MAX(añoLanzamiento) AS fechaInicioCarreraMásReciente
FROM Intérpretes
WHERE idGéneroPrincipal = 4

--Script 3.15
SELECT AVG(calificación) AS calificaciónPromedioCanción5Año2020
FROM Calificaciones
WHERE idCanción = 5 AND 
      (fechaCalificación BETWEEN '01/01/2020' AND '31/12/2020')
	  
-- Script 3.16
SELECT AVG(EXTRACT(YEAR FROM AGE(fechaNacimiento))) AS Promedio
FROM Usuarios
WHERE paísNacimiento = 'Colombia'

-- Script 3.17
SELECT COUNT(*) AS cantidadDeSolistas
FROM Intérpretes
WHERE tipointérprete = 'Solista'


-- Script 3.18
SELECT tipoIntérprete, COUNT(*) AS cantidad
FROM Intérpretes
GROUP BY tipoIntérprete


-- Script 3.19
SELECT idÁlbumoriginal AS Álbum, 
       SUM(duración) AS duraciónTotal
FROM Canciones
GROUP BY idÁlbumoriginal
ORDER BY duraciónTotal DESC

-- Script 3.20
SELECT idListaReproducción AS Lista, 
       COUNT(idCanción) AS "Cantidad de canciones"
FROM CancionesLista
GROUP BY idListaReproducción
ORDER BY "Cantidad de canciones" DESC

-- Script 3.21
SELECT idCanción AS canción, 
       AVG(calificación) AS "calificación promedio"
FROM Calificaciones
WHERE idCanción BETWEEN 1 AND 10
GROUP BY idCanción
ORDER BY "calificación promedio" DESC

-- Script 3.22
SELECT idCanción AS Canción, 
       EXTRACT(MONTH FROM fechaReproducción) AS MES, 
       COUNT(idReproducción) AS Reproducciones
FROM Reproducciones
WHERE fechaReproducción BETWEEN '01/11/2020' AND '31/12/2020'
GROUP BY idCanción, 
         EXTRACT(MONTH FROM fechaReproducción)
ORDER BY Reproducciones DESC


-- Script 3.23
SELECT idListaReproducción AS Lista, 
       COUNT(idCanción) AS "Cantidad de canciones"
FROM CancionesLista
GROUP BY idListaReproducción
HAVING COUNT(idCanción) > 10
ORDER BY "Cantidad de canciones" DESC

-- Script 3.24
SELECT idcanción AS Canción, 
       COUNT(*) AS "Cantidad comentarios positivos"
FROM Calificaciones
WHERE(LOWER(comentario) LIKE '%buena%')
     OR (LOWER(comentario) LIKE '%excelente%')
GROUP BY idcanción
HAVING COUNT(*) >= 5

-- Script 3.25
SELECT idGénero AS Género, 
       idioma, 
       AVG(duración) AS "Duración promedio"
FROM Canciones
WHERE esInstrumental = '0'
GROUP BY idGénero, 
         idioma
HAVING idGénero IN(1, 3)

-- Script 3.26
SELECT idGénero AS Género, 
       idioma, 
       AVG(duración) AS "Duración promedio"
FROM Canciones
WHERE esInstrumental = '0'
      AND idGénero IN (1, 3)
GROUP BY idGénero, 
         idioma
























