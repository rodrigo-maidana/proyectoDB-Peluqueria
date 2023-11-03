USE ProyectoPeluqueria

-- Crear un procedimiento almacenado para calcular y actualizar el total de una factura
-- Crear un procedimiento almacenado para calcular y actualizar el total de una factura por número de factura
CREATE PROCEDURE ActualizarTotalFactura(@numero_factura INT)
AS
BEGIN
    DECLARE @total INT;
    
    SELECT @total = SUM(dc.cantidad * p.costo_unitario)
    FROM detalles_compras_proveedores dc
    JOIN facturas f ON dc.id_factura = f.id_factura
    JOIN productos p ON dc.id_producto = p.id_producto
    WHERE f.numero_factura = @numero_factura;
    
    UPDATE facturas
    SET total = @total
    WHERE numero_factura = @numero_factura;
END;

select dc.id_detalle_compra_proveedor, p.descripcion as producto,f.numero_factura, dc.cantidad, dc.costo_unitario 
from detalles_compras_proveedores dc 
inner join productos p on dc.id_producto=p.id_producto
inner join facturas f on dc.id_factura=f.id_factura
where dc.id_factura = (select id_factura from facturas where numero_factura=1010)

EXEC ActualizarTotalFactura @numero_factura = 1010;

select d.nombre, p.nombre, f.fecha_compra, f.fecha_vencimiento, f.numero_factura, f.total 
from facturas f 
inner join proveedores p on f.id_proveedor = p.id_proveedor
inner join depositos d on f.id_deposito = d.id_deposito
where numero_factura=1010
