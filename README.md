# SQL Practice – Athletes Database

## Descripción
Proyecto de práctica enfocado en consultas SQL básicas e intermedias utilizando una base de datos de atletas.
El objetivo es reforzar los fundamentos de SQL mediante la resolución de distintos enunciados típicos de análisis de datos.

## Base de datos
La base de datos contiene información relacionada con atletas, eventos y resultados, utilizada para simular consultas reales de análisis.

## Tecnologías
- SQL
- (Compatible con MySQL / PostgreSQL / SQL Server)

## Consultas realizadas
- SELECT con filtros (WHERE)
- ORDER BY
- Funciones de agregación (COUNT, SUM, AVG)
- GROUP BY
- HAVING
- INNER JOIN
- Subconsultas simples

## Objetivo del proyecto
Practicar el nivel inicial de SQL orientado al análisis de datos, aplicando consultas comunes utilizadas para responder preguntas de negocio.

## Estado
Proyecto en progreso. Se irán agregando nuevas consultas y niveles de complejidad.


## Database Diagram

El siguiente diagrama muestra la relación entre las tablas del modelo:

- **Clientes**: contiene la información principal de cada cliente.
- **Cuenta**: almacena las cuentas asociadas a cada cliente.
- **TipoCuentas**: define los distintos tipos de cuenta disponibles.

La relación se realiza mediante **claves foráneas (FOREIGN KEY)**:
- `Cuenta.cliente_id` referencia a `Clientes.id`
- `Cuenta.tipo_cuenta` referencia a `TipoCuentas.id`

Este esquema permite mantener la integridad de los datos y modelar correctamente la relación entre clientes, sus cuentas y el tipo de cuenta asociado.

<img width="887" height="446" alt="image" src="https://github.com/user-attachments/assets/a1663cec-1044-4a36-9ed5-851b244de356" />
