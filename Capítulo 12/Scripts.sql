-- Script 12.1
SELECT IR.nombre, 
       IR.CantidadReproducciones, 
       IC.Calificación
FROM(SELECT Intérpretes.idIntérprete, 
            Intérpretes.nombre, 
            COUNT(Reproducciones.idReproducción) AS CantidadReproducciones
     FROM Canciones
          INNER JOIN Intérpretes
          ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
          INNER JOIN Reproducciones
          ON reproducciones.idcanción = Canciones.idCanción
     GROUP BY Intérpretes.idIntérprete, 
              Intérpretes.nombre) AS IR
    INNER JOIN(SELECT Intérpretes.idIntérprete, 
                      Intérpretes.nombre, 
                      AVG(Calificaciones.calificación) AS Calificación
               FROM Canciones
                    INNER JOIN Intérpretes
                    ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
                    INNER JOIN Calificaciones
                    ON Calificaciones.idcanción = Canciones.idCanción
               GROUP BY Intérpretes.idIntérprete, 
                        Intérpretes.nombre) AS IC
    ON IR.idIntérprete = IC.idIntérprete
	
-- Script 12.2
CREATE VIEW ReproduccionesYCalificacionsPorInterprete
AS
SELECT IR.nombre, 
       IR.CantidadReproducciones, 
       IC.Calificación
FROM(SELECT Intérpretes.idIntérprete, 
            Intérpretes.nombre, 
            COUNT(Reproducciones.idReproducción) AS CantidadReproducciones
     FROM Canciones
          INNER JOIN Intérpretes
          ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
          INNER JOIN Reproducciones
          ON reproducciones.idcanción = Canciones.idCanción
     GROUP BY Intérpretes.idIntérprete, 
              Intérpretes.nombre) AS IR
    INNER JOIN(SELECT Intérpretes.idIntérprete, 
                      Intérpretes.nombre, 
                      AVG(Calificaciones.calificación) AS Calificación
               FROM Canciones
                    INNER JOIN Intérpretes
                    ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
                    INNER JOIN Calificaciones
                    ON Calificaciones.idcanción = Canciones.idCanción
               GROUP BY Intérpretes.idIntérprete, 
                        Intérpretes.nombre) AS IC
    ON IR.idIntérprete = IC.idIntérprete

-- Script 12.3
SELECT *
FROM ReproduccionesYCalificacionsPorInterprete

-- Script 12.4
SELECT nombre
FROM ReproduccionesYCalificacionsPorInterprete	
WHERE calificación >= 3.0

-- Script 12.5
CREATE OR REPLACE VIEW ReproduccionesYCalificacionsPorInterprete
AS
SELECT IR.nombre, 
       IR.CantidadReproducciones, 
       IC.Calificación
FROM(SELECT Intérpretes.idIntérprete, 
            Intérpretes.nombre, 
            COUNT(Reproducciones.idReproducción) AS CantidadReproducciones
     FROM Canciones
          INNER JOIN Intérpretes
          ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
          INNER JOIN Reproducciones
          ON reproducciones.idcanción = Canciones.idCanción
     GROUP BY Intérpretes.idIntérprete, 
              Intérpretes.nombre) AS IR
    INNER JOIN(SELECT Intérpretes.idIntérprete, 
                      Intérpretes.nombre, 
                      AVG(Calificaciones.calificación) AS Calificación
               FROM Canciones
                    INNER JOIN Intérpretes
                    ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
                    INNER JOIN Calificaciones
                    ON Calificaciones.idcanción = Canciones.idCanción
               GROUP BY Intérpretes.idIntérprete, 
                        Intérpretes.nombre) AS IC
    ON IR.idIntérprete = IC.idIntérprete
WHERE IC.Calificación >= 3.0;

-- Script 12.6
DROP VIEW ReproduccionesYCalificacionsPorInterprete;

-- Script 12.7
CREATE MATERIALIZED VIEW ReproduccionesYCalificacionsPorInterprete
AS
SELECT IR.nombre, 
       IR.CantidadReproducciones, 
       IC.Calificación
