USE ProyectoPeluqueria
--consultas
--ranking de productos comprados por cantidad
create view ranking_productos as
select
	dcp.id_producto, 
	p.descripcion,
	sum(dcp.cantidad) as comprado
	
from detalles_compras_proveedores dcp
inner join productos p on dcp.id_producto = p.id_producto
group by dcp.id_producto, p.descripcion

select * from ranking_productos order by comprado desc

-- ranking de proveedores por monto que se le compra
create view ranking_proveedores as 
select  
	p.nombre,
	sum(f.total) as monto
from facturas f
inner join proveedores p on p.id_proveedor=f.id_proveedor
group by p.nombre, f.total


select * from facturas

EXEC sumar_detalles_factura @id_factura=4;

select * from ranking_proveedores order by monto desc

-- Monto de importe total de compras realizadas por rango de fecha
-- Vista para el importe total por rango de fecha
CREATE VIEW VistaImporteTotalComprasPorFecha AS
SELECT
    f.fecha_compra,
	f.id_deposito AS CodigoDeposito,
	d.nombre AS Deposito,
    SUM(f.total) AS ImporteTotal
FROM facturas f
INNER JOIN depositos d on f.id_deposito = d.id_deposito
GROUP BY
f.fecha_compra,f.id_deposito,d.nombre;

--consulta
select * from VistaImporteTotalComprasPorFecha 
WHERE fecha_compra BETWEEN '2023-10-01' AND '2023-10-31'
ORDER BY
    fecha_compra;

select * from facturas

--view para productos comprados a proveedores
CREATE VIEW ProductosCompradosAProveedores AS
SELECT
    p.id_proveedor AS IDProveedor,
    p.nombre AS NombreProveedor,
    dc.id_producto AS IDProducto,
    pr.descripcion AS DescripcionProducto,
    MAX(f.fecha_compra) AS UltimaFechaCompra, --ultima fecha de compra
    dc.costo_unitario AS UltimoCostoUnitario --ultimo costo unitario
FROM proveedores p
INNER JOIN facturas f ON p.id_proveedor = f.id_proveedor
INNER JOIN detalles_compras_proveedores dc ON f.id_factura = dc.id_factura
INNER JOIN productos pr ON dc.id_producto = pr.id_producto
GROUP BY
    p.id_proveedor, p.nombre, dc.id_producto, pr.descripcion, dc.costo_unitario;

--consulta
-- Consulta por rango de proveedores y rango de fechas
-- VER SI FUNCIONA, CARGAR MAS DATOS
SELECT * FROM ProductosCompradosAProveedores
WHERE IDProveedor BETWEEN 1 AND 3
  AND UltimaFechaCompra BETWEEN '2023-01-01' AND '2023-12-31';


select dcp.id_factura, p.descripcion, dcp.cantidad,dcp.costo_unitario from detalles_compras_proveedores dcp
inner join productos p on dcp.id_producto = p.id_producto
order by p.descripcion

CREATE VIEW facturas_pendientes_pago AS
SELECT
f.id_factura as IdFactura,
f.fecha_compra as Fecha,
f.id_proveedor as CodigoProveedor,
p.nombre as NombreProveedor,
f.total as Total,
f.saldo_pendiente as Pendiente
FROM facturas f
INNER JOIN proveedores p on f.id_proveedor = p.id_proveedor
WHERE f.saldo_pendiente > 0

select * from facturas_pendientes_pago
select * from facturas