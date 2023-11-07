USE ProyectoPeluqueria
-- Crear el trigger
CREATE TRIGGER tr_actualizar_depositos_al_transferir
ON detalles_transferencias_productos
AFTER INSERT
AS
BEGIN
    -- Actualizar la cantidad en el depósito de origen (restar la cantidad transferida)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad - i.cantidad
    FROM productos_por_depositos p
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN transferencias_productos t ON i.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_origen;

    -- Actualizar la cantidad en el depósito de destino (sumar la cantidad transferida)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad + i.cantidad
    FROM productos_por_depositos p
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN transferencias_productos t ON i.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_destino;
END;

CREATE TRIGGER tr_actualizar_productos_por_deposito
ON detalles_compras_proveedores
AFTER INSERT
AS
BEGIN
    -- Actualizar la cantidad en productos_por_depositos basado en los nuevos detalles de compra
    UPDATE p
    SET p.cantidad = p.cantidad + i.cantidad
    FROM productos_por_depositos p
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN facturas f ON i.id_factura = f.id_factura
    WHERE p.id_deposito = f.id_deposito;
END;

