USE ProyectoPeluqueria

SELECT p.id_producto, p.descripcion, dep.id_deposito, dep.cantidad FROM productos_por_depositos as dep
INNER JOIN productos as p ON dep.id_producto = p.id_producto
WHERE dep.id_producto = 1

INSERT INTO transferencias_productos (id_deposito_origen, id_deposito_destino, id_funcionario_encargado, id_funcionario_autorizante, fecha)
VALUES
    (1, 2, 1, 2, (GETDATE()));

INSERT INTO detalles_transferencias_productos (id_transferencia, id_producto, cantidad)
VALUES
    (1, 1, 2);

SELECT * FROM transferencias_productos
SELECT * FROM detalles_transferencias_productos

DELETE FROM transferencias_productos
DELETE FROM detalles_transferencias_productos