USE ProyectoPeluqueria

select * from facturas
select * from detalles_compras_proveedores
--de enero a marzo no voy a comprar peine revlon, decolorante dove y gel tresemme
--facturas mes enero
INSERT INTO facturas 
values((SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
	(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
	'2023-01-01',
	0,
	'2023-01-01',
	0101,
	0,
	0,
	0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0101),
		5,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Tinte TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0101),
		6,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte TRESemme'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-01-02',
		1,
		'2023-12-01',
		0102,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0102),
		5,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Plusbelle'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0102),
		6,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-01-03',
		0,
		'2023-01-03',
		0103,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0103),
		4,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0103),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Nivea'),
		0);
--facturas mes febrero
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-02-01',
		0,
		'2023-02-01',
		0104,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0104),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Gel Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0104),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Nivea'),
		0);


INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-02-02',
		1,
		'2023-12-31',
		0105,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0105),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo TRESemme'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0105),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador TRESemme'),
		0);


INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-02-03',
		1,
		'2023-12-31',
		0106,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0106),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte TRESemme'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0106),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Plusbelle'),
		0);



--facturas mes marzo
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-03-01',
		1,
		'2023-12-31',
		0107,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0107),
		8,
		25500,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0107),
		12,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Plusbelle'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-03-02',
		1,
		'2023-12-31',
		0108,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Dove'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0108),
		5,
		36000,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Dove'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0108),
		7,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Dove'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Salón'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-03-03',
		1,
		'2023-12-31',
		0109,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Gel Revlon'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0109),
		5,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Revlon'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0109),
		3,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo TRESemme'),
		0);


select * from facturas
--facturas mes abril
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-04-01',
		1,
		'2024-12-01',
		0110,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0110),
		10,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0110),
		9,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Nivea'),
		0);
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-04-02',
		0,
		'2023-04-02',
		0111,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0111),
		8,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Gel Nivea'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0111),
		7,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Nivea'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-04-03',
		0,
		'2023-04-03',
		0112,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0112),
		5,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo TRESemme'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0112),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador TRESemme'),
		0);
select * from facturas
--facturas mes mayo
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-05-01',
		0,
		'2023-05-01',
		0113,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0113),
		5,
		(SELECT costo_unitario FROM productos WHERE descripcion='Tinte TRESemme'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Gel TRESemme'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0113),
		2,
		36000,
		0);
--facturas mes junio
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-06-01',
		1,
		'2024-06-01',
		0114,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0114),
		5,
		28000,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0114),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		0);
--facturas mes julio
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-07-01',
		0,
		'2023-07-01',
		0115,
		0,
		0,
		0);

select * from facturas where numero_factura='0115'
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Tinte Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0115),
		5,
		47000,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Gel Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0115),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Plusbelle'),
		0);
--facturas mes agosto
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,
fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-08-03',
		0,
		'2023-08-03',
		0116,
		0,
		0,
		0);
INSERT INTO detalles_compras_proveedores (id_producto, id_factura, cantidad, costo_unitario, iva)
VALUES (
		(SELECT id_producto FROM productos WHERE descripcion='Shampoo Dove'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0116),
		5,
		36500,
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Dove'),
		(SELECT id_factura FROM facturas WHERE numero_factura=0116),
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Dove'),
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
		2,
		(SELECT costo_unitario FROM productos WHERE descripcion='Shampoo Nivea'),
		0),(
		(SELECT id_producto FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		(SELECT id_factura FROM facturas WHERE numero_factura=1008),
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='Acondicionador Plusbelle'),
		0);
--factura mes noviembre
INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Margarita SA'),
		'2023-11-01',
		0,
		'2023-11-01',
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

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='San Cosme'),
		'2023-11-02',
		1,
		'2023-12-31',
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
		1,
		(SELECT costo_unitario FROM productos WHERE descripcion='Gel Tresemme'),
		0);

INSERT INTO facturas (id_deposito,id_proveedor,fecha_compra,condicion_compra,fecha_vencimiento,numero_factura,total,saldo_pendiente, total_iva)
VALUES(
		(SELECT id_deposito FROM depositos WHERE nombre='Depósito'),
		(SELECT id_proveedor FROM proveedores WHERE nombre='Estética del Sur'),
		'2023-11-03',
		0,
		'2023-11-03',
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
		'2024-12-02',
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

select * from facturas