FROM(SELECT Intérpretes.idIntérprete, 
            Intérpretes.nombre, 
            COUNT(Reproducciones.idReproducción) AS CantidadReproducciones
     FROM Canciones
          INNER JOIN Intérpretes
          ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
          INNER JOIN Reproducciones
          ON reproducciones.idcanción = Canciones.idCanción
     GROUP BY Intérpretes.idIntérprete, 
              Intérpretes.nombre) AS IR
    INNER JOIN(SELECT Intérpretes.idIntérprete, 
                      Intérpretes.nombre, 
                      AVG(Calificaciones.calificación) AS Calificación
               FROM Canciones
                    INNER JOIN Intérpretes
                    ON Canciones.idintérpreteprincipal = Intérpretes.idIntérprete
                    INNER JOIN Calificaciones
                    ON Calificaciones.idcanción = Canciones.idCanción
               GROUP BY Intérpretes.idIntérprete, 
                        Intérpretes.nombre) AS IC
    ON IR.idIntérprete = IC.idIntérprete
WHERE IC.Calificación >= 3.0;

-- Script 12.8
REFRESH MATERIALIZED VIEW ReproduccionesYCalificacionsPorInterprete;

-- Script 12.9
CREATE OR REPLACE FUNCTION edad(fechaNacimiento DATE) 
RETURNS INT
AS
$BODY$
	DECLARE 
	edad INT;
	hoy DATE;
	BEGIN
	hoy := NOW();
	edad := EXTRACT (YEAR FROM AGE(hoy, fechaNacimiento));
	return edad;
	END;
$BODY$
language 'plpgsql';

-- Script 12.10
SELECT edad('08/08/1987')

-- Script 12.11
SELECT nombres, edad(fechaNacimiento)
FROM Usuarios

-- Script 12.12
CREATE OR REPLACE FUNCTION estado(lanzamiento INT, retiro INT) 
RETURNS varchar(50)
AS
$BODY$
DECLARE 
msg VARCHAR(50);
años INTEGER;
BEGIN
IF retiro is null THEN
años := retiro - EXTRACT(YEAR FROM NOW());
msg:= CONCAT('En ejercicio, tiene ', años, ' años de vida artística');
ELSE
años := retiro - lanzamiento;
msg:=  CONCAT('Retirado luego de ', años, ' años de vida artística');
END IF;
return msg;
END;
$BODY$
language 'plpgsql';

-- Script 12.13
SELECT nombre, estado (añoLanzamiento, añoRetiro)
FROM Intérpretes;

-- Script 12.14
CREATE OR REPLACE FUNCTION Roles(IN idMúsicoBuscado INT, OUT esSolista BOOLEAN, OUT esCompositor BOOLEAN, OUT perteneceGrupo BOOLEAN)
RETURNS record 
AS
$BODY$
DECLARE 
idSolista INT;
idCompositor INT;
idParticipaciónGrupo INT;
BEGIN

-- Búsqueda en la tabla solista

SELECT idMúsico INTO idSolista
FROM Solistas
WHERE idMúsico = idMúsicoBuscado;

esSolista := idSolista is NOT NULL;

-- Búsqueda en la tabla Compositores

SELECT idMúsicoCompositor INTO idCompositor
FROM Compositores
WHERE idMúsicoCompositor = idMúsicoBuscado;

esCompositor := idCompositor is NOT NULL;

-- Búsqueda en la tabla participación en grupos

SELECT idMúsico INTO idParticipaciónGrupo
FROM ParticipacionesEnGrupos
WHERE idMúsico = idMúsicoBuscado;

perteneceGrupo := idParticipaciónGrupo is NOT NULL;

END;
$BODY$
language 'plpgsql';

-- Script 12.15
SELECT Roles(1);

-- Script 12.16
SELECT * FROM Roles(1);

-- Script 12.17
SELECT (Roles(1)).esSolista;

-- Script 12.18
SELECT (Roles(idMúsico)).esSolista, (Roles(idMúsico)).esCompositor, (Roles(idMúsico)).perteneceGrupo
FROM Músicos

