USE Importar;
GO

/* =====================================================
   CREACIÓN DE TABLA
   ===================================================== */

-- Eliminamos la tabla si existe (para volver a crearla)
DROP TABLE IF EXISTS atletas;

-- Tabla principal con información de atletas y JJOO
CREATE TABLE atletas (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200),
    Sex NVARCHAR(10),
    Age INT,
    Height INT,
    Weight INT,
    Team NVARCHAR(200),
    NOC NVARCHAR(10),           -- Código del país
    Games NVARCHAR(50),         -- Ej: Beijing 2008
    Anio INT,
    Season NVARCHAR(20),        -- Summer / Winter
    City NVARCHAR(200),
    Sport NVARCHAR(200),
    Event NVARCHAR(500),
    Medal NVARCHAR(50)
);

-- Verificamos la tabla
SELECT * FROM atletas;


/* =====================================================
   INSERCIÓN DE DATOS DE EJEMPLO
   ===================================================== */

INSERT INTO atletas
(Name, Sex, Age, Height, Weight, Team, NOC, Games, Anio, Season, City, Sport, Event, Medal)
VALUES
('Usain Bolt', 'M', 22, 195, 94, 'Jamaica', 'JAM', 'Beijing 2008', 2008, 'Summer', 'Beijing', 'Athletics', '100m Men', 'Gold'),
('Michael Phelps', 'M', 23, 193, 91, 'United States', 'USA', 'Beijing 2008', 2008, 'Summer', 'Beijing', 'Swimming', '200m Butterfly', 'Gold'),
('Lionel Messi', 'M', 21, 170, 72, 'Argentina', 'ARG', 'Beijing 2008', 2008, 'Summer', 'Beijing', 'Football', 'Men Football', 'Gold'),
('Simone Biles', 'F', 19, 142, 47, 'United States', 'USA', 'Rio 2016', 2016, 'Summer', 'Rio de Janeiro', 'Gymnastics', 'All-Around', 'Gold');


/* =====================================================
   CONSULTAS DE ANÁLISIS (LEVEL 1 SQL)
   ===================================================== */

-- 1) ¿Cuántos Juegos Olímpicos se han celebrado?
SELECT COUNT(DISTINCT Games) AS cantidad_juegos
FROM atletas;

-- 2) Listar todos los Juegos Olímpicos jugados
SELECT DISTINCT Games
FROM atletas;

-- 3) Número total de naciones participantes
SELECT COUNT(DISTINCT NOC) AS total_naciones
FROM atletas;

-- 4) Año con MAYOR cantidad de países participantes
SELECT TOP 1 Anio, COUNT(DISTINCT NOC) AS cantidad_paises
FROM atletas
GROUP BY Anio
ORDER BY cantidad_paises DESC;

-- 5) Año con MENOR cantidad de países participantes
SELECT TOP 1 Anio, COUNT(DISTINCT NOC) AS cantidad_paises
FROM atletas
GROUP BY Anio
ORDER BY cantidad_paises ASC;

-- 6) Países que participaron en TODOS los Juegos Olímpicos
SELECT NOC
FROM atletas
GROUP BY NOC
HAVING COUNT(DISTINCT Anio) = (
    SELECT COUNT(DISTINCT Anio) FROM atletas
);

-- 7) Deportes que se jugaron en TODOS los JJOO de verano
SELECT Sport
FROM atletas
WHERE Season = 'Summer'
GROUP BY Sport
HAVING COUNT(DISTINCT Games) = (
    SELECT COUNT(DISTINCT Games)
    FROM atletas
    WHERE Season = 'Summer'
);

-- 8) Número total de deportes por Juego Olímpico
SELECT Games, COUNT(DISTINCT Sport) AS total_deportes
FROM atletas
GROUP BY Games;

-- 9) Proporción de atletas masculinos y femeninos presentes en todos los JJOO
SELECT Sex, COUNT(DISTINCT Games) AS juegos_participados
FROM atletas
GROUP BY Sex
HAVING COUNT(DISTINCT Games) = (
    SELECT COUNT(DISTINCT Games) FROM atletas
);
