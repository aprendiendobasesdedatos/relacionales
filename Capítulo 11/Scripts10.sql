-- Script 11.1
CREATE TABLE Géneros
(idGénero    INT PRIMARY KEY, 
 nombre      VARCHAR(100) NOT NULL, 
 descripción VARCHAR(500) NULL
);

-- Script 11.2
CREATE TABLE Intérpretes
(idIntérprete      INT PRIMARY KEY, 
 nombre            VARCHAR(200) NOT NULL, 
 añoLanzamiento    INT NOT NULL, 
 añoRetiro         INT, 
 tipoIntérprete    VARCHAR(10) NOT NULL, 
 idGénero INT NOT NULL
);

-- Script 11.3
DROP TABLE Intérpretes;

-- Script 11.4
CREATE TABLE Intérpretes
(idIntérprete      INT PRIMARY KEY, 
 nombre            VARCHAR(200) NOT NULL, 
 añoLanzamiento    VARCHAR(200) NOT NULL, 
 añoRetiro         INT, 
 tipoIntérprete    VARCHAR(10) NOT NULL, 
 idGénero INT NOT NULL, 
 FOREIGN KEY(idGénero) REFERENCES Géneros(idGénero)
);

-- Script 11.5
ALTER TABLE Intérpretes 
ADD FOREIGN KEY (idGénero) REFERENCES Géneros(idGénero);

-- Script 11.6
CREATE TABLE Álbumes (
  idAlbum INT PRIMARY KEY, 
  título VARCHAR(100) NOT NULL, 
  selloDiscográfico VARCHAR(100) NOT NULL, 
  fechaLanzamiento DATE NOT NULL
);

-- Script 11.7
CREATE TABLE Canciones (
  idCanción INT NOT NULL PRIMARY KEY, 
  título VARCHAR(100) NOT NULL, 
  duración TIME(0) NOT NULL, 
  tempoBPM INT, 
  idioma VARCHAR(30) NOT NULL, 
  esInstrumental BIT NOT NULL DEFAULT '0', 
  fechaLanzamiento DATE NOT NULL, 
  idÁlbum INT NULL,  
  idIntérprete INT NOT NULL,
  idGénero INT NOT NULL,  
  FOREIGN KEY (idÁlbum) REFERENCES Álbumes(idAlbum), 
  FOREIGN KEY (idGénero) REFERENCES Géneros(idGénero), 
  FOREIGN KEY (idIntérprete) REFERENCES Intérpretes(idIntérprete)
);

-- Script 11.8
CREATE TABLE Usuarios (
  idUsuario INT NOT NULL PRIMARY KEY, 
  email VARCHAR(254) UNIQUE NOT NULL, 
  contraseña VARCHAR(128) NOT NULL, 
  nombres VARCHAR(100) NOT NULL, 
  apellidos VARCHAR(100) NOT NULL, 
  sexo VARCHAR(30) CHECK(sexo IN ('M', 'F')) NOT NULL, 
  fechaNacimiento DATE NOT NULL,
  paísNacimiento VARCHAR(100) NOT NULL,
  paísResidencia VARCHAR(100) NOT NULL, 
  idioma VARCHAR(30) NOT NULL, 
  fechaRegistro DATE NOT NULL,
  CONSTRAINT fechas_validas CHECK(fechaNacimiento<fechaRegistro)
);

-- Script 11.9
ALTER TABLE Usuarios
ADD CONSTRAINT contraseña_validad CHECK (MD5(email) <> contraseña);

-- Script 11.10
ALTER TABLE Usuarios
DROP CONSTRAINT fechas_validas;

-- Script 11.11
CREATE TABLE Valoraciones (
  idUsuario INT NOT NULL, 
  idCanción INT NOT NULL, 
  valoración INT NOT NULL, 
  comentario VARCHAR(280) NOT NULL, 
  fechaCalificación DATE NOT NULL, 
  horaCalificación TIME(0) NOT NULL, 
  PRIMARY KEY (idUsuario, idCanción), 
  FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario), 
  FOREIGN KEY (idCanción) REFERENCES Canciones(idCanción)
);

-- Script 11.12
ALTER TABLE Valoraciones 
RENAME TO Calificaciones;

-- Script 11.13
ALTER TABLE Calificaciones
RENAME COLUMN valoración TO calificación;

-- Script 11.14
ALTER TABLE Calificaciones
ALTER COLUMN comentario DROP NOT NULL;

