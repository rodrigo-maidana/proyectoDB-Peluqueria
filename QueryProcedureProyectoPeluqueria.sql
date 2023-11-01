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

select * from detalles_compras_proveedores where id_factura = (select id_factura from facturas where numero_factura=1010)
EXEC ActualizarTotalFactura @numero_factura = 1010;

select * from facturas where numero_factura=1010