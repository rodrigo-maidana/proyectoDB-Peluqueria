USE ProyectoPeluqueria
select * from facturas
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
exec sumar_detalles_factura @id_factura=6
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
exec sumar_detalles_factura @id_factura=7
select * from facturas
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
exec sumar_detalles_factura @id_factura=8
select * from facturas
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
exec sumar_detalles_factura @id_factura=9
select * from facturas
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
exec sumar_detalles_factura @id_factura=10
select * from facturas
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
exec sumar_detalles_factura @id_factura=11
select * from facturas