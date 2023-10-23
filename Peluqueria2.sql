CREATE TABLE tipos_productos
(
	id_tipo_producto INT PRIMARY KEY IDENTITY(1,1),
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
CREATE TABLE marcas(
	id_marca INT PRIMARY KEY IDENTITY(1,1),
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
CREATE TABLE proveedores(
	id_proveedor INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(200) NOT NULL,
	direccion VARCHAR(100),
	correo VARCHAR(100),
	credito INT
);
CREATE TABLE ordenes_de_pagos(
	id_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_proveedor INT,
	fecha DATE NOT NULL,
	monto_total INT NOT NULL
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE metodos_de_pago(
	id_metodo_pago INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE facturas (
	id_factura INT PRIMARY KEY IDENTITY(1,1),
	id_deposito INT,
	id_proveedor INT,
	fecha_compra DATE NOT NULL,
	condicion_compra BIT NOT NULL,
	fecha_vencimiento DATE NOT NULL,
	numero_factura INT NOT NULL,
	FOREIGN KEY (id_deposito) REFERENCES depositos(id_deposito),
	FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalles_compras_proveedores(
	id_detalle_compra_proveedor INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT,
	id_factura INT,
	cantidad INT NOT NULL,
	costo_unitario INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
);
CREATE TABLE detalles_ordenes_de_pagos(
	id_detalle_orden_de_pago INT PRIMARY KEY IDENTITY(1,1),
	id_factura INT,
	id_orden_de_pago INT,
	id_metodo_de_pago INT,
	importe INT NOT NULL,
	FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	FOREIGN KEY (id_orden_de_pago) REFERENCES ordenes_de_pagos(id_orden_de_pago),
	FOREIGN KEY (id_metodo_de_pago) REFERENCES metodos_de_pago(id_metodo_pago)

);
--cargar datos