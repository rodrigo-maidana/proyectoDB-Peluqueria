
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

select ppd.id_productos_por_depositos as id, p.descripcion as producto, d.nombre as deposito, ppd.cantidad
from productos_por_depositos ppd 
inner join productos p on ppd.id_producto = p.id_producto
inner join depositos d on ppd.id_deposito = d.id_deposito
order by producto

insert into transferencias_productos(id_deposito_origen, id_deposito_destino, id_funcionario_encargado, id_funcionario_autorizante,fecha)
values( (select id_deposito from depositos where nombre='Depósito'),(select id_deposito from depositos where nombre='Salón'),
(select id_funcionario from funcionarios where nombre='jorge figueredo'),
(select id_funcionario from funcionarios where nombre='rodrigo maidana'),
getdate())

DELETE FROM transferencias_productos
WHERE id_transferencia = 1; 

SELECT
    tp.id_transferencia,
    o.nombre AS deposito_origen,
    d.nombre AS deposito_destino,
    fe.nombre AS encargado_encargado,
    fa.nombre AS encargado_autorizante,
    tp.fecha
FROM transferencias_productos tp
INNER JOIN depositos o ON tp.id_deposito_origen = o.id_deposito
INNER JOIN depositos d ON tp.id_deposito_destino = d.id_deposito
INNER JOIN funcionarios fe ON tp.id_funcionario_encargado = fe.id_funcionario
INNER JOIN funcionarios fa ON tp.id_funcionario_autorizante = fa.id_funcionario;

insert into detalles_transferencias_productos(id_transferencia, id_producto ,cantidad) values(
2, (select id_producto from productos where descripcion ='acondicionador nivea'),5)