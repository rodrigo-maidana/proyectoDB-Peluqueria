USE ProyectoPeluqueria

-- Crear un procedimiento almacenado para calcular y actualizar el total de una factura
-- Crear un procedimiento almacenado para calcular y actualizar el total de una factura por número de factura
-- Crear el procedimiento almacenado
CREATE PROCEDURE sumar_detalles_factura
    @id_factura INT
AS
BEGIN
    DECLARE @Total INT
    DECLARE @TotalIVA INT

    -- Calcular el total y el total del IVA para la factura
    SELECT @Total = SUM(cantidad * costo_unitario),
           @TotalIVA = SUM(iva)
    FROM detalles_compras_proveedores
    WHERE id_factura = @id_factura

    -- Actualizar los campos total y total_iva en la tabla facturas
    UPDATE facturas
    SET total = @Total, total_iva = @TotalIVA
    WHERE id_factura = @id_factura
END;
