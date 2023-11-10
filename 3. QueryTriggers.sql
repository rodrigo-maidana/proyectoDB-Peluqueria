USE ProyectoPeluqueria

-- Crear el trigger
CREATE TRIGGER tr_insert_actualizar_depositos_al_transferir
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

CREATE TRIGGER tr_delete_actualizar_depositos_al_eliminar_transferencia
ON detalles_transferencias_productos
AFTER DELETE
AS
BEGIN
    -- Restaurar la cantidad en el depósito de origen (sumar la cantidad transferida)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad + d.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN transferencias_productos t ON d.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_origen;

    -- Restaurar la cantidad en el depósito de destino (restar la cantidad transferida)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad - d.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN transferencias_productos t ON d.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_destino;
END;

CREATE TRIGGER tr_update_actualizar_depositos_al_modificar_transferencia
ON detalles_transferencias_productos
AFTER UPDATE
AS
BEGIN
    -- Restaurar la cantidad en el depósito de origen (sumar la cantidad anterior y restar la cantidad modificada)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad + d.cantidad - i.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN transferencias_productos t ON i.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_origen;

    -- Restaurar la cantidad en el depósito de destino (restar la cantidad anterior y sumar la cantidad modificada)
    UPDATE productos_por_depositos
    SET cantidad = p.cantidad - d.cantidad + i.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN transferencias_productos t ON i.id_transferencia = t.id_transferencia
    WHERE p.id_deposito = t.id_deposito_destino;
END;


DROP TRIGGER tr_actualizar_productos_por_deposito

CREATE TRIGGER tr_insert_actualizar_productos_por_deposito
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

	-- Llamada al procedimiento almacenado sumar_detalles_factura para la factura recién insertada
    DECLARE @id_factura INT;
    SELECT @id_factura = id_factura FROM inserted;

    EXEC sumar_detalles_factura @id_factura = @id_factura;
END;

CREATE TRIGGER tr_delete_actualizar_depositos_al_transferir
ON detalles_compras_proveedores
AFTER DELETE
AS
BEGIN
    -- Actualizar la cantidad en productos_por_depositos basado en los detalles de compra eliminados
    UPDATE p
    SET p.cantidad = p.cantidad - d.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN facturas f ON d.id_factura = f.id_factura
    WHERE p.id_deposito = f.id_deposito;

	-- Llamada al procedimiento almacenado restar_detalles_factura para la factura correspondiente a los detalles eliminados
    DECLARE @id_factura INT;
    SELECT @id_factura = id_factura FROM deleted;

    EXEC sumar_detalles_factura @id_factura = @id_factura;
END;

CREATE TRIGGER tr_udpate_actualizar_depositos_al_transferir
ON detalles_compras_proveedores
AFTER UPDATE
AS
BEGIN
    -- Actualizar la cantidad en productos_por_depositos basado en los detalles de compra modificados
    UPDATE p
    SET p.cantidad = p.cantidad - d.cantidad + i.cantidad
    FROM productos_por_depositos p
    INNER JOIN deleted d ON p.id_producto = d.id_producto
    INNER JOIN inserted i ON p.id_producto = i.id_producto
    INNER JOIN facturas f ON i.id_factura = f.id_factura
    WHERE p.id_deposito = f.id_deposito;

    -- Llamada al procedimiento almacenado sumar_detalles_factura para la factura correspondiente a los detalles modificados
    DECLARE @id_factura INT;
    SELECT @id_factura = i.id_factura FROM inserted i;

    EXEC sumar_detalles_factura @id_factura = @id_factura;
END;
