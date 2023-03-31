-- 1. Se realizaron reservas de hoteles en la ciudad de Nápoles que se pagaron a
-- través de tarjetas de crédito y queremos conocer los datos de la tarjeta (el
-- nombre del titular, número y entidad que emite la tarjeta), nombre del hotel y la
-- fecha de checkin.

SELECT tarjeta.idtarjeta, tarjeta.nombre_titular, tarjeta.numero, entidad_finaciera.nombre as NombreBanco, hoteles.nombre as NombreHotel, hotelesxreserva.checkin from tarjeta 
INNER JOIN entidad_finaciera ON tarjeta.identidad = entidad_finaciera.identidad
INNER JOIN pagos ON tarjeta.idtarjeta = pagos.idtarjeta
INNER JOIN reservas ON pagos.idpago = reservas.idpago
INNER JOIN hotelesxreserva ON reservas.idreserva = hotelesxreserva.idReserva
INNER JOIN hoteles ON hotelesxreserva.idHotel = hoteles.idhotel
WHERE hoteles.ciudad = "Napoles" AND pagos.idMetodosPago = 3;

-- 2. Listar el número de pago (idpago), la cantidad de cuotas, el número de tarjeta, nombre y país de la entidad financiera de todas las reservas realizadas con
-- tarjeta de crédito teniendo en cuenta que el precio no supere los 1500.

SELECT pagos.idpago, pagos.cantidadCuotas, tarjeta.numero as NumeroTarjeta, entidad_finaciera.nombre AS NombreEntidad, paises.nombre from pagos 
INNER JOIN tarjeta ON pagos.idtarjeta = tarjeta.idtarjeta 
INNER JOIN entidad_finaciera ON tarjeta.identidad = entidad_finaciera.identidad
INNER JOIN paises ON entidad_finaciera.idPais = paises.idpais
WHERE precioTotal >= 1500 and pagos.idMetodosPago = 3;

-- 3. Mostrar por cada entidad financiera la cantidad de pagos realizados. Se pide visualizar el nombre de la entidad financiera y el total.

SELECT entidad_finaciera.nombre, count(idpago) AS TotalPagosRealizados from pagos
INNER JOIN tarjeta ON pagos.idpago = tarjeta.idtarjeta
INNER JOIN entidad_finaciera ON tarjeta.identidad = entidad_finaciera.identidad
group by entidad_finaciera.nombre;

-- 4. Listar las reservas de los clientes cuyo pago lo hicieron a través de tarjeta de crédito, se pide mostrar el nombre, apellido, país y el método de pago.

SELECT reservas.idreserva, clientes.nombres, clientes.apellidos, clientes.idPais, pagos.idMetodosPago from reservas 
INNER JOIN pagos ON reservas.idPago = pagos.idpago
INNER JOIN clientes ON reservas.idCliente = clientes.idcliente
WHERE pagos.idMetodosPago = 3;

-- 6. Listar el nombre, apellido, número de pasaporte,ciudad y nombre del país de los clientes de origen Peruano.

select c.nombres, c.apellidos, c.numeroPasaporte, c.ciudad, c.idPais, p.nombre  from clientes c
left join paises p on p.idpais = c.idPais
where p.nombre = "Peru";

-- 7. Listar la cantidad de reservas realizadas de acuerdo al método de pago y el nombre completo del cliente.

-- NOTA EN UN COMPUTADOR ANDA Y EN EL MIO NO :(

select concat(c.nombres, ' ', c.apellidos) as nombre_completo, count(r.idreserva), p.idMetodosPago FROM clientes as c
JOIN reservas as r
ON c.idcliente = r.idCliente
JOIN pagos as p
ON r.idPago = p.idpago
group by nombre_completo, p.idMetodosPago;

-- 8. Mostrar la cantidad de clientes por país, se necesita visualizar el nombre del país y la cantidad de clientes.

SELECT count(c.idcliente) as cantidad_clientes, p.nombre FROM clientes as c
left JOIN paises p ON c.idPais = p.idPais
group by p.nombre;

-- 9)

SELECT clientes.nombres, clientes.apellidos, clientes.numeroPasaporte, tarjeta.vencimiento from tarjeta
INNER JOIN pagos ON tarjeta.idtarjeta = pagos.idtarjeta
INNER JOIN reservas ON pagos.idpago = reservas.idpago
INNER JOIN clientes ON reservas.idCliente = clientes.idcliente
WHERE ciudad.clientes = "Medellin" AND pagos.idMetodosPago = 3;

