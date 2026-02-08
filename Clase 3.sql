USE Importar;
GO

/* =====================================================
   CONSULTAS CON JOINS Y SUBCONSULTAS
   ===================================================== */

-- Mostrar clientes junto a su tipo de cuenta y saldo (cliente específico)
SELECT 
    c.first_name,
    t.nombre AS tipo_cuenta,
    FORMAT(cu.saldo, 'N2') AS saldo
FROM Cuenta cu
INNER JOIN Clientes c ON cu.cliente_id = c.id
INNER JOIN TipoCuentas t ON cu.tipo_cuenta = t.id
WHERE c.id = 10;


/* =====================================================
   INSERCIÓN DE DATOS
   ===================================================== */

-- Insertar una nueva cuenta
INSERT INTO Cuenta (cliente_id, tipo_cuenta, saldo)
VALUES (142, 2, 500000);


/* =====================================================
   FILTROS CON JOINS
   ===================================================== */

-- Clientes con saldo mayor a 500000
SELECT 
    cl.first_name,
    cl.nationality,
    t.nombre AS tipo_cuenta,
    cu.saldo
FROM Cuenta cu
INNER JOIN Clientes cl ON cu.cliente_id = cl.id
INNER JOIN TipoCuentas t ON cu.tipo_cuenta = t.id
WHERE cu.saldo > 500000;

-- Clientes argentinos con saldo mayor a 1.000.000
SELECT 
    cl.first_name,
    cl.age,
    t.nombre AS tipo_cuenta,
    FORMAT(cu.saldo, 'N2') AS saldo
FROM Clientes cl
INNER JOIN Cuenta cu ON cu.cliente_id = cl.id
INNER JOIN TipoCuentas t ON cu.tipo_cuenta = t.id
WHERE cl.nationality = 'Argentina'
  AND cu.saldo > 1000000;


/* =====================================================
   SUBCONSULTAS
   ===================================================== */

-- Clientes con edad mayor al promedio
SELECT *
FROM Clientes
WHERE age > (SELECT AVG(age) FROM Clientes);

-- Clientes con la edad máxima registrada
SELECT *
FROM Clientes
WHERE age = (SELECT MAX(age) FROM Clientes);

-- Clientes con saldo mayor al promedio de todas las cuentas
SELECT cl.*
FROM Clientes cl
INNER JOIN Cuenta cu ON cu.cliente_id = cl.id
WHERE cu.saldo > (SELECT AVG(saldo) FROM Cuenta);

-- Clientes con saldo menor al promedio
SELECT 
    cl.first_name,
    cl.age,
    cu.saldo
FROM Clientes cl
INNER JOIN Cuenta cu ON cu.cliente_id = cl.id
WHERE cu.saldo < (SELECT AVG(saldo) FROM Cuenta);


/* =====================================================
   CONSULTAS CON GROUP BY / HAVING
   ===================================================== */

-- Clientes mayores de 60 años
SELECT first_name, age
FROM Clientes
WHERE age > 60;

-- Países donde la edad máxima de clientes es mayor a 60
SELECT nationality, MAX(age) AS edad_maxima
FROM Clientes
GROUP BY nationality
HAVING MAX(age) > 60;


/* =====================================================
   CASE Y FUNCIONES DE VENTANA
   ===================================================== */

-- Clasificación simple usando CASE
SELECT 
    first_name,
    last_name,
    email,
    age,
    CASE
        WHEN first_name LIKE 'A%' THEN 'Aprobados'
        ELSE 'Desaprobados'
    END AS estado
FROM Clientes
ORDER BY estado;

-- Ranking de clientes según saldo
SELECT 
    first_name,
    saldo,
    DENSE_RANK() OVER (ORDER BY saldo DESC) AS ranking
FROM Clientes;
