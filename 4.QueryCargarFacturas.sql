USE ProyectoPeluqueria

select * from facturas

--FACTURA NRO 1010.
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		(GETDATE()),
		0,
		(GETDATE()),
		1010,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1010),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1010),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo TRESemme'),
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1010),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0);

--FACTURA NRO 1011.
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		(GETDATE()),
		1,
		(GETDATE()),
		1011,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1011),
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Plusbelle'),
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='gel Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1011),
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='gel Plusbelle'),
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Gel Tresemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1011),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Tresemme'),
		0);

--FACTURA NRO 1010.
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		(GETDATE()),
		0,
		(GETDATE()),
		1012,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Tresemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1012),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Tresemme'),
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='tinte Tresemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1012),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='tinte Tresemme'),
		0);

--facturas mes diciembre
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Salón'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-12-01',
		1,
		'2024-12-01',
		1014,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='gel Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1014),
		1,
		35000,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1014),
		4,
		26500,
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-12-02',
		0,
		'2024-12-01',
		1015,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Gel TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1015),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel TRESemme'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Tinte TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1015),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte TRESemme'),
		0);

--facturas mes octubre
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-10-01',
		0,
		'2024-12-01',
		1009,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Gel Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1009),
		16,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Plusbelle'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1009),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Plusbelle'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-10-02',
		1,
		'2024-12-01',
		1008,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1008),
		9,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1008),
		21,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		0);

--facturas mes septiembre
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-09-02',
		1,
		'2024-12-01',
		1007,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1007),
		13,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Tinte TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1007),
		14,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte TRESemme'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-09-03',
		0,
		'2023-09-03',
		1006,
		0,
		0,
		0);

INSERT INTO detalles_compras_proveedores
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1006),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Plusbelle'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1006),
		50,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador TRESemme'),
		0);

select * from facturas
select * from detalles_compras_proveedores