-- Script 12.19
SELECT *
FROM Canciones
WHERE idGénero = (SELECT idGénero FROM Géneros WHERE nombre = 'Salsa');

-- Script 12.20
CREATE OR REPLACE FUNCTION CancionesPorGéneroEIntérprete (IN género VARCHAR(20))
RETURNS SETOF Canciones
AS
$CUERPO$
BEGIN
	RETURN QUERY
	SELECT *
	FROM Canciones
	WHERE idGénero = (SELECT idGénero FROM Géneros WHERE nombre = género);
END
$CUERPO$
Language 'plpgsql';

-- Script 12.21
SELECT * FROM CancionesPorGéneroEIntérprete('Vallenato') ;

-- Script 12.22
SELECT * FROM CancionesPorGéneroEIntérprete('Salsa') ;

-- Script 12.23
CREATE OR REPLACE FUNCTION CancionesPorGéneroEIntérprete (IN género VARCHAR(20))
RETURNS SETOF RECORD
AS
$CUERPO$
BEGIN
	RETURN QUERY
	SELECT Canciones.título, Álbumes.título
	FROM Canciones INNER JOIN Álbumes ON Canciones.idÁlbumOriginal = Álbumes.idAlbum
	WHERE idGénero = (SELECT idGénero FROM Géneros WHERE nombre = género);
END
$CUERPO$
Language 'plpgsql';

-- Script 12.24
SELECT * FROM CancionesPorGéneroEIntérprete('Vallenato') f(título VARCHAR(100), álbum VARCHAR(100));

-- Script 12.25
CREATE OR REPLACE FUNCTION CancionesPorGéneroEIntérprete (IN género VARCHAR(20), OUT título VARCHAR(100), OUT Álbum VARCHAR(100))
RETURNS SETOF RECORD
AS
$CUERPO$
BEGIN
	RETURN QUERY
	SELECT Canciones.título, Álbumes.título
	FROM Canciones INNER JOIN Álbumes ON Canciones.idÁlbumOriginal = Álbumes.idAlbum
	WHERE idGénero = (SELECT idGénero FROM Géneros WHERE nombre = género);
END
$CUERPO$
Language 'plpgsql';

-- Script 12.26
SELECT * FROM CancionesPorGéneroEIntérprete('Vallenato')

-- Script 12.27
CREATE OR REPLACE FUNCTION ReporteUsuario (IN sexoBuscado VARCHAR(30) DEFAULT 'F', IN limiteInferiorEdad INT DEFAULT 18, IN limiteSuperiorEdad INT DEFAULT 45  )
RETURNS TABLE (idUsuario INT, totalReproducciones INT, reproduccionesDía INT, reproduccionesTarde INT, reproduccionesNoche INT)
AS
$CODE$
DECLARE
filaUsuario Usuarios%rowtype;
filaReproducción Reproducciones%rowtype;
cReproducciones INT := 0;
crDía INT := 0;
crTarde INT := 0;
crNoche INT := 0;
BEGIN
	-- recuperación de los uauarios
	FOR filaUsuario IN SELECT *
					  FROM Usuarios
					  WHERE (Usuarios.sexo = sexoBuscado) AND (edad(Usuarios.fechaNacimiento) BETWEEN limiteInferiorEdad AND limiteSuperiorEdad ) LOOP
	-- recuperación de las canciones para cada usuario
		
			FOR filaReproducción IN SELECT *
					  FROM Reproducciones
					  WHERE Reproducciones.idUsuario = filaUsuario.idUsuario LOOP
				-- contar la cantidad total de reproducción  
				cReproducciones := cReproducciones + 1;
				-- contar la cantidad de reproducción según la época 
				CASE 
					WHEN EXTRACT (hour FROM filaReproducción.horaReproducción) BETWEEN 0 AND 8 THEN crDía := crDía + 1;
					WHEN EXTRACT (hour FROM filaReproducción.horaReproducción) BETWEEN 9 AND 18 THEN crTarde := crTarde + 1;
					WHEN EXTRACT (hour FROM filaReproducción.horaReproducción) BETWEEN 19 AND 23  THEN crNoche := crNoche + 1;
			    END CASE;
			
			END LOOP;
		-- guardar los valores en la tabla
		idUsuario := filaUsuario.idUsuario;
		totalReproducciones := cReproducciones;
		reproduccionesDía := crDía;
		reproduccionesTarde := crTarde;
		reproduccionesNoche := crNoche;
		RETURN NEXT;
		-- reiniciar los contadores
		cReproducciones := 0;
		crDía  := 0;
		crTarde  := 0;
		crNoche := 0;
				  
	END LOOP;
	RETURN;
