-- Queremos tener un listado de todas las categorías.

-- select CategoriaNombre from categorias

-- Cómo las categorías no tienen imágenes, solamente interesa obtener un
-- listado de CategoriaNombre y Descripcion.

-- select CategoriaNombre, Descripcion from categorias

-- Obtener un listado de los productos.

-- select ProductoNombre from productos

-- 4. ¿Existen productos discontinuados? (Discontinuado = 1).

-- select ProductoNombre from productos
-- where Discontinuado = 1

-- 5. Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son
-- los que nos provee?

-- select ProveedorID, ProductoNombre from productos 
-- where ProveedorID = 8

-- 6. Queremos conocer todos los productos cuyo precio unitario se encuentre
-- entre 10 y 22.

-- select ProductoID, ProductoNombre, PrecioUnitario from productos
-- where PrecioUnitario >= 9 and PrecioUnitario <= 22

-- 7. Se define que un producto hay que solicitarlo al proveedor si sus unidades
-- en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?

-- select ProductoNombre, UnidadesStock, NivelReorden from productos
-- where UnidadesStock < NivelReorden

-- 8. Se quiere conocer todos los productos del listado anterior, pero que
-- unidades pedidas sea igual a cero.

-- select ProductoNombre, UnidadesStock, NivelReorden, UnidadesPedidas from productos
-- where UnidadesStock < NivelReorden and UnidadesPedidas = 0

-- Clientes

-- 1. Obtener un listado de todos los clientes con Contacto, Compania, Título,
-- País. Ordenar el listado por País.

-- select Contacto, Compania, Titulo, Pais from clientes
-- order by pais

-- 2. Queremos conocer a todos los clientes que tengan un título “Owner”.

-- select Compania, Titulo from clientes
-- where Titulo = "Owner"

-- 3. El operador telefónico que atendió a un cliente no recuerda su nombre.
-- Solo sabe que comienza con “C”. ¿Lo ayudamos a obtener un listado con
-- todos los contactos que inician con la letra “C”?

select Compania, contacto, Telefono from clientes
where contacto like "C%";

-- Facturas

-- 1. Obtener un listado de todas las facturas, ordenado por fecha de factura
-- ascendente.

select facturaID, ClienteID, FechaFactura from facturas
order by FechaFactura asc;

-- 2. Ahora se requiere un listado de las facturas con el país de envío “USA” y
-- que su correo (EnvioVia) sea distinto de 3.

select FacturaID, ClienteID, PaisEnvio ,EnvioVia from facturas
where PaisEnvio = "USA" and EnvioVia != 3;

-- 3. ¿El cliente 'GOURL' realizó algún pedido?

select ClienteID, FacturaID, FechaFactura from facturas
where ClienteID = "GOURL";

-- 4. Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.

select EmpleadoID, FacturaID from facturas
where EmpleadoID in (2,3,5,8,9);

-- Consultas queries ML - Parte II
-- En esta segunda parte vamos a intensificar la práctica de consultas
-- SELECT, añadiendo ALIAS, LIMIT y OFFSET.

-- Productos

-- 1. Obtener el listado de todos los productos ordenados
-- descendentemente por precio unitario.

select ProductoNombre, PrecioUnitario from productos
order by PrecioUnitario desc;

-- 2. Obtener el listado de top 5 de productos cuyo precio unitario es
-- el más caro.

select ProductoNombre, PrecioUnitario from productos
order by PrecioUnitario desc
limit 5;

-- 3. Obtener un top 10 de los productos con más unidades en stock.

select ProductoNombre, UnidadesStock from productos
order by UnidadesStock desc
limit 10;

-- FacturaDetalle

-- 1. Obtener un listado de FacturaID, Producto, Cantidad.

select FacturaID, ProductoID, Cantidad from facturadetalle;

-- 2. Ordenar el listado anterior por cantidad descendentemente.

select FacturaID, ProductoID, Cantidad from facturadetalle
order by Cantidad desc;

-- 3. Filtrar el listado solo para aquellos productos donde la cantidad
-- se encuentre entre 50 y 100.

select FacturaID, ProductoID, Cantidad from facturadetalle
where Cantidad between 50 and 100
order by Cantidad desc;

-- 4. En otro listado nuevo, obtener un listado con los siguientes
-- nombres de columnas: NroFactura (FacturaID), Producto
-- (ProductoID), Total (PrecioUnitario*Cantidad).

select FacturaID as NroFactura, ProductoID as Producto, PrecioUnitario * Cantidad as Total
from facturadetalle;

-- ¡Extras!

-- ¿Te sobró tiempo? ¿Querés seguir practicando?
-- Te dejamos unos ejercicios extras a partir de la misma base:

-- 1. Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”,
-- o que tengan un título que empiece con “Sales”.

select ClienteID, Pais, Titulo from clientes
where pais in ("Brazil", "Mexico") or Titulo like "Sales%";

-- 2. Obtener un listado de todos los clientes que pertenecen a una compañía
-- que empiece con la letra "A".

select ClienteID, Compania from clientes
where Compania like "A%";

-- 3. Obtener un listado con los datos: Ciudad, Contacto y renombrarlo
-- como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos
-- los clientes que sean de la ciudad "Madrid".

select Ciudad as Apellido, Contacto as Nombre, Titulo as Puesto, ciudad from clientes
where Ciudad = "Madrid";

-- 4. Obtener un listado de todas las facturas con ID entre 10000 y 10500

select FacturaID from facturas
where FacturaID between 10000 and 10500;

-- 5. Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de
-- los clientes con ID que empiecen con la letra “B”.

select FacturaID, ClienteID from facturas
where FacturaID between 10000 and 10500 or ClienteID like "B%";

-- 6. ¿Existen facturas que la ciudad de envío sea “Vancouver” o que
-- utilicen el correo 3?

select FacturaID, CiudadEnvio, EnvioVia from facturas
where CiudadEnvio = "Vancouver" or EnvioVia = 3;

-- 7. ¿Cuál es el ID de empleado de “Buchanan”?

select EmpleadoID from empleados
where nombre or Apellido like "%Buchanan%";

-- 8. ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior?
--  (No relacionar, sino verificar que existan facturas)

select EmpleadoID from facturas
where EmpleadoID = 5;