--  10. Mostrar por cada método de pago el monto total obtenido,se pide visualizar el nombre del método de pago y el total.

SELECT m.nombre, SUM(precioTotal) FROM pagos p
LEFT JOIN metodospago m ON m.idmetodospago = p.idmetodospago
GROUP BY m.nombre;

-- 11. Mostrar la suma de los pagos realizados en la sucursal de Mendoza, llamar al resultado “TOTAL MENDOZA”.

SELECT SUM(pagos.precioTotal) AS "TOTAL MENDOZA" FROM pagos
INNER JOIN reservas ON pagos.idpago = reservas.idPago
INNER JOIN sucursales ON reservas.idSucursal = sucursales.idSucursal where sucursales.idSucursal = 1;

-- 14-Listar el nombre y cantidad de habitaciones de aquellos hoteles que tengan de 30 a 70 habitaciones pertenecientes al país Argentina.
select h.nombre, h.cantidadHabitaciones from hoteles h 
inner join paises p on h.idPais=p.idPais
where h.cantidadHabitaciones>=30 and h.cantidadHabitaciones<=70 and p.nombre='Argentina';

-- 15-Listar el top 10 de hoteles más utilizados y la cantidad de reservas en las que ha sido reservado.

SELECT h.nombre_hotel, COUNT(*) AS cantidad_reservas FROM reservas r
JOIN hoteles h ON r.id_hotel = h.id_hotel
GROUP BY r.id_hotel 
ORDER BY COUNT(*) DESC 
LIMIT 10;

SELECT h.nombre_hotel, COUNT(*) AS cantidad_reservas FROM reservas r 
inner JOIN hoteles h ON hr.id_hotel = h.id_hotel and hr.ifReserva=r.idReserva
GROUP BY h.id_hotel 
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 16-  Listar los clientes (nombre y apellido) y cuáles han sido los medios de pago que han utilizado, esta lista deberá estar ordenada por apellidos de manera ascendente.
SELECT c.nombres, c.apellidos, p.metodospago FROM clientes c
JOIN pedidos p ON c.idcliente = p.idcliente
ORDER BY c.apellidos ASC;

-- 17. Listar la cantidad de reservas que se realizaron para los vuelos que el origen ha
-- sido de Argentina o Colombia, en el horario de las 18hs. Mostrar la cantidad de
-- vuelos y país de origen.

select count(r.idreserva) as totalReservas, v.origen from vuelosxreserva vxr
left join vuelos v on v.idvuelo = vxr.idVuelo
left join reservas r on r.idreserva = vxr.idReserva
where v.origen = "Argentina" or v.origen = "Colombia" and time (v.fechaPartida) = "18:00:00"
group by v.origen;

-- 18. Mostrar los totales de ventas de sucursales por países y ordenarlas de mayor a
-- menor.


select sum(p.precioTotal) as TotalVentas, pa.nombre from reservas r
left join pagos p on p.idpago = r.idPago
left join sucursales s on s.idSucursal = r.idSucursal
left join paises pa on pa.idpais = s.idPais
group by pa.nombre
order by TotalVentas desc;

-- 19. Mostrar los países que no tienen clientes asignados ordenados por los que
-- empiezan por Z primero.

select * from paises;

select p.nombre from clientes c
right join paises p on p.idpais = c.idPais
where c.nombres is null
order by p.nombre desc;

-- 20. Generar un listado con los hoteles que tuvieron más de 2 reservas realizadas.
-- Mostrar el nombre del hotel y la cantidad.

select * from reservas;

select count(r.idReserva) as TotalReservas ,h.nombre from hoteles h
left join hotelesxreserva hxr on hxr.idHotel = h.idhotel
left join reservas r on r.idreserva = hxr.idReserva
group by h.nombre
having TotalReservas > 2;




-- 9. Listar todos los clientes de la ciudad de Medellín que reservaron vuelos a través de tarjeta de crédito. Solo listar las tarjetas que tienen como vencimiento el año
-- 2029. Mostrar nombre, apellido, número de pasaporte del cliente y el año de
-- vencimiento de la tarjeta.

-- 15. Listar el top 10 de hoteles más utilizados y la cantidad de reservas en las que ha
-- sido reservado.

select h.nombre, count(hxr.idReserva) as TotalReservas from reservas r
left join hotelesxreserva hxr on hxr.idReserva = r.idreserva
left join hoteles h on h.idhotel = hxr.idHotel
group by h.nombre
order by TotalReservas desc
limit 10;
