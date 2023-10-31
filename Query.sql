--Crear DB
CREATE DATABASE ProyectoPeluqueria

--Usar DB
USE ProyectoPeluqueria

--Creación de tablas
CREATE TABLE tipos_productos(
	id_tipo_producto INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);
CREATE TABLE marcas(
	id_marca INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);
CREATE TABLE depositos(
	id_deposito INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);
CREATE TABLE cargos(
	id_cargo INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);
CREATE TABLE funcionarios(
	id_funcionario INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	id_cargo INT,
	FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
);
CREATE TABLE metodos_de_pago(
	id_metodo_pago INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);
CREATE TABLE productos(
	id_producto INT PRIMARY KEY IDENTITY(1,1),
	id_marca INT,
	id_tipo_producto INT,
	descripcion VARCHAR(250) NOT NULL,
	costo_unitario INT NOT NULL,
	porcentaje_iva INT NOT NULL,
	FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
);
CREATE TABLE productos_por_depositos(
	id_productos_por_depositos INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT,
	id_deposito INT,
	cantidad INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE proveedores(
	id_proveedor INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(200) NOT NULL,
	direccion VARCHAR(100),
	correo VARCHAR(100),
	credito INT
);
CREATE TABLE transferencias_productos(
	id_transferencia INT PRIMARY KEY IDENTITY(1,1),
	id_deposito_origen INT,
	id_deposito_destino INT,
	id_funcionario_encargado INT,
	id_funcionario_autorizante INT,
	fecha DATE NOT NULL,
	FOREIGN KEY (id_deposito_origen) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_deposito_destino) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_funcionario_encargado) REFERENCES funcionarios(id_funcionario),
	FOREIGN KEY (id_funcionario_autorizante) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE detalles_transferencias_productos(
	id_detalle_transferencia INT PRIMARY KEY IDENTITY(1,1),
	id_transferencia INT,
	id_producto INT,
	cantidad INT NOT NULL,
	FOREIGN KEY (id_transferencia) REFERENCES transferencias_productos(id_transferencia),
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
);

