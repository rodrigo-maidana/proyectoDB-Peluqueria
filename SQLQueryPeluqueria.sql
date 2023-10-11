--tablas
CREATE TABLE tipos_productos
(
	id_tipo_producto INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100)
);

CREATE TABLE marcas
(
	id_marca INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100)
);

CREATE TABLE productos
(
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    id_marca INT,
    id_tipo_producto INT,
    descripcion VARCHAR(50),
    costo_unitario INT,
    porcentaje_iva INT,
    cantidad INT,
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca),
	FOREIGN KEY (id_tipo_producto) REFERENCES tipos_productos(id_tipo_producto)
);


CREATE TABLE cargos
(
	id_cargo INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100)
);

CREATE TABLE funcionarios
(
	id_funcionario INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(250),
	id_cargo INT,
	FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
);

CREATE TABLE depositos
(
	id_deposito INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100)
);

CREATE TABLE transferencias_productos
(
	id_transferencia INT PRIMARY KEY IDENTITY(1,1),
	id_deposito_origen INT,
	id_deposito_destino INT,
	id_funcionario_encargado INT,
	id_funcionario_autorizante INT,
	FOREIGN KEY (id_deposito_origen) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_deposito_destino) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_funcionario_encargado) REFERENCES funcionarios(id_funcionario),
	FOREIGN KEY (id_funcionario_autorizante) REFERENCES funcionarios(id_funcionario),
);
CREATE TABLE detalles_transferencias_productos
(
	id_detalle INT PRIMARY KEY IDENTITY(1,1),
	id_transferencia INT,
	id_producto INT,
	cantidad INT
	FOREIGN KEY (id_transferencia) REFERENCES transferencias_productos(id_transferencia),
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE productos_por_depositos
(
	id_producto_por_deposito INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT,
	id_deposito INT,
	cantidad INT,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	FOREIGN KEY (id_deposito) REFERENCES depositos(id_deposito)
);

CREATE TABLE proveedores 
(
	id_proveedor INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(200),
	direccion VARCHAR(100),
	correo VARCHAR(100),
	credito INT
);

CREATE TABLE ordenes_de_pagos
(
	id_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	fecha DATE,
	forma_de_pago VARCHAR(100)
);

CREATE TABLE facturas
(
	id_factura INT PRIMARY KEY IDENTITY(1,1),
	id_deposito INT,
	id_proveedor INT,
	fecha_compra DATE,
	condicion_compra VARCHAR(100),
	fecha_vencimiento DATE,
	numero_factura INT,
	FOREIGN KEY (id_deposito) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
);

CREATE TABLE detalles_ordenes_de_pagos
(
	id_detalle_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_factura INT,
	id_orden_de_pago INT,
	importe INT,
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	FOREIGN KEY (id_orden_de_pago) REFERENCES ordenes_de_pagos(id_orden_de_pago)
);
SELECT * FROM funcionarios

CREATE TABLE detalles_compras_proveedores
(
	id_detalle_proveedor INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT,
	id_factura INT,
	cantidad INT,
	costo_unitario INT,
	porcentaje_iva INT,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
);
--carga de valores
INSERT INTO marcas (nombre)
VALUES ('Plusbell'),
       ('Pantene'),
       ('Dove'),
       ('TRESemmé');

INSERT INTO tipos_productos (nombre)
VALUES ('Shampoo'),
       ('Acondicionador'),
       ('Productos de Fijación'),
       ('Cuidado Capilar'),
       ('Jabón de Manos');

SELECT
    p.id_producto,
    m.nombre AS marca,
    t.nombre AS tipo_producto,
    p.descripcion,
    p.costo_unitario,
    p.porcentaje_iva,
    p.cantidad
FROM productos p
INNER JOIN marcas m ON p.id_marca = m.id_marca
INNER JOIN tipos_productos t ON p.id_tipo_producto = t.id_tipo_producto;
