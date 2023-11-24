USE ProyectoPeluqueria

-- Consulta #1.
--Monto de importe total de compras realizadas por rango de fecha
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

--Consulta #1
select * from VistaImporteTotalComprasPorFecha 
WHERE fecha_compra BETWEEN '2023-10-01' AND '2023-10-31'
ORDER BY
    fecha_compra;

-- Consulta #2.
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

--Consulta #2
SELECT * FROM ProductosCompradosAProveedores
WHERE IDProveedor BETWEEN 1 AND 3
  AND UltimaFechaCompra BETWEEN '2023-01-01' AND '2023-12-31';

-- Consulta #3.
CREATE VIEW vw_productos_comprados
AS
SELECT p.id_producto, p.descripcion as nombre_producto, prov.id_proveedor, prov.nombre as nombre_proveedor
FROM detalles_compras_proveedores AS d
INNER JOIN productos AS p
ON d.id_producto = p.id_producto
INNER JOIN facturas AS f
ON f.id_factura = d.id_factura
INNER JOIN proveedores AS prov
ON f.id_proveedor = prov.id_proveedor

-- Consulta #3.
select * from vw_productos_comprados
WHERE id_proveedor BETWEEN 1 AND 3
order by nombre_producto

-- Consulta #4.
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

-- Consulta #4.
select * from facturas_pendientes_pago

-- Consulta #5.
--ranking de productos comprados por cantidad
create view ranking_productos as
select
	dcp.id_producto, 
	p.descripcion,
	sum(dcp.cantidad) as comprado
	
from detalles_compras_proveedores dcp
inner join productos p on dcp.id_producto = p.id_producto
group by dcp.id_producto, p.descripcion

-- Consulta #5.
select * from ranking_productos order by comprado desc

-- Consulta #6.
-- ranking de proveedores por monto que se le compra
create view ranking_proveedores as 
select  
	p.nombre,
	sum(f.total) as monto
from facturas f
inner join proveedores p on p.id_proveedor=f.id_proveedor
group by p.nombre, f.total

-- Consulta #6.
select * from ranking_proveedores order by monto desc

-- Consulta #7.
-- Productos no comprados.
DROP VIEW productos_no_comprados_por_fecha
CREATE VIEW productos_no_comprados_por_fecha AS
SELECT
    p.id_producto,
    p.descripcion as nombre_producto,
    p.costo_unitario as ultimo_precio,
    MAX(f.fecha_compra) AS ultima_fecha_compra
FROM
    productos p
LEFT JOIN
    detalles_compras_proveedores dcp ON p.id_producto = dcp.id_producto
LEFT JOIN
    facturas f ON dcp.id_factura = f.id_factura
WHERE
    dcp.id_producto IS NULL
    OR (dcp.id_producto IS NOT NULL AND f.fecha_compra IS NULL)
GROUP BY
    p.id_producto, p.descripcion, p.costo_unitario;


-- Consulta #7.
-- Selecciona todos los productos no comprados en un rango de fechas específico
SELECT *
FROM productos_no_comprados_por_fecha
WHERE ultima_fecha_compra IS NULL OR ultima_fecha_compra BETWEEN '2023-12-02' AND '2023-12-30';


--productos comprados por fecha
select p.id_producto, p.descripcion, f.fecha_compra from detalles_compras_proveedores as dcp
INNER JOIN facturas as f ON f.id_deposito = dcp.id_factura
INNER JOIN productos as p ON p.id_producto = dcp.id_producto
ORDER BY fecha_compra