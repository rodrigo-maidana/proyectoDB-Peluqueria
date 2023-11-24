USE ProyectoPeluqueria

CREATE TRIGGER tr_control_transferencias_negativas
ON detalles_transferencias_productos
INSTEAD OF INSERT
AS
BEGIN
    -- Verificar si la cantidad a transferir excede la cantidad disponible en el depósito de origen
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN productos_por_depositos pd ON i.id_producto = pd.id_producto
        INNER JOIN transferencias_productos tp ON i.id_transferencia = tp.id_transferencia
        WHERE i.cantidad > pd.cantidad
          AND tp.id_deposito_origen = pd.id_deposito
    )
    BEGIN
        PRINT 'La cantidad a transferir excede la cantidad disponible en el depósito de origen.';
        ROLLBACK;
    END
    ELSE
    BEGIN
        -- Si la validación es exitosa, realizar la inserción
        INSERT INTO detalles_transferencias_productos (id_transferencia, id_producto, cantidad)
        SELECT id_transferencia, id_producto, cantidad
        FROM inserted;
    END
END;




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
-- Trigger al eliminar en detalles_ordenes_de_pagos
CREATE TRIGGER tr_eliminar_detalle_orden_de_pago
ON detalles_ordenes_de_pagos
AFTER DELETE
AS
BEGIN
    -- Declarar variables para almacenar el id_factura y el importe eliminado
    DECLARE @id_factura INT, @importe_eliminar INT;

    -- Obtener el id_factura y el importe eliminado
    SELECT @id_factura = id_factura, @importe_eliminar = importe
    FROM deleted;

    -- Se actualiza ordenes de pago en el atributo monto_total
    UPDATE ordenes_de_pagos
    SET monto_total = monto_total - @importe_eliminar
    WHERE id_orden_de_pago = (SELECT id_orden_de_pago FROM deleted);

    -- Se actualiza el saldo pendiente en factura
    UPDATE facturas
    SET saldo_pendiente = saldo_pendiente + @importe_eliminar
    WHERE id_factura = @id_factura;
END;

CREATE TRIGGER tr_insertar_detalle_compra
ON detalles_compras_proveedores
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @id_factura INT
    DECLARE @credito_proveedor INT
    -- Iniciar la transacción
    BEGIN TRANSACTION;
    -- Obtener el id_factura recién insertado
    SELECT @id_factura = id_factura FROM INSERTED;

    -- Ejecutar el procedimiento almacenado para actualizar la factura
    EXEC sumar_detalles_factura @id_factura = @id_factura;

    -- Calcular la diferencia entre el total de la factura y el crédito del proveedor
    SELECT @credito_proveedor = p.credito - f.total FROM proveedores p
    INNER JOIN facturas f ON p.id_proveedor = f.id_proveedor
    WHERE f.id_factura = @id_factura;

    -- Verificar si el crédito se vuelve negativo
    IF @credito_proveedor >= 0
    BEGIN
        -- Actualizar el crédito del proveedor
        UPDATE proveedores
        SET credito = @credito_proveedor
        WHERE id_proveedor = (SELECT id_proveedor FROM facturas WHERE id_factura = @id_factura);

        -- Confirmar la transacción
        COMMIT;
    END

    ELSE
    BEGIN
        -- Si el crédito se vuelve negativo, deshacer la transacción
        ROLLBACK;
        -- Lanzar un mensaje de advertencia
         PRINT 'El total de la factura supera el crédito disponible del proveedor. El detalle compra proveedor no se ha guardado.'
    END;
END;


CREATE TRIGGER tr_actualizar_detalle_compra
ON detalles_compras_proveedores
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @id_factura INT
    DECLARE @credito_proveedor_anterior INT
    DECLARE @credito_proveedor_nuevo INT

    -- Obtener el id_factura y el monto anterior
    SELECT @id_factura = id_factura, @credito_proveedor_anterior = cantidad * costo_unitario
    FROM DELETED;

    -- Sumar el monto anterior al crédito del proveedor
    UPDATE proveedores
    SET credito = credito + @credito_proveedor_anterior
    WHERE id_proveedor = (SELECT id_proveedor FROM facturas WHERE id_factura = @id_factura);

    -- Obtener el nuevo monto
    SELECT @credito_proveedor_nuevo = cantidad * costo_unitario FROM INSERTED;

    -- Restar el nuevo monto al crédito del proveedor
    UPDATE proveedores
    SET credito = credito - @credito_proveedor_nuevo
    WHERE id_proveedor = (SELECT id_proveedor FROM facturas WHERE id_factura = @id_factura);

    -- Restar el nuevo monto al total de la factura
    UPDATE facturas
    SET total = total - @credito_proveedor_nuevo,
        saldo_pendiente = CASE
                            WHEN condicion_compra = 1 THEN total - @credito_proveedor_nuevo
                            ELSE 0
                         END
    WHERE id_factura = @id_factura;
END;