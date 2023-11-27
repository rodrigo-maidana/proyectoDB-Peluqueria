USE ProyectoPeluqueria
-- Crear un procedimiento almacenado para calcular y actualizar el total de una factura
CREATE PROCEDURE sumar_detalles_factura
    @id_factura INT
AS
BEGIN
    DECLARE @Total INT
    DECLARE @TotalIVA INT
    DECLARE @CondicionCompra BIT

    -- Obtener la condición de compra
    SELECT @CondicionCompra = condicion_compra FROM facturas
    WHERE id_factura = @id_factura

    -- Calcular el total y el total del IVA para la factura
    SELECT @Total = SUM(cantidad * costo_unitario),
           @TotalIVA = SUM(iva)
    FROM detalles_compras_proveedores
    WHERE id_factura = @id_factura

    -- Actualizar los campos total, total_iva y saldo_pendiente en la tabla facturas
    UPDATE facturas
    SET total = @Total, 
	total_iva = @TotalIVA,
        saldo_pendiente = CASE
            WHEN @CondicionCompra = 1 THEN @Total
            ELSE 0
        END
    WHERE id_factura = @id_factura
END;

select * from facturas
exec sumar_detalles_factura @id_factura=2

CREATE PROCEDURE act_costo_unitario 
 @id_producto INT,
 @costoActualizado INT
AS
BEGIN 
--actualizar en la tabla productos
UPDATE productos
SET costo_unitario = @costoActualizado WHERE id_producto = @id_producto
END