-- Script 11.15
INSERT INTO Géneros (idGénero, nombre, descripción)
VALUES(14, 'Rap', 'Este género surgió como un movimiento social...');

-- Script 11.16
INSERT INTO Géneros (descripción, nombre, idGénero)
VALUES('Este género surgió como un movimiento social de expresión de clases oprimidas...', 'Rap', 14);

-- Script 11.17
INSERT INTO Géneros
VALUES(11, 'Rap', NULL);

-- Script 11.18
CREATE TABLE Géneros
(idGénero    SERIAL PRIMARY KEY, 
 nombre      VARCHAR(100) NOT NULL, 
 descripción VARCHAR(500) NULL
);

-- Script 11.19
INSERT INTO Géneros (nombre)
VALUES('Rap');

-- Script 11.20
INSERT INTO Canciones
VALUES(21,'Fidelina','00:04:23', NULL, 'Español','0','25/07/1995', 1, 4, 1 )


-- Script 11.21
INSERT INTO Canciones
VALUES(21,'Fidelina', '00:04:23', NULL, 'Español', '0', '25/07/1995', (SELECT idalbum
FROM Álbumes
WHERE título = 'La tierra del olvido'), (SELECT idGénero
FROM Géneros
WHERE nombre = 'Vallenato'), (SELECT idIntérprete
FROM Intérpretes
WHERE nombre = 'Carlos Vives'))

-- Script 11.22
INSERT INTO Reproducciones
VALUES(498, (SELECT idUsuario
FROM Usuarios
WHERE email = 'panteismo@gmail.com'), (SELECT idCanción
FROM Canciones
WHERE título = 'Fidelina'), CAST(NOW() AS DATE), CAST(NOW() AS TIME), 189)

-- Script 11.23
INSERT INTO Reproducciones
VALUES(498, (SELECT idUsuario
FROM Usuarios
WHERE email = 'panteismo@gmail.com'), (SELECT idCanción
FROM Canciones
WHERE título = 'Fidelina'), CAST (NOW() AS DATE), CAST (NOW() AS TIME), 189),
(499, (SELECT idUsuario
FROM Usuarios
WHERE email = 'piedad.bonnett@gmail.com'), (SELECT idCanción
FROM Canciones
WHERE título = 'Fidelina'), CAST (NOW() AS DATE), CAST (NOW() AS TIME), 50)

-- Script 11.24
SELECT C.idCanción, 
       C.título AS títuloCanción, 
       A.idAlbum, 
       A.título, 
       I.idIntérprete, 
       I.nombre, 
       I.tipoIntérprete, 
FROM Canciones C
     INNER JOIN Álbumes A ON C.idÁlbumOriginal = A.idAlbum
     INNER JOIN Intérpretes I ON I.idIntérprete = C.idIntérpretePrincipal
WHERE C.idioma = 'español';

-- Script 11.25
SELECT C.idCanción, 
       C.título AS títuloCanción, 
       A.idAlbum, 
       A.título, 
       I.idIntérprete, 
       I.nombre, 
       I.tipoIntérprete,
INTO  CancionEnEspañol
FROM Canciones C
     INNER JOIN Álbumes A ON C.idÁlbumOriginal = A.idAlbum
     INNER JOIN Intérpretes I ON I.idIntérprete = C.idIntérpretePrincipal
WHERE C.idioma = 'español';

-- Script 11.26
INSERT INTO InfoCancionesEnEspañol
SELECT C.idCanción, 
       C.título AS títuloCanción, 
       A.idAlbum, 
       A.título, 
       I.idIntérprete, 
       I.nombre, 
       I.tipoIntérprete, 
       CAST(NOW() AS DATE) AS fechaCreación, 
       CAST(NOW() AS TIME) AS HoraCreación
FROM Canciones C
     INNER JOIN Álbumes A ON C.idÁlbumOriginal = A.idAlbum
     INNER JOIN Intérpretes I ON I.idIntérprete = C.idIntérpretePrincipal
WHERE C.idioma = 'español';

-- Script 11.27
DELETE FROM Reproducciones
WHERE idUsuario = 6

-- Script 11.28
DELETE FROM Reproducciones
WHERE idUsuario = (SELECT idUsuario
			       FROM Usuarios
                   WHERE nombres='Marie' and apellidos='Curie')

-- Script 11.29
DELETE FROM Canciones
WHERE título LIKE '%a' AND idGenero = (SELECT idGénero FROM Géneros WHERE nombre='Salsa');

