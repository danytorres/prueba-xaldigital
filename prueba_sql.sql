CREATE TABLE "Aerolineas" (
	"ID_AEROLINEA"	INTEGER NOT NULL UNIQUE,
	"NOMBRE_AEROLINEA"	TEXT NOT NULL,
	PRIMARY KEY("ID_AEROLINEA")
);

CREATE TABLE "Aeropuertos" (
	"ID_AEROPUERTO"	INTEGER NOT NULL UNIQUE,
	"NOMBRE_AEROPUERTO"	TEXT NOT NULL,
	PRIMARY KEY("ID_AEROPUERTO")
):

CREATE TABLE "Movimientos" (
	"ID_MOVIMIENTO"	INTEGER NOT NULL UNIQUE,
	"DESCRIPCION"	TEXT NOT NULL,
	PRIMARY KEY("ID_MOVIMIENTO")
);

CREATE TABLE "Vuelos" (
	"ID_AEROLINEA"	INTEGER NOT NULL,
	"ID_AEROPUERTO"	INTEGER NOT NULL,
	"ID_MOVIMIENTO"	INTEGER NOT NULL,
	"DIA"	TEXT NOT NULL,
	FOREIGN KEY("ID_AEROPUERTO") REFERENCES "Aeropuertos"("ID_AEROPUERTO"),
	FOREIGN KEY("ID_AEROLINEA") REFERENCES "Aerolineas"("ID_AEROLINEA"),
	FOREIGN KEY("ID_MOVIMIENTO") REFERENCES "Movimientos"("ID_MOVIMIENTO")
);

INSERT INTO Aerolineas (ID_AEROLINEA, NOMBRE_AEROLINEA) VALUES (1, "Volaris");
INSERT INTO Aerolineas (ID_AEROLINEA, NOMBRE_AEROLINEA) VALUES (2, "Aeromar");
INSERT INTO Aerolineas (ID_AEROLINEA, NOMBRE_AEROLINEA) VALUES (3, "Interjet");
INSERT INTO Aerolineas (ID_AEROLINEA, NOMBRE_AEROLINEA) VALUES (4, "Aeromexico");

INSERT INTO Aeropuertos (ID_AEROPUERTO, NOMBRE_AEROPUERTO) VALUES (1, "Benito Juarez");
INSERT INTO Aeropuertos (ID_AEROPUERTO, NOMBRE_AEROPUERTO) VALUES (2, "Guanajuato");
INSERT INTO Aeropuertos (ID_AEROPUERTO, NOMBRE_AEROPUERTO) VALUES (3, "La paz");
INSERT INTO Aeropuertos (ID_AEROPUERTO, NOMBRE_AEROPUERTO) VALUES (4, "Oaxaca");

INSERT INTO Movimientos (ID_MOVIMIENTO, DESCRIPCION) VALUES (1, "Salida");
INSERT INTO Movimientos (ID_MOVIMIENTO, DESCRIPCION) VALUES (2, "Llegada");

INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (1, 1, 1, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (2, 1, 1, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (3, 2, 2, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (4, 3, 2, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (1, 3, 2, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (2, 1, 1, "2021-05-02");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (2, 3, 1, "2021-05-04");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (3, 4, 1, "2021-05-04");
INSERT INTO Vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES (3, 4, 1, "2021-05-04");

/* Respuesta pregunta 1 */
SELECT Aeropuertos.NOMBRE_AEROPUERTO as "Aeropuerto", COUNT(Vuelos.ID_AEROPUERTO) as "Movimientos"
FROM Vuelos
JOIN Aeropuertos ON Vuelos.ID_AEROPUERTO = Aeropuertos.ID_AEROPUERTO
GROUP BY Vuelos.ID_AEROPUERTO
HAVING COUNT(Vuelos.ID_AEROPUERTO)=(
SELECT MAX(mycount)
FROM (
SELECT Vuelos.ID_AEROPUERTO, count(Vuelos.ID_AEROPUERTO) AS mycount
FROM Vuelos
GROUP BY Vuelos.ID_AEROPUERTO));

/*
Respuesta QUERY
--------------+-------------
Aeropuerto    | Movimientos
--------------+-------------
Benito Juarez | 3
La paz        | 3
----------------------------

---------------------------------------------------------------------------------------------------------------*/

/* Respuesta pregunta 2 */
SELECT Aerolineas.NOMBRE_AEROLINEA as "Aerolinea", COUNT(Vuelos.ID_AEROLINEA) as "Movimientos"
FROM Vuelos
JOIN Aerolineas ON Vuelos.ID_AEROLINEA = Aerolineas.ID_AEROLINEA
GROUP BY Vuelos.ID_AEROLINEA
HAVING COUNT(Vuelos.ID_AEROLINEA)=(
SELECT MAX(mycount)
FROM (
SELECT Vuelos.ID_AEROLINEA, count(Vuelos.ID_AEROLINEA) AS mycount
FROM Vuelos
GROUP BY Vuelos.ID_AEROLINEA));

/*
Respuesta QUERY
----------+-------------
Aerolinea | Movimientos
----------+-------------
Aeromar   | 3
Interjet  | 3
------------------------

---------------------------------------------------------------------------------------------------------------*/

/* Respuesta pregunta 3 */
SELECT DIA, COUNT(DIA) as "Movimientos"
FROM Vuelos
GROUP BY DIA
HAVING COUNT(DIA)=(
SELECT MAX(mycount)
FROM (
SELECT DIA, count(DIA) AS mycount
FROM Vuelos
GROUP BY DIA));

/*
Respuesta QUERY
-----------+-------------
DIA        | Movimientos
-----------+-------------
2021-05-02 | 6
-------------------------

---------------------------------------------------------------------------------------------------------------*/

/* Respuesta pregunta 4 */
SELECT DIA, Aerolineas.NOMBRE_AEROLINEA, mycount
FROM (
SELECT DIA, ID_AEROLINEA, count(ID_AEROLINEA) AS mycount
FROM Vuelos
GROUP BY DIA, ID_AEROLINEA
) AS myTabla
JOIN Aerolineas ON myTabla.ID_AEROLINEA = Aerolineas.ID_AEROLINEA
WHERE mycount >= 2;

/*
Respuesta QUERY
-----------+------------------+---------
DIA        | NOMBRE_AEROLINEA | mycount
-----------+------------------+---------
2021-05-02 | Volaris          | 2
2021-05-02 | Aeromar          | 2
2021-05-04 | Interjet         | 2
-----------+------------------+---------

---------------------------------------------------------------------------------------------------------------*/
