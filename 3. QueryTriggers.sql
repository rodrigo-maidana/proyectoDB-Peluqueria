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



-- trigger detalles_ordenes_de_pago
--restar el importe al saldo de la factura
CREATE TRIGGER tr_actualizar_saldo_pendiente
ON detalles_ordenes_de_pagos
AFTER INSERT
AS
BEGIN
    -- Actualizar saldo_pendiente en la factura
    UPDATE facturas
	--si la factura es a credito
    SET saldo_pendiente = CASE 
                            WHEN f.condicion_compra = 1 
                            THEN f.saldo_pendiente - i.importe
                            ELSE f.saldo_pendiente
                          END
    FROM facturas f
    JOIN inserted i ON f.id_factura = i.id_factura;
	UPDATE o
    SET monto_total = ISNULL((SELECT SUM(importe) FROM detalles_ordenes_de_pagos WHERE id_orden_de_pago = o.id_orden_de_pago), 0)
    FROM ordenes_de_pagos o
    JOIN inserted i ON o.id_orden_de_pago = i.id_orden_de_pago;
END;
--actualizar detalles_ordenes_de_pago
-- Crear un trigger después de actualizar en detalles_ordenes_de_pagos
CREATE TRIGGER tr_actualizar_saldo_pendiente_al_editar
ON detalles_ordenes_de_pagos
AFTER UPDATE
AS
BEGIN
    -- Actualizar importe en la tabla detalles_ordenes_de_pagos
    UPDATE dop
    SET importe = i.importe
    FROM detalles_ordenes_de_pagos dop
    JOIN inserted i ON dop.id_detalle_orden_de_pago = i.id_detalle_orden_de_pago;

    -- Actualizar saldo_pendiente en la tabla facturas
    UPDATE f
	--resta el total de la factura con la suma de todos los importes de ordenes de pago
	-- si no hay detalles ordenes de pago isnull retorna 0
    SET saldo_pendiente = f.total - ISNULL((SELECT SUM(importe) FROM detalles_ordenes_de_pagos WHERE id_factura = f.id_factura), 0)
    FROM facturas f
    JOIN detalles_ordenes_de_pagos dop ON f.id_factura = dop.id_factura;
	UPDATE o
    SET monto_total = ISNULL((SELECT SUM(importe) FROM detalles_ordenes_de_pagos WHERE id_orden_de_pago = o.id_orden_de_pago), 0)
    FROM ordenes_de_pagos o
    JOIN inserted i ON o.id_orden_de_pago = i.id_orden_de_pago;
END;
