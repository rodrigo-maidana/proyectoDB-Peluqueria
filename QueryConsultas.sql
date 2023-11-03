--consultas
--ranking de productos comprados por cantidad
create view ranking_productos as
select
	dcp.id_producto, 
	p.descripcion,
	sum(dcp.cantidad) as comprado
	
from detalles_compras_proveedores dcp
inner join productos p on dcp.id_producto = p.id_producto
group by dcp.id_producto, p.descripcion

select * from ranking_productos order by comprado desc

-- ranking de proveedores por monto que se le compra

create view ranking_proveedores as 
select  
	p.nombre,
	sum(f.total) as monto
from facturas f
inner join proveedores p on p.id_proveedor=f.id_proveedor
group by p.nombre, f.total

select * from facturas
EXEC sumar_detalles_factura @id_factura=4;

select * from ranking_proveedores order by monto desc