END
$CODE$
LANGUAGE 'plpgsql';

-- Script 12.28
CREATE TRIGGER t_controlReproducciones 
BEFORE INSERT on Reproducciones 
FOR EACH ROW 
EXECUTE PROCEDURE f_controlReproducciones();

-- Script 12.29
CREATE OR REPLACE FUNCTION f_controlReproducciones() 
RETURNS trigger as
$$
DECLARE 
cantidad INT := 0; 
BEGIN

	SELECT COUNT(*) INTO cantidad
	FROM Reproducciones
	WHERE Reproducciones.idUsuario = NEW.idUsuario;

	IF cantidad < 100 THEN 
		RETURN NEW;
		RAISE NOTICE 'insertando';
	END IF;  
	RAISE NOTICE 'no insertando';
	RETURN NULL;
END; 
$$
LANGUAGE 'plpgsql';

-- Script 12.30
INSERT INTO Reproducciones
VALUES(500, (SELECT idUsuario
FROM Usuarios
WHERE email = 'panteismo@gmail.com'), (SELECT idCanción
FROM Canciones
WHERE título = 'La bicicleta'), CAST (NOW() AS DATE), CAST (NOW() AS TIME), 189);

-- Script 12.31
CREATE OR REPLACE FUNCTION f_modificarConstraseña() 
RETURNS trigger as
$$
DECLARE 
cantidad INT := 0; 
BEGIN


	IF NEW.contraseña <> OLD.contraseña THEN 
		RAISE NOTICE 'Cambiando';
		RETURN NEW;
	END IF;  
	RAISE NOTICE 'no se puede cambiar';
	RETURN NULL;
END; 
$$
LANGUAGE 'plpgsql';

-- Script 12.32
CREATE TRIGGER t_modificarConstraseña 
BEFORE UPDATE on Usuarios 
FOR EACH ROW 
EXECUTE PROCEDURE f_modificarConstraseña();

-- Script 12.33
UPDATE Usuarios
SET contraseña = 'new password'
WHERE idUsuario = 1;

-- Script 12.34
CREATE TRIGGER t_eliminarUsuario
BEFORE DELETE on Usuarios 
FOR EACH ROW 
EXECUTE PROCEDURE  f_eliminarUsuario();

-- Script 12.35
CREATE OR REPLACE FUNCTION f_eliminarUsuario() 
RETURNS trigger as
$$
BEGIN

	DELETE FROM CancionesLista 
	WHERE (idListaReproducción IN (SELECT idListaReproducción FROM ListasReproducción WHERE idUsuario = OLD.idUsuario));

	RAISE NOTICE 'Se eliminaron las filas de la tabla CancionesLista';
	
	DELETE FROM ListasReproducción
	WHERE idUsuario = OLD.idUsuario;
	
	RAISE NOTICE 'Se eliminaron las filas de la tabla ListasReproducción';
	
	DELETE FROM Reproducciones
	WHERE idUsuario = OLD.idUsuario;
	
	RAISE NOTICE 'Se eliminaron las filas de la tabla Reproducciones';
	
	DELETE FROM Calificaciones
	WHERE idUsuario = OLD.idUsuario;
	
	RAISE NOTICE 'Se eliminaron las filas de la tabla Calificaciones';
	
	DELETE FROM Pagos
	WHERE idUsuario = OLD.idUsuario;
	
	RAISE NOTICE 'Se eliminaron las filas de la tabla Pagos';

	RETURN OLD;

END; 
$$
LANGUAGE 'plpgsql';

-- Script 12.36
DELETE FROM Usuarios WHERE idUsuario = 2;

-- Script 12.37
DROP TRIGGER t_eliminarUsuario ON Usuarios;
DROP FUNCTION f_eliminarUsuario;

-- Script 12.38
CREATE OR REPLACE PROCEDURE 
insertarIntérprete(idIntérprete INT, nombre VARCHAR(200), añoLanzamiento INT, añoRetiro INT, tipoIntérprete VARCHAR(10), idGénero INT, nombreGénero VARCHAR(100))
AS
$CODE$
BEGIN
        RAISE NOTICE 'Insertando género %', nombreGénero;
		INSERT INTO Géneros(idGénero, nombre, descripción)
		VALUES(idGénero, nombreGénero, NULL);
        RAISE NOTICE 'Género % insertado', nombreGénero;
		
		RAISE NOTICE 'Insertando intérprete %', nombre;
		INSERT INTO Intérpretes
		VALUES (idIntérprete, nombre, añoLanzamiento, añoRetiro, tipoIntérprete, idGénero);
        RAISE NOTICE 'Intérprte % insertado', nombre;    

END
$CODE$
LANGUAGE 'plpgsql'

-- Script 12.39
CALL insertarIntérprete(25, 'Mr Black', 1990, NULL, 'Solista', 90, 'Champeta' );

-- Script 12.40
CREATE OR REPLACE PROCEDURE 
insertarIntérprete(idIntérprete INT, nombre VARCHAR(200), añoLanzamiento INT, añoRetiro INT, tipoIntérprete VARCHAR(10), idGénero INT, nombreGénero VARCHAR(100))
AS
$CODE$
BEGIN
        RAISE NOTICE 'Insertando género %', nombreGénero;
		INSERT INTO Géneros(idGénero, nombre, descripción)
		VALUES(idGénero, nombreGénero, NULL);
        RAISE NOTICE 'Género % insertado', nombreGénero;
		
		-- Guardar cambios
		COMMIT;
		
		RAISE NOTICE 'Insertando intérprete %', nombre;
		INSERT INTO Intérpretes
		VALUES (idIntérprete, nombre, añoLanzamiento, añoRetiro, tipoIntérprete, idGénero);
        RAISE NOTICE 'Intérprte % insertado', nombre;    

END
$CODE$
LANGUAGE 'plpgsql';

-- Script 12.41
CREATE OR REPLACE PROCEDURE 
insertarIntérprete(idIntérprete INT, nombre VARCHAR(200), añoLanzamiento INT, añoRetiro INT, tipoIntérprete VARCHAR(10), idGénero INT, nombreGénero VARCHAR(100))
AS
$CODE$
DECLARE
intérprete Intérpretes%rowtype;
BEGIN
        RAISE NOTICE 'Insertando género %', nombreGénero;
	 INSERT INTO Géneros(idGénero, nombre, descripción)
	 VALUES(idGénero, nombreGénero, NULL);
        RAISE NOTICE 'Género % insertado', nombreGénero;
		
	 SELECT * INTO intérprete
	 FROM Intérpretes
	 WHERE Intérpretes.idIntérprete = $1;
		
	 IF intérprete.idIntérprete IS NULL THEN
	    RAISE NOTICE 'COMMIT';
	    COMMIT;
	 ELSE
	    RAISE NOTICE 'ROLLBACK';
	    ROLLBACK;
		
	 END IF;
		
		
	 RAISE NOTICE 'Insertando intérprete %', nombre;
	 INSERT INTO Intérpretes
	 VALUES (idIntérprete, nombre, añoLanzamiento, añoRetiro, tipoIntérprete, idGénero);
        RAISE NOTICE 'Intérprte % insertado', nombre;    

END
$CODE$
LANGUAGE 'plpgsql';
















