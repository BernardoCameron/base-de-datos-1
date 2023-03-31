-- parte 1


select f.FacturaID, f.FechaFactura,c.Compania as "Empresa Correo", cl.Compania as "Cliente", ca.CategoriaNombre as "Categoria", p.ProductoNombre, p.PrecioUnitario, fd.Cantidad  from facturas f
inner join correos c
on c.CorreoID = f.EnvioVia
inner join facturadetalle fd
on fd.FacturaID = f.FacturaID
inner join productos p
on p.ProductoID = fd.ProductoID
inner join categorias ca
on ca.CategoriaID = p.CategoriaID
inner join clientes cl
on cl.ClienteID = f.ClienteID;

-- parte2

select * from correos;
select * from facturadetalle;
select * from facturas;
select * from clientes;
select * from categorias;
select * from productos;

-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.

select cat.CategoriaNombre, p.ProductoNombre, p.ProductoID from categorias cat
left join productos p
on cat.CategoriaID = p.CategoriaID
order by p.ProductoID desc;

-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.

select * from clientes;
select * from facturas;

select c.Contacto, f.ClienteID from clientes c
left join facturas f
on f.ClienteID = c.ClienteID
where f.ClienteID is null;

-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.

select * from productos;
select * from proveedores;

select p.ProductoNombre, cat.CategoriaNombre, prov.Contacto from productos p
inner join categorias cat
on cat.CategoriaID = p.CategoriaID
right join proveedores prov
on prov.ProveedorID = p.ProveedorID;

-- 4. Para cada categoría listar el promedio del precio unitario de sus productos.

select c.CategoriaNombre, avg(p.PrecioUnitario) as "Promedio precio" from categorias as c
join productos p on p.CategoriaID = c.CategoriaID
group by c.CategoriaNombre;

-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.

select c.Contacto, max(f.FechaFactura) as "Ultima factura" from clientes c
join facturas f on f.ClienteID = c.ClienteID
group by c.Contacto;

-- 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.

select c.Compania, count(f.FacturaID) from correos c
right join facturas f on f.EnvioVia = c.CorreoID
group by c.Compania