-- Script 11.30
DELETE FROM Canciones CE
WHERE duración = (SELECT MAX(duración) FROM Canciones CI WHERE CI.idGénero = CE.idGénero )

-- Script 11.31
DELETE FROM Reproducciones R
WHERE idCanción = 
(
SELECT idCanción 
FROM Canciones 
WHERE duración  = (
SELECT MAX(duración)
FROM Canciones CI WHERE idGénero = (SELECT idGénero FROM Canciones WHERE idCanción = R.idCanción)))

-- Script 11.32
DELETE FROM Calificaciones C
WHERE idCanción = 
(
SELECT idCanción 
FROM Canciones 
WHERE duración  = (
SELECT MAX(duración)
FROM Canciones CI WHERE idGénero = (SELECT idGénero FROM Canciones WHERE idCanción = C.idCanción)))

-- Script 11.33
DELETE FROM Compositores C
WHERE idCanción = 
(
SELECT idCanción 
FROM Canciones 
WHERE duración  = (
SELECT MAX(duración)
FROM Canciones CI WHERE idGénero = (SELECT idGénero FROM Canciones WHERE idCanción = C.idCanción)))

-- Script 11.34
DELETE FROM CancionesLista C
WHERE idCanción = 
(
SELECT idCanción 
FROM Canciones 
WHERE duración  = (
SELECT MAX(duración)
FROM Canciones CI WHERE idGénero = (SELECT idGénero FROM Canciones WHERE idCanción = C.idCanción)))

-- Script 11.35
TRUNCATE TABLE Canciones;

-- Script 11.36
TRUNCATE TABLE Calificaciones;
TRUNCATE TABLE Reproducciones;
TRUNCATE TABLE CancionesLista;
TRUNCATE TABLE Compositores;

-- Script 11.37
TRUNCATE TABLE Canciones CASCADE;

-- Script 11.38
UPDATE Canciones
SET esInstrumental = '1';

-- Script 11.39
UPDATE Canciones
SET esInstrumental = '1'
WHERE idCanción = 2;

-- Script 11.40
UPDATE Canciones
SET 
    esInstrumental='1'
WHERE idGénero = (SELECT idGénero
                  FROM Géneros
                  WHERE nombre = 'Vallenato');

-- Script 11.41
UPDATE Pagos
SET idPlan = (SELECT idPlan FROM Planes WHERE nombre = 'Familiar'),
    fechaPago = CAST(NOW() AS DATE)
WHERE idPago = 155

-- Script 11.42
UPDATE Calificaciones Cal
SET Calificación = 5
FROM Canciones C INNER JOIN Géneros G USING(idGénero)
WHERE C.idCanción = Cal.idCanción and EXTRACT (YEAR FROM Cal.fechaCalificación) = 2020 AND G.nombre = 'Vallenato'

-- Script 11.43
SELECT idCanción, COUNT(Reproducciones),
DENSE_RANK() OVER(ORDER BY COUNT(Reproducciones) DESC ) ranking
FROM reproducciones 
WHERE idUsuario = 1
GROUP BY idCanción

-- Script 11.44
UPDATE Calificaciones Ca
SET Comentario = 'Me gusta esta canción'
WHERE  
(SELECT ranking FROM (SELECT idCanción, COUNT(Reproducciones),
DENSE_RANK() OVER(ORDER BY COUNT(Reproducciones) DESC ) ranking
FROM reproducciones 
WHERE idUsuario = Ca.idUsuario
GROUP BY idCanción) RankingCanciones
WHERE idCanción = Ca.idCanción) BETWEEN 1 AND 2

-- Script 11.45
EXPLAIN
(FORMAT JSON, ANALYZE)
SELECT *
FROM Canciones JOIN Reproducciones USING(idCanción)
INNER JOIN Usuarios USING(idUsuario)
ORDER BY fechaReproducción

-- Script 11.46
CREATE INDEX idx_reproducción_date 
ON Reproducciones( fechaReproducción );

-- Script 11.47
CREATE INDEX idx_reproducción_date 
ON Reproducciones( fechaReproducción )
WHERE EXTRACT(YEAR FROM fechaReproducción) >= 2019

-- Script 11.48
CREATE INDEX idx_reproducción_usuario_date 
ON Reproducciones( idUsuario, fechaReproducción );

-- Script 11.49
DROP INDEX idx_reproducción_usuario_date;





















