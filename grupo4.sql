-- 1) ¿Cuántos clientes existen?

select count(*) as "Total Clientes"from clientes;


-- 2) ¿Cuántos clientes hay por ciudad?

select ciudad, count(Ciudad) as "Personas por ciudad" from clientes
group by Ciudad;

-- Facturas


-- 1) ¿Cuál es el total de transporte?

select * from facturas;

select sum(Transporte) as "Total transporte" from facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

select EnvioVia as "Tipo envio", sum(Transporte) as "Total envios" from facturas
group by EnvioVia;


-- 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
-- cantidad de facturas.

select * from facturas;

select c.ClienteID, sum(f.FacturaID)  from facturas f, clientes c
group by c.ClienteID;

select c.ClienteID, sum(f.FacturaID) as total_facturas from facturas f
join clientes c
on c.ClienteID = f.ClienteID
group by c.ClienteID
order by total_facturas desc;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

select c.ClienteID, sum(f.FacturaID) as total_facturas from facturas f
join clientes c
on c.ClienteID = f.ClienteID
group by c.ClienteID
order by total_facturas desc
limit 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

select * from facturas;

select count(FacturaID) as total_facturas ,PaisEnvio from facturas
group by PaisEnvio
order by total_facturas asc
limit 1;

-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?

select * from facturadetalle;
select * from factura;
select * from empleados;

select count(f.FacturaID) as cantidad_ventas, e.Nombre as Nombre, e.Apellido as Apellido, sum(fd.PrecioUnitario*fd.Cantidad) as "Total facturado" from facturas f
join empleados e
on e.EmpleadoID = f.EmpleadoID
join facturadetalle fd
on fd.FacturaID = f.FacturaID
group by e.EmpleadoID
order by cantidad_ventas desc;


-- Factura detalle

-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

select * from productos;
select * from facturadetalle;

select p.productonombre, count(fd.ProductoID) as "Volumen ventas" from facturadetalle fd
join productos p
on fd.ProductoID = p.ProductoID
group by fd.ProductoID
order by count(fd.ProductoID) desc;


 -- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.

select sum(PrecioUnitario*Cantidad) as "Total Facturado" from facturadetalle;

-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

select * from facturadetalle;

select sum(PrecioUnitario*Cantidad) as "Total Facturado" from facturadetalle
where ProductoID between 30 and 50;

-- 4) ¿Cuál es el precio unitario promedio de cada producto?

select  ProductoID ,avg(PrecioUnitario) as "precio unitario promedio"from facturadetalle
group by ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?

select  max(PrecioUnitario) as "precio unitario maximo" from facturadetalle