USE Importar;
GO

/* =====================================================
   RENOMBRAR TABLA
   ===================================================== */

-- Renombrar tabla importada
EXEC sp_rename '[MOCK_DATA (1)]', 'Clientes';

-- Verificar datos
SELECT * FROM Clientes;


/* =====================================================
   CONSULTAS BÁSICAS CON FILTROS
   ===================================================== */

-- Clientes de Colombia con tipo de cuenta específico
SELECT first_name, last_name, nationality, tipo_cuenta
FROM Clientes
WHERE nationality = 'Colombia'
  AND tipo_cuenta = 'Caja de Ahorro';

-- Clientes de Uruguay
SELECT *
FROM Clientes
WHERE nationality = 'Uruguay';

-- Clientes cuyo nombre empieza con A y tienen más de 70 años
SELECT *
FROM Clientes
WHERE first_name LIKE 'A%'
  AND age > 70
ORDER BY nationality;


/* =====================================================
   AGRUPACIONES Y CONTEOS
   ===================================================== */

-- ¿Cuántos tipos de cuenta distintos hay en un país específico?
SELECT nationality, COUNT(DISTINCT tipo_cuenta) AS tipos_cuenta_pais
FROM Clientes
WHERE nationality = 'Aland Islands'
GROUP BY nationality;

-- Para una nacionalidad, contar tipos de cuenta distintos
SELECT nationality, COUNT(DISTINCT tipo_cuenta) AS tipos_cuenta_pais
FROM Clientes
WHERE nationality = 'Argentina'
GROUP BY nationality;

-- Listar clientes argentinos ordenados
SELECT id, first_name, last_name, nationality
FROM Clientes
WHERE nationality = 'Argentina'
ORDER BY id ASC;


/* =====================================================
   METADATOS Y VALIDACIONES
   ===================================================== */

-- Ver columnas y tipos de datos
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Clientes';


/* =====================================================
   FORMATEO Y AGREGACIONES
   ===================================================== */

-- Promedio de saldo por país
SELECT nationality, FORMAT(AVG(saldo), 'N2') AS promedio_salarial
FROM Clientes
GROUP BY nationality;

-- Total de saldo general
SELECT FORMAT(SUM(saldo), 'N2') AS total_saldo
FROM Clientes;


/* =====================================================
   CLAVES Y ESTRUCTURA
   ===================================================== */

-- Asegurar clave primaria
ALTER TABLE Clientes
ADD CONSTRAINT PK_Clientes PRIMARY KEY (id);

ALTER TABLE Clientes
ALTER COLUMN id INT NOT NULL;


/* =====================================================
   TABLA CUENTA Y RELACIONES
   ===================================================== */

-- Crear tabla Cuenta relacionada con Clientes
CREATE TABLE Cuenta (
    id INT IDENTITY (1,1) PRIMARY KEY,
    cliente_id INT,
    tipo_cuenta INT,
    saldo DECIMAL(12,2),
    CONSTRAINT FK_Cuenta_Clientes
        FOREIGN KEY (cliente_id)
        REFERENCES Clientes(id)
);

-- Insertar cuenta de ejemplo
INSERT INTO Cuenta (cliente_id, tipo_cuenta, saldo)
VALUES (5, 1, 80000);

SELECT * FROM Cuenta;


/* =====================================================
   TABLA TIPO DE CUENTA
   ===================================================== */

-- Crear tabla de tipos de cuenta
CREATE TABLE TipoCuentas (
    id INT IDENTITY (1,1) PRIMARY KEY,
    nombre VARCHAR(50)
);

-- Insertar tipo de cuenta
INSERT INTO TipoCuentas (nombre)
VALUES ('Cuenta Corriente');

SELECT * FROM TipoCuentas;

-- Relación entre Cuenta y TipoCuentas
ALTER TABLE Cuenta
ADD CONSTRAINT FK_Cuenta_TipoCuentas
FOREIGN KEY (tipo_cuenta)
REFERENCES TipoCuentas(id);