CREATE TABLE facturas (
	id_factura INT PRIMARY KEY IDENTITY(1,1),
	id_deposito INT,
	id_proveedor INT,
	fecha_compra DATE NOT NULL,
	condicion_compra BIT NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	numero_factura INT NOT NULL,
	total INT NOT NULL,
	saldo_pendiente INT NOT NULL,
	FOREIGN KEY (id_deposito) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalles_compras_proveedores(
	id_detalle_compra_proveedor INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT NOT NULL,
	id_factura INT NOT NULL,
	cantidad INT NOT NULL,
	costo_unitario INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
);
CREATE TABLE ordenes_de_pagos(
	id_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_proveedor INT,
	fecha DATE NOT NULL,
	monto_total INT NOT NULL
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalles_ordenes_de_pagos(
	id_detalle_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_factura INT,
	id_orden_de_pago INT,
	importe INT NOT NULL,
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	FOREIGN KEY (id_orden_de_pago) REFERENCES ordenes_de_pagos(id_orden_de_pago)
);
CREATE TABLE detalles_metodos_de_pagos(
	id_detalle_metodo_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_metodo_pago INT,
	importe INT NOT NULL,
	FOREIGN KEY (id_metodo_pago) REFERENCES metodos_de_pago(id_metodo_pago)
)
--Carga de datos
INSERT INTO tipos_productos (nombre)
VALUES ('Shampoo'),
       ('Acondicionador'),
       ('Tinte'),
       ('Gel');

INSERT INTO marcas (nombre)
VALUES ('Nivea'),
       ('Plusbelle'),
       ('TRESemme');

INSERT INTO depositos (nombre)
VALUES ('Salón'),
       ('Depósito');

INSERT INTO cargos (nombre)
VALUES ('Peluquero'),
       ('Recepcionista'),
       ('Supervisor');

INSERT INTO funcionarios (nombre, id_cargo)
VALUES ('Jorge Figueredo', (SELECT id_cargo FROM cargos WHERE nombre = 'Peluquero')),
       ('Pedro Kazlauskas', (SELECT id_cargo FROM cargos WHERE nombre = 'Recepcionista')),
       ('Rodrigo Maidana', (SELECT id_cargo FROM cargos WHERE nombre = 'Supervisor'));

-- Insertar métodos de pago
INSERT INTO metodos_de_pago (nombre)
VALUES
    ('Efectivo'),
    ('Tarjeta de crédito'),
    ('Tarjeta de débito'),
    ('Transferencia bancaria'),
    ('QR');

-- Insertar productos de ejemplo para Nivea
INSERT INTO productos (id_marca, id_tipo_producto, descripcion, costo_unitario, porcentaje_iva)
VALUES
    ((SELECT id_marca FROM marcas WHERE nombre = 'Nivea'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Shampoo'), 'Shampoo Nivea', 27000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Nivea'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Acondicionador'), 'Acondicionador Nivea', 30000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Nivea'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Tinte'), 'Tinte Nivea', 40000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Nivea'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Gel'), 'Gel Nivea', 35000, 10);

-- Insertar productos de ejemplo para TRESemme
INSERT INTO productos (id_marca, id_tipo_producto, descripcion, costo_unitario, porcentaje_iva)
VALUES
    ((SELECT id_marca FROM marcas WHERE nombre = 'TRESemme'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Shampoo'), 'Shampoo TRESemme', 25000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'TRESemme'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Acondicionador'), 'Acondicionador TRESemme', 32000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'TRESemme'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Tinte'), 'Tinte TRESemme', 40000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'TRESemme'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Gel'), 'Gel TRESemme', 35000, 10);

-- Insertar productos de ejemplo para Plusbelle
INSERT INTO productos (id_marca, id_tipo_producto, descripcion, costo_unitario, porcentaje_iva)
VALUES
    ((SELECT id_marca FROM marcas WHERE nombre = 'Plusbelle'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Shampoo'), 'Shampoo Plusbelle', 25000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Plusbelle'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Acondicionador'), 'Acondicionador Plusbelle', 30000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Plusbelle'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Tinte'), 'Tinte Plusbelle', 46000, 10),
    ((SELECT id_marca FROM marcas WHERE nombre = 'Plusbelle'), (SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Gel'), 'Gel Plusbelle', 37000, 10);

-- Insertar productos por depósito con cantidades aleatorias
-- Para el Salón (entre 1 y 5 unidades)
INSERT INTO productos_por_depositos (id_producto, id_deposito, cantidad)
VALUES
    (1, 1, FLOOR(RAND() * 5) + 1),
    (2, 1, FLOOR(RAND() * 5) + 1),
    (3, 1, FLOOR(RAND() * 5) + 1),
    (4, 1, FLOOR(RAND() * 5) + 1),
	(5, 1, FLOOR(RAND() * 5) + 1),
	(6, 1, FLOOR(RAND() * 5) + 1),
	(7, 1, FLOOR(RAND() * 5) + 1),
	(8, 1, FLOOR(RAND() * 5) + 1),
	(9, 1, FLOOR(RAND() * 5) + 1),
	(10, 1, FLOOR(RAND() * 5) + 1),
	(11, 1, FLOOR(RAND() * 5) + 1),
	(12, 1, FLOOR(RAND() * 5) + 1);

-- Para el Depósito (entre 15 y 20 unidades)
INSERT INTO productos_por_depositos (id_producto, id_deposito, cantidad)
VALUES
    (1, 2, FLOOR(RAND() * 6) + 15),
    (2, 2, FLOOR(RAND() * 6) + 15),
    (3, 2, FLOOR(RAND() * 6) + 15),
    (4, 2, FLOOR(RAND() * 6) + 15),
	(5, 2, FLOOR(RAND() * 6) + 15),
    (6, 2, FLOOR(RAND() * 6) + 15),
    (7, 2, FLOOR(RAND() * 6) + 15),
    (8, 2, FLOOR(RAND() * 6) + 15),
	(9, 2, FLOOR(RAND() * 6) + 15),
    (10, 2, FLOOR(RAND() * 6) + 15),
    (11, 2, FLOOR(RAND() * 6) + 15),
    (12, 2, FLOOR(RAND() * 6) + 15);

-- Insertar proveedores
INSERT INTO proveedores (nombre, direccion, correo, credito)
VALUES
    ('Estética del Sur', 'Encarnación', 'esteticadelsur@gmail.com', 8000000),
    ('Margarita SA', 'Ciudad del Este', 'margarita.sa@gmail.com', 4000000),
    ('San Cosme', 'Asunción', 'sancosme@gmail.com', 12000000);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		(GETDATE()),
		0,
		(GETDATE()),
		1,
		0,
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		(GETDATE()),
		1,
		(GETDATE()),
		3,
		0,
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		(GETDATE()),
		3,
		(GETDATE()),
		2,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE id_factura=7),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'));

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo TRESemme'),
		(SELECT id_factura FROM facturas WHERE id_factura=8),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo TRESemme'));

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE id_factura=8),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'));

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Plusbelle'),
		(SELECT id_factura FROM facturas WHERE id_factura=7),
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Plusbelle'));

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='gel Plusbelle'),
		(SELECT id_factura FROM facturas WHERE id_factura=7),
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='gel Plusbelle'));

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Gel Tresemme'),
		(SELECT id_factura FROM facturas WHERE id_factura=6),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Tresemme'));


INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Tresemme'),
		(SELECT id_factura FROM facturas WHERE id_factura=6),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Tresemme'));


INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='tinte Tresemme'),
		(SELECT id_factura FROM facturas WHERE id_factura=6),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='tinte Tresemme'));
--Ver todas las tablas
SELECT * FROM sys.tables;

--Ver opciones de algo
exec sp_columns detalles_compras_proveedores;

--Ver columnas de algo
SELECT * FROM detalles_compras_proveedores

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		(GETDATE()),
		0,
		(GETDATE()),
		77,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Tresemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=77),
		15,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Tresemme'));

SELECT * FROM productos_por_depositos AS d
INNER JOIN productos AS p ON d.id_producto = p.id_producto
WHERE p.descripcion = 'Shampoo'; -- Asegúrate de rodear 'TRESemme' con comillas simples si es una cadena de texto


SELECT * FROM productos_por_depositos AS d
INNER JOIN productos AS p ON d.id_producto = p.id_producto

GO

CREATE TRIGGER tr_actualizar_productos_por_deposito
ON detalles_compras_proveedores
AFTER INSERT
AS
BEGIN
    -- Actualizar la cantidad en productos_por_depositos basado en los nuevos detalles de compra
    UPDATE p
    SET p.cantidad = p.cantidad + i.cantidad
    FROM productos_por_depositos p
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN facturas f ON i.id_factura = f.id_factura
    WHERE p.id_deposito = f.id_deposito;
END;


