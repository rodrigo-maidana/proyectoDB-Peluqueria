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
	id_deposito_origen INT NOT NULL,
	id_deposito_destino INT NOT NULL,
	id_funcionario_encargado INT NOT NULL,
	id_funcionario_autorizante INT NOT NULL,
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
	condicion_compra BIT NOT NULL,  -- 0 es contado, 1 credito
	fecha_vencimiento DATE NOT NULL,
	numero_factura INT NOT NULL,
	total INT NOT NULL,
	saldo_pendiente INT NOT NULL,
	total_iva INT NOT NULL,
	FOREIGN KEY (id_deposito) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalles_compras_proveedores(
	id_detalle_compra_proveedor INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT NOT NULL,
	id_factura INT NOT NULL,
	cantidad INT NOT NULL,
	costo_unitario INT NOT NULL,
	iva INT NOT NULL,
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
	id_orden_de_pago INT,
	importe INT NOT NULL,
	FOREIGN KEY (id_metodo_pago) REFERENCES metodos_de_pago(id_metodo_pago)
)
--Carga de datos
INSERT INTO tipos_productos (nombre)
VALUES ('Shampoo'),
       ('Acondicionador'),
       ('Tinte'),
       ('Gel'),
	   ('Aerosol para el cabello'),
	   ('Decolorante'),
	   ('Peine');

INSERT INTO marcas (nombre)
VALUES ('Nivea'),
       ('Plusbelle'),
       ('TRESemme'),
	   ('Dove'),
	   ('Revlon');

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

-- Insertar productos para Dove
INSERT INTO productos values(
(SELECT id_marca FROM marcas WHERE nombre = 'Dove'),(SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Shampoo'), 'Shampoo Dove', 35000,10),
((SELECT id_marca FROM marcas WHERE nombre = 'Dove'),(SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Acondicionador'), 'Acondicionador Dove',25000,5),
((SELECT id_marca FROM marcas WHERE nombre = 'Dove'),(SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Decolorante'), 'Decolorante Dove',27000,5)

-- Insertar productos para Revlon
INSERT INTO productos values
((SELECT id_marca FROM marcas WHERE nombre = 'Revlon'),(SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Gel'), 'Gel Revlon',10000,6),
((SELECT id_marca FROM marcas WHERE nombre = 'Revlon'),(SELECT id_tipo_producto FROM tipos_productos WHERE nombre = 'Peine'),'Peine Revlon', 7500, 8)

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
	(12, 1, FLOOR(RAND() * 5) + 1),
	(13, 1, FLOOR(RAND() * 5) + 1),
	(14, 1, FLOOR(RAND() * 5) + 1),
	(15, 1, FLOOR(RAND() * 5) + 1),
	(16, 1, FLOOR(RAND() * 5) + 1),
	(17, 1, FLOOR(RAND() * 5) + 1);
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
    (12, 2, FLOOR(RAND() * 6) + 15),
	(13, 2, FLOOR(RAND() * 6) + 15),
	(14, 2, FLOOR(RAND() * 6) + 15),
	(15, 2, FLOOR(RAND() * 6) + 15),
	(16, 2, FLOOR(RAND() * 6) + 15),
	(17, 2, FLOOR(RAND() * 6) + 15);

-- Insertar proveedores
INSERT INTO proveedores (nombre, direccion, correo, credito)
VALUES
    ('Estética del Sur', 'Encarnación', 'esteticadelsur@gmail.com', 8000000),
    ('Margarita SA', 'Ciudad del Este', 'margarita.sa@gmail.com', 4000000),
    ('San Cosme', 'Asunción', 'sancosme@gmail.com', 12000000);

--Ver todas las tablas
SELECT * FROM sys.tables;

--Ver opciones de algo
exec sp_columns detalles_compras_proveedores;

select * from productos

EXEC sumar_detalles_factura @id_factura = 3;
