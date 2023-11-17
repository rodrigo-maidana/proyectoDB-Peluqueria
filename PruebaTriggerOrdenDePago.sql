--query de prueba
use ProyectoPeluqueria
select * from facturas
select * from facturas where numero_factura = 1011
--factura numero 1011 tiene 153.000 de saldo pendiente
insert into ordenes_de_pagos (id_proveedor, fecha, monto_total) 
values (3,'2023-11-17',0);

select * from ordenes_de_pagos
select * from detalles_ordenes_de_pagos
insert into detalles_ordenes_de_pagos (id_factura,id_orden_de_pago,importe)
values ((select id_factura from facturas where numero_factura=1011),2,100000)

--probar actualizar
UPDATE detalles_ordenes_de_pagos
SET importe = 90000
WHERE id_detalle_orden_de_pago = 8;

insert into detalles_ordenes_de_pagos (id_factura,id_orden_de_pago,importe)
values ((select id_factura from facturas where numero_factura=1011),2,23000)


