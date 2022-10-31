CREATE TABLE Géneros(
	identificador int NOT NULL,
	nombre varchar(50) NOT NULL,
	PRIMARY KEY (identificador)
);

CREATE TABLE "Álbumes"(
	identificador int NOT NULL,
	título varchar (100) NOT NULL,
	"fecha de lanzamiento" date NULL,
	"sello discográfico" varchar(50) NOT NULL,
	PRIMARY KEY (identificador)
);

CREATE TABLE Artistas(
	identificador int NOT NULL,
	nombre varchar(100) NOT NULL,
	"año de lanzamiento" int NOT NULL,
	"año de retiro" int NULL,
	tipo varchar(10) NOT NULL,
	"género principal" int NOT NULL,
	PRIMARY KEY (identificador),
	FOREIGN KEY ("género principal") REFERENCES Géneros(identificador)
);

CREATE TABLE Canciones(
	identificador int NOT NULL,
	título varchar(100) NOT NULL,
	duración time(0) NOT NULL,
	género int NOT NULL,
	idioma varchar(10) NOT NULL,
	"artista principal" int NOT NULL,
	"álbum original" int NULL,
	PRIMARY KEY (identificador),
	FOREIGN KEY (género) REFERENCES Géneros(identificador),
	FOREIGN KEY ("artista principal") REFERENCES Artistas(identificador),
	FOREIGN KEY ("álbum original") REFERENCES Álbumes(identificador)
);

INSERT INTO Géneros VALUES 
(1, N'Vallenato'),
(2, N'Salsa'),
(3, N'Pop'),
(4, N'Urbano Latino');

INSERT INTO "Álbumes" VALUES 
(900001, N'La tierra del olvido', CAST(N'1995-07-25' AS Date), N'EMI Latin'),
(900002, N'¿Dónde están los ladrones?', CAST(N'1998-09-29' AS Date), N'Sony Music'),
(900004, N'Vibras', CAST(N'2018-05-25' AS Date), N'Universal'),
(900005, N'No hay quinto malo', NULL, N'Internacional Records'),
(900006, N'El binomio de oro', CAST(N'1976-11-03' AS Date), N'Codiscos'),
(900008, N'Por lo alto', CAST(N'1976-11-02' AS Date), N'Codiscos'),
(900009, N'Déjame entrar', CAST(N'2001-11-06' AS Date), N'EMI Latin'),
(900011, N'Cielo de tambores', CAST(N'1990-12-20' AS Date), N'Codiscos');

INSERT INTO Artistas VALUES 
(50001, N'Carlos Vives', 1986, NULL, N'Solista', 1),
(50002, N'Niche', 1979, NULL, N'Grupo', 2),
(50003, N'Shakira', 1990, NULL, N'Solista', 3),
(50004, N'Binomio de Oro de América', 1976, NULL, N'Grupo', 1),
(50005, N'J Balvil', 2006, NULL, N'Solista', 4);

INSERT INTO Canciones VALUES 
(10001, N'La tierra del olvido', CAST(N'00:04:25' AS Time), 1, N'español', 50001, 900001),
(10002, N'Ojos así', CAST(N'00:03:57' AS Time), 3, N'español', 50003, 900002),
(10003, N'Mi gente', CAST(N'00:03:05' AS Time), 4, N'español', 50005, NULL),
(10004, N'Ambiente', CAST(N'00:04:08' AS Time), 4, N'español', 50005, 900004),
(10005, N'Cali pachanguero', CAST(N'00:04:51' AS Time), 2, N'español', 50002, 900005),
(10006, N'La creciente', CAST(N'00:03:04' AS Time), 1, N'español', 50004, 900006),
(10007, N'Sueños de conquista', CAST(N'00:04:02' AS Time), 1, N'español', 50004, 900008),
(10009, N'Carito', CAST(N'00:03:39' AS Time), 3, N'español', 50001, 900009),
(10011, N'Una aventura', CAST(N'00:05:16' AS Time), 2, N'español', 50002, 900011),
(10012, N'Ginza', CAST(N'00:04:39' AS Time), 4, N'español', 50005, NULL),
(10013, N'Octavo día', CAST(N'00:04:32' AS Time), 3, N'español', 50003, 900002),
(10014, N'Quiero verte sonreír', CAST(N'00:03:18' AS Time), 3, N'español', 50001